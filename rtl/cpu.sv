`ifndef __INSTRUCTIONS__
`include "instructions.sv"
`endif

module cpu(
    input logic clk,
    input logic reset_n,

    // PicoRV32 Native Memory Interface
    output logic mem_valid,
    output logic mem_instr,
    input logic mem_ready,
    output logic [31:0] mem_addr,
    output logic [31:0] mem_wdata,
    output logic [3:0] mem_wstrb,
    input logic [31:0] mem_rdata,

    output logic [31:0] peek
);

    // デバッグ用の信号線
    // 今は PC の値を出力しているが、必要に応じて変更して良い
    assign peek = pc_reg;


    //-------------------------------------
    // デバッグ用モニタ
    //-------------------------------------
    initial begin
        // デバッグ用モニタ
        // $monitor(
        //     "%t: pc = %h, stage = %d, instr = %h, mem_valid = %b, mem_ready = %b, mem_addr = %h, mem_wdata = %h, mem_wstrb = %b, mem_rdata = %h",
        //     $time,
        //     pc_reg,
        //     stage_reg,
        //     instr_reg,
        //     mem_valid,
        //     mem_ready,
        //     mem_addr,
        //     mem_wdata,
        //     mem_wstrb,
        //     mem_rdata
        // );
    end

    //-------------------------------------
    // CPU ステージ
    //  IF_STAGE: 命令フェッチ
    //  EX_STAGE: 実行
    //  MEM_STAGE: メモリアクセス
    //  WB_STAGE: レジスタ書き戻し（writeback)
    //  ERR_STAGE: エラー
    //-------------------------------------
    typedef enum {
        IF_STAGE,
        EX_STAGE,
        FP1_STAGE, // FPU へ入力を渡す
        FP2_STAGE, // FPU からの出力を待機
        FP3_STAGE, // FPU の出力をレジスタへ保存
        MEM_STAGE,
        WB_STAGE,
        ERR_STAGE
    } stage_t;
    stage_t stage_reg, stage_next;

    logic [31:0] pc_reg, pc_next;                 // PC
    logic [31:0] instr_reg, instr_next;           // フェッチした命令
    logic [31:0] mem_rdata_reg, mem_rdata_next;   // lw でメモリから読み込んだデータ
    logic [31:0] fpu_result_reg, fpu_result_next; // FPU の演算結果

    //-------------------------------------
    // 出力信号
    //-------------------------------------
    assign mem_valid = (stage_reg == IF_STAGE || stage_reg == MEM_STAGE) ? 1'b1 : 1'b0; // メモリの読み書きを行う場合、アドレスを指定すると共に VALID 信号をアサート
    assign mem_instr = (stage_reg == IF_STAGE) ? 1'b1 : 1'b0;   // 今回はこの信号を使わないけど、念のため実装しておく
    assign mem_addr = (stage_reg == IF_STAGE)  ? pc_reg :       // 命令フェッチの場合
                      (stage_reg == MEM_STAGE) ? alu_result     // lw または sw の場合
                                               : 32'h00000000;
    assign mem_wdata = (stage_reg == MEM_STAGE && dc_mem_write) ? rf_read_data2 // sw の場合
                                                                : 32'h00000000;
    assign mem_wstrb = (stage_reg == MEM_STAGE && dc_mem_write) ? 4'b1111  // メモリ書き込み
                                                                : 4'b0000; // メモリ読み込み

    //-------------------------------------
    // デコーダ
    // 命令をデコードして制御信号を生成する
    //-------------------------------------
    logic dc_mem_write;
    logic dc_reg_write;
    logic [1:0] alu_in1_src;
    logic alu_in2_src;
    logic [3:0] alu_op;
    logic [3:0] fpu_op;
    logic dc_mem_to_reg;
    logic dc_reg_to_reg;
    logic branch;
    logic jump;
    logic jump_reg;
    logic read_reg_type1;
    logic read_reg_type2;
    logic write_reg_type;
    logic fpu;

    decoder decoder_inst(
        .instr(instr_reg),
        .memWrite(dc_mem_write),
        .regWrite(dc_reg_write),
        .aluIn1Src(alu_in1_src),
        .aluIn2Src(alu_in2_src),
        .aluOp(alu_op),
        .fpuOp(fpu_op),
        .memToReg(dc_mem_to_reg),
        .regToReg(dc_reg_to_reg),
        .branch(branch),
        .jump(jump),
        .jumpReg(jump_reg),
        .readRegType1(read_reg_type1),
        .readRegType2(read_reg_type2),
        .writeRegType(write_reg_type),
        .fpu(fpu)
    );

    //-------------------------------------
    // 即値生成器
    // 命令から即値を取り出す
    //-------------------------------------
    logic [31:0] imm;

    immgen immgen_inst(
        .instr(instr_reg),
        .imm(imm)
    );

    //-------------------------------------
    // ALU
    //-------------------------------------
    logic [31:0] alu_in1, alu_in2, alu_result;
    logic alu_negative, alu_zero;

    assign alu_in1 = (alu_in1_src === 2'b00) ? 32'b0 :          // lui
                     (alu_in1_src === 2'b01) ? rf_read_data1 :  // それ以外
                     (alu_in1_src === 2'b10) ? pc_reg           // auipc
                                             : 32'b0;
    assign alu_in2 = (alu_in2_src) ? rf_read_data2 : imm;

    alu alu_inst(
        .in1(alu_in1),
        .in2(alu_in2),
        .op(alu_op),
        .result(alu_result),
        .negative(alu_negative),
        .zero(alu_zero)
    );

    //-------------------------------------
    // FPU
    //-------------------------------------

    logic [31:0] fpu_in1, fpu_in2, fpu_result;
    logic fpu_in1_stb, fpu_in2_stb, fpu_result_ack;
    logic fpu_in1_ack, fpu_in2_ack, fpu_result_stb;

    assign fpu_in1 = rf_read_data1;
    assign fpu_in2 = rf_read_data2;

    assign fpu_in1_stb = (stage_reg == FP1_STAGE || stage_reg == FP2_STAGE) ? 1'b1 : 1'b0;
    assign fpu_in2_stb = (stage_reg == FP1_STAGE || stage_reg == FP2_STAGE) ? 1'b1 : 1'b0;
    assign fpu_result_ack = (stage_reg == FP3_STAGE) ? 1'b1 : 1'b0;

    fpu_controller fpu_inst(
        .clk(clk),
        .reset_n(reset_n),
        .op(fpu_op),
        .in1(fpu_in1),
        .in2(fpu_in2),
        .in1_stb(fpu_in1_stb),
        .in2_stb(fpu_in2_stb),
        .in1_ack(fpu_in1_ack),
        .in2_ack(fpu_in2_ack),
        .out(fpu_result),
        .out_stb(fpu_result_stb),
        .out_ack(fpu_result_ack)
    );

    //-------------------------------------
    // 条件分岐判定ユニット
    //-------------------------------------
    logic branch_result;
    logic [2:0] branch_funct3;

    assign branch_funct3 = instr_reg[14:12];

    branch_unit branch_unit_inst(
        .in1(rf_read_data1),
        .in2(rf_read_data2),
        .funct3(branch_funct3),
        .result(branch_result)
    );

    //-------------------------------------
    // Register File
    //-------------------------------------
    logic rf_we3;
    logic [4:0] rf_addr1, rf_addr2, rf_addr3;
    logic [31:0] rf_write_data3, rf_read_data1, rf_read_data2;

    assign rf_addr1 = instr_reg[19:15]; // rs1
    assign rf_addr2 = instr_reg[24:20]; // rs2
    assign rf_addr3 = instr_reg[11:7];  // rd
    assign rf_we3 = (stage_reg == WB_STAGE) && dc_reg_write;
    assign rf_write_data3 = (dc_mem_to_reg) ? mem_rdata_reg :  // lw の場合
                            (dc_reg_to_reg) ? rf_read_data1 :  // fmv.x.w, fmv.w.x の場合
                            (jump)          ? pc_reg + 4 :     // jal, jalr の場合
                            (fpu === 1'b1)  ? fpu_result_reg   // FPU の演算結果
                                            : alu_result;

    regfile regfile_inst(
        .clk(clk),
        .reset_n(reset_n),
        .we3(rf_we3),
        .addr1(rf_addr1),
        .addr2(rf_addr2),
        .addr3(rf_addr3),
        .writeData3(rf_write_data3),
        .readRegType1(read_reg_type1),
        .readRegType2(read_reg_type2),
        .writeRegType(write_reg_type),
        .readData1(rf_read_data1),
        .readData2(rf_read_data2)
    );


    always_ff @(posedge clk) begin
        if (!reset_n) begin
            stage_reg <= IF_STAGE;
            pc_reg <= 0;
            instr_reg <= 32'h00000000;
            mem_rdata_reg <= 32'h00000000;
            fpu_result_reg <= 32'h00000000;
        end else begin
            stage_reg <= stage_next;
            pc_reg <= pc_next;
            instr_reg <= instr_next;
            mem_rdata_reg <= mem_rdata_next;
            fpu_result_reg <= fpu_result_next;
        end
    end

    always_comb begin
        // デフォルト値
        stage_next = stage_reg;
        instr_next = instr_reg;
        mem_rdata_next = mem_rdata_reg;
        pc_next = pc_reg;
        fpu_result_next = fpu_result_reg;

        case (stage_reg)
            // 命令フェッチ
            IF_STAGE: begin
                if (mem_ready) begin
                    // メモリから命令を取得
                    instr_next = mem_rdata;
                    stage_next = EX_STAGE;
                end else begin
                    stage_next = IF_STAGE;
                end
            end
            // 実行
            EX_STAGE: begin
                if (fpu) begin
                    // 浮動小数点演算の場合
                    stage_next = FP1_STAGE;
                end else if (dc_mem_write) begin
                    // sw の場合
                    stage_next = MEM_STAGE;
                end else if (dc_mem_to_reg) begin
                    // lw の場合
                    stage_next = MEM_STAGE;
                end else begin
                    // メモリアクセスが不要な場合は、MEM_STAGE を飛ばして WB_STAGE へ遷移する
                    stage_next = WB_STAGE;
                end
            end
            // 浮動小数点演算1（FPUへ入力を渡す）
            FP1_STAGE: begin
                stage_next = FP2_STAGE;
            end
            // 浮動小数点演算2（FPUからの出力を待機）
            FP2_STAGE: begin
                if (fpu_result_stb) begin
                    stage_next = FP3_STAGE;
                end else begin
                    stage_next = FP2_STAGE;
                end
            end
            // 浮動小数点演算3（FPUの出力をレジスタへ保存）
            FP3_STAGE: begin
                // FPU の演算結果をレジスタに保存
                fpu_result_next = fpu_result;
                stage_next = MEM_STAGE;
            end
            // メモリアクセス
            MEM_STAGE: begin
                if (mem_ready) begin
                    // メモリからデータを取得
                    mem_rdata_next = mem_rdata;
                    stage_next = WB_STAGE;
                end else begin
                    stage_next = MEM_STAGE;
                end
            end
            // レジスタ書き戻し
            WB_STAGE: begin
                pc_next = (branch && branch_result) ? pc_reg + imm :
                          (jump_reg)           ? alu_result & 32'hfffffffe :
                          (jump)               ? pc_reg + imm
                                               : pc_reg + 4;
                stage_next = IF_STAGE;
            end
            ERR_STAGE: begin
                // エラー処理については後で考える
                stage_next = ERR_STAGE;
            end
        endcase
    end
endmodule

// 命令デコーダ
module decoder(
    input logic [31:0] instr,
    output logic memWrite,
    output logic regWrite,
    output logic [1:0] aluIn1Src,
    output logic aluIn2Src,
    output logic [3:0] aluOp,
    output logic [3:0] fpuOp,
    output logic memToReg,
    output logic regToReg,
    output logic branch,
    output logic jump,
    output logic jumpReg,
    output logic readRegType1,
    output logic readRegType2,
    output logic writeRegType,
    output logic fpu
);
    logic [6:0] opCode;
    logic [2:0] funct3;
    logic [6:0] funct7;

    // 00: ADD, 01: SUB, 10: Funct7 + Funct3, 11: Funct3
    logic [1:0] preAluOp;

    alu_controller ac(
        preAluOp,
        funct3,
        funct7,
        aluOp
    );

    assign opCode = instr[6:0];

    assign memWrite = (opCode === 7'b0100011) ? 1'b1 : // sw
                      (opCode === 7'b0100111) ? 1'b1   // fsw
                                              : 1'b0;

    assign regWrite = (opCode === 7'b0000011) ? 1'b1 : // lw
                      (opCode === 7'b0000111) ? 1'b1 : // flw
                      (opCode === 7'b0010011) ? 1'b1 : // addi, ori
                      (opCode === 7'b0110011) ? 1'b1 : // R type (add)
                      (opCode === 7'b1010011) ? 1'b1 : // RV32F R type
                      (opCode === 7'b0110111) ? 1'b1 : // lui
                      (opCode === 7'b0010111) ? 1'b1 : // auipc
                      (opCode === 7'b1101111) ? 1'b1 : // jal
                      (opCode === 7'b1100111) ? 1'b1   // jalr
                                              : 1'b0;

    // select alu.in1 src
    // 0: 32'b0
    // 1: ds1
    // 2: pc
    assign aluIn1Src = (opCode === 7'b0110111) ? 2'd0 : // lui
                       (opCode === 7'b0010111) ? 2'd2   // auipc
                                               : 2'd1;

    // select alu.in2 src
    // 0: imm
    // 1: ds2 (B, R type)
    assign aluIn2Src = (opCode === 7'b0110011) ? 1'b1 : // R type
                       (opCode === 7'b1100011) ? 1'b1   // B type
                                               : 1'b0;

    assign memToReg = (opCode == 7'b0000011) ? 1'b1 : // lw
                      (opCode == 7'b0000111) ? 1'b1   // flw
                                             : 1'b0;

    assign regToReg = (opCode == 7'b1010011 && funct7 == 7'b1110000) ? 1'b1 : // fmv.w.x
                      (opCode == 7'b1010011 && funct7 == 7'b1111000) ? 1'b1   // fmv.x.w
                                                                     : 1'b0;

    assign branch = (opCode === 7'b1100011) ? 1'b1 // B type
                                            : 1'b0;

    assign jump = (opCode === 7'b1101111) ? 1'b1 : // jal
                  (opCode === 7'b1100111) ? 1'b1   // jalr
                                          : 1'b0;

    assign jumpReg = (opCode === 7'b1100111) ? 1'b1 // jalr
                                             : 1'b0;

    assign funct3 = instr[14:12];
    assign funct7 = instr[31:25];
    assign preAluOp = (opCode == 7'b1100011) ? 2'b01 : // B type => sub
                      (opCode == 7'b0000011) ? 2'b00 : // lw => add
                      (opCode == 7'b0000111) ? 2'b00 : // flw => add
                      (opCode == 7'b0000111) ? 2'b00 : // flw => add
                      (opCode == 7'b0100011) ? 2'b00 : // sw => add
                      (opCode == 7'b0100111) ? 2'b00 : // fsw => add
                      (opCode == 7'b1101111) ? 2'b00 : // jal => add
                      (opCode == 7'b1100111) ? 2'b00 : // jalr => add
                      (opCode == 7'b0110111) ? 2'b00 : // lui => add
                      (opCode == 7'b0010111) ? 2'b00 : // auipc => add
                      (opCode == 7'b0010011) ? 2'b11   // addi, ori => funct3
                                             : 2'b10;  // funct

    // NOTE:
    // fcvt.s.w (int to float) の場合（opCode = 1010011, funct7 = 1101000）
    //   readRegType1 は 0 で、writeRegType は 1 になる
    // fcvt.w.s (float to int) の場合（opCode = 1010011, funct7 = 1100000）
    //   readRegType1 は 1 で、writeRegType は 0 になる
    // feq, flt, fle の場合（opCode = 1010011, funct7 = 1010000）
    //   writeRegType は 0 になる
    // fmv.w.x (f[rd] = x[rs1]) の場合（opCode = 1010011, funct7 = 1111000）
    //   readRegType1 は 0（整数レジスタ） で、writeRegType は 1（浮動小数点レジスタ） になる
    // fmv.x.w (x[rd] = f[rs1]) の場合（opCode = 1010011, funct7 = 1110000）
    //   readRegType1 は 1（浮動小数点レジスタ） で、writeRegType は 0（整数レジスタ） になる

    assign readRegType1 = (opCode === 7'b1010011 && funct7 === 7'b1101000) ? 1'b0 : // 整数レジスタを参照 (fcvt.s.w = int to float)
                          (opCode === 7'b1010011 && funct7 === 7'b1111000) ? 1'b0 : // 整数レジスタを参照 (fmv.w.x = f[rd] <- x[rs1])
                          (opCode === 7'b1010011)                          ? 1'b1   // 浮動小数点レジスタを参照 (fcvt.s.w 以外の RV32F の R-type 命令)
                                                                           : 1'b0;  // 整数レジスタを参照

    assign readRegType2 = (opCode === 7'b0100111) ? 1'b1 : // 浮動小数点レジスタを参照 (fsw)
                          (opCode === 7'b1010011) ? 1'b1   // 浮動小数点レジスタを参照（RV32F の R type）
                                                  : 1'b0;  // 整数レジスタを参照

    assign writeRegType = (opCode === 7'b0000111)                          ? 1'b1 : // 浮動小数点レジスタへ書き込み (flw)
                          (opCode === 7'b1010011 && funct7 === 7'b1100000) ? 1'b0 : // 整数レジスタへ書き込み (fcvt.w.s = float to int)
                          (opCode === 7'b1010011 && funct7 === 7'b1010000) ? 1'b0 : // 整数レジスタへ書き込み (feq, flt, fle)
                          (opCode === 7'b1010011 && funct7 === 7'b1110000) ? 1'b0 : // 整数レジスタへ書き込み (fmv.x.w)
                          (opCode === 7'b1010011)                          ? 1'b1   // 浮動小数点レジスタを参照（RV32F の R type）
                                                                           : 1'b0;  // 整数レジスタへ書き込み

    assign fpu = (opCode === 7'b1010011) ? 1'b1 : 1'b0;    // FPU を使う命令（RV32F R-type）

    assign fpuOp = (funct7 === 7'b0000000)                      ? 4'b0000 : // fadd
                   (funct7 === 7'b1101000)                      ? 4'b0100 : // fcvt.s.w (int to float)
                   (funct7 === 7'b1100000)                      ? 4'b0101 : // fcvt.w.s (float to int)
                   (funct7 === 7'b0010000 && funct3 === 3'b000) ? 4'b0110 : // fsgnj
                   (funct7 === 7'b0010000 && funct3 === 3'b001) ? 4'b0111 : // fsgnjn
                   (funct7 === 7'b1010000 && funct3 === 3'b010) ? 4'b1000 : // feq
                   (funct7 === 7'b1010000 && funct3 === 3'b001) ? 4'b1001 : // flt
                   (funct7 === 7'b1010000 && funct3 === 3'b000) ? 4'b1010 : // fle
                   (funct7 === 7'b0000100)                      ? 4'b0001 : // fsub
                   (funct7 === 7'b0001000)                      ? 4'b0010 : // fmul
                   (funct7 === 7'b0001100)                      ? 4'b0011   // fdiv
                                                                : 4'bxxxx;

    // always @(*) begin
    //     $display("opCode %b", opCode);
    //     $display("funct7 %b", funct7);
    //     $display("funct3 %b", funct3);
    //     $display("preAluOp %b", preAluOp);
    //     $display("aluOp %b", aluOp);
    // end
endmodule

// alu_controller
//
// preAluOp | case
// -------------------
// 00       | add
// 01       | sub
// 10       | funct7 + funct3
// 11       | funct3
module alu_controller(
    input logic [1:0] preAluOp,
    input logic [2:0] funct3,
    input logic [6:0] funct7,
    output logic [3:0] aluOp
);
    logic [9:0] funct;

    assign funct = {funct7, funct3};

    always_comb begin
        case(preAluOp)
            2'b00: aluOp = 4'b0000; // add
            2'b01: aluOp = 4'b0001; // sub
            2'b11: case(funct3)
                3'b000: aluOp = 4'b0000; // addi => add
                3'b001: aluOp = 4'b0010; // x slli => sll
                3'b010: aluOp = 4'b0011; // x slti => slt
                3'b011: aluOp = 4'b0100; // x sltiu => sltu
                3'b100: aluOp = 4'b0101; // x xori => xor
                3'b101: aluOp =
                  (funct7 === 7'h00) ? 4'b0110 : // x srli => srl
                  (funct7 === 7'h20) ? 4'b0111   // x srai => sra
                                     : 4'bxxxx;
                3'b110: aluOp = 4'b1000; // x ori => or
                3'b111: aluOp = 4'b1001; // x andi => and
                default: aluOp = 4'bXXXX;
            endcase
            default: case(funct)
                10'b0000000000: aluOp = 4'b0000; // add
                10'b0100000000: aluOp = 4'b0001; // sub
                10'b0000000111: aluOp = 4'b1001; // and
                10'b0000000100: aluOp = 4'b0101; // xor
                10'b0000000110: aluOp = 4'b1000; // or
                10'b0000000010: aluOp = 4'b0011; // slt
                10'b0000000011: aluOp = 4'b0100; // sltu
                10'b0000000001: aluOp = 4'b0010; // sll
                10'b0000000101: aluOp = 4'b0110; // srl
                10'b0100000101: aluOp = 4'b0111; // sra
                default: aluOp = 4'bXXXX;
            endcase
        endcase
    end
endmodule

// 即値生成器
//  命令列から即値を取り出す
module immgen(
    input logic [31:0] instr,
    output logic [31:0] imm
);
    logic [6:0] opCode;
    logic [2:0] funct3;
    logic [4:0] imm5;
    logic [11:0] imm12;
    logic [12:0] imm13;
    logic [19:0] imm20;
    logic [20:0] imm21;

    assign opCode = instr[6:0];
    assign funct3 = instr[14:12];

    assign imm5 = instr[24:20];

    assign imm12 = (opCode == 7'b0100011) ? {instr[31:25], instr[11:7]} : // sw
                   (opCode == 7'b0100111) ? {instr[31:25], instr[11:7]}   // fsw
                                          : instr[31:20];                 // other

    // B type
    assign imm13 = {instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};

    // J type
    assign imm21 = {instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};

    // U type
    assign imm20 = instr[31:12];

    // sign extend or shift
    assign imm = (opCode === 7'b0110111) ? {imm20, 12'b0} : // U type (lui)
                 (opCode === 7'b0010111) ? {imm20, 12'b0} : // U type (auipc)
                 (opCode === 7'b1100011) ? {{19{imm13[12]}}, imm13} :
                 (opCode === 7'b1101111) ? {{11{imm21[20]}}, imm21} :
                 (opCode === 7'b0010011 && funct3 === 3'h1) ? {{27{imm5[4]}}, imm5} : // slli
                 (opCode === 7'b0010011 && funct3 === 3'h5) ? {{27{imm5[4]}}, imm5}   // srli, srai
                                        : {{20{imm12[11]}}, imm12};

    // always @(imm) begin
    //     $display("instr %b", instr);
    //     $display("imm12 %b", imm12);
    //     $display("imm13 %b", imm13);
    //     $display("imm21 %b", imm21);
    //     $display("imm %b", imm);
    // end
endmodule

// ALU
//
// code | operations
// ------------------
// 0000 | add
// 0001 | sub
// 0010 | sll
// 0011 | slt
// 0100 | sltu
// 0101 | xor
// 0110 | srl
// 0111 | sra
// 1000 | or
// 1001 | and
// ------------------
module alu(
    input logic [31:0] in1, in2,
    input logic [3:0] op,
    output logic [31:0] result,
    output logic negative, zero
);
    logic [31:0] sraResult;
    logic [31:0] sltResult;
    logic [31:0] sltuResult;

    assign sraResult = $signed(in1) >>> in2;
    assign sltResult = ($signed(in1) < $signed(in2)) ? 32'b1 : 32'b0;
    assign sltuResult = (in1 < in2) ? 32'b1 : 32'b0;

    assign result = (op === 4'b0000) ? (in1 + in2)  :  // plus
                    (op === 4'b0001) ? (in1 - in2)  :  // minus
                    (op === 4'b1001) ? (in1 & in2)  :  // and
                    (op === 4'b1000) ? (in1 | in2)  :  // or
                    (op === 4'b0101) ? (in1 ^ in2)  :  // xor
                    (op === 4'b0010) ? (in1 << in2) :  // sll (shift left logical)
                    (op === 4'b0110) ? (in1 >> in2) :  // srl (shift right logical)
                    (op === 4'b0111) ? sraResult    :  // sra (shift right arithmetic)
                    (op === 4'b0011) ? sltResult    :  // slt
                    (op === 4'b0100) ? sltuResult      // sltu
                                    : 32'hxxxxxxxx;
    assign negative = result[31];
    assign zero = ~|result;

    // always @(*) begin
    //     $display("op %b", op);
    //     $display("in1 %b", in1);
    //     $display("in2 %b", in2);
    //     $display("result %b", result);
    //     $display("zero %b", zero);
    // end
endmodule


// 条件分岐判定ユニット
//
// funct3 | operation
// ------------------
// 000    | beq (===)
// 001    | bne (!==)
// 100    | blt (signed <)
// 101    | bge (signed >=)
// 110    | bltu (unsigned <)
// 111    | bgeu (unsigned >=)
// ------------------
module branch_unit(
    input logic [31:0] in1, in2,
    input logic [2:0] funct3,
    output logic result
);
    assign result = (funct3 == 3'b000) ? (in1 === in2) : // beq
                    (funct3 == 3'b001) ? (in1 !== in2) : // bne
                    (funct3 == 3'b100) ? ($signed(in1) < $signed(in2)) : // blt
                    (funct3 == 3'b101) ? ($signed(in1) >= $signed(in2)) : // bge
                    (funct3 == 3'b110) ? (in1 < in2) :   // bltu
                    (funct3 == 3'b111) ? (in1 >= in2)    // bgeu
                                       : 1'b0;
endmodule


// Register File
module regfile(
    input logic clk,
    input logic reset_n,
    input logic we3,
    input logic [4:0] addr1, addr2, addr3,
    input logic [31:0] writeData3,
    input logic readRegType1,  // 0: 整数レジスタ, 1: 浮動小数点レジスタ
    input logic readRegType2,  // 0: 整数レジスタ, 1: 浮動小数点レジスタ
    input logic writeRegType,  // 0: 整数レジスタ, 1: 浮動小数点レジスタ
    output logic [31:0] readData1, readData2
);
    logic [31:0] intReadData1, intReadData2;
    logic [31:0] fpReadData1, fpReadData2;

    // 整数レジスタ
    logic [31:0] registers [0:31];

    // 浮動小数点レジスタ
    logic [31:0] fpRegisters [0:31];

    // $0 へは書き込めるけど参照しても常に 0 が返る
    assign intReadData1 = (addr1 === 5'b0) ? 32'b0 : registers[addr1];
    assign intReadData2 = (addr2 === 5'b0) ? 32'b0 : registers[addr2];

    assign fpReadData1 = fpRegisters[addr1];
    assign fpReadData2 = fpRegisters[addr2];

    // readRegType が 0 の場合は整数レジスタ、1 の場合は浮動小数点レジスタを参照する
    assign readData1 = (readRegType1 === 1'b0) ? intReadData1 :
                       (readRegType1 === 1'b1) ? fpReadData1
                                              : 32'hxxxxxxxx;
    assign readData2 = (readRegType2 === 1'b0) ? intReadData2 :
                       (readRegType2 === 1'b1) ? fpReadData2
                                              : 32'hxxxxxxxx;

    always_ff @(posedge clk) begin
        if (!reset_n) begin
            for (int i = 0; i < 32; i++) begin
                registers[i] <= 32'b0;
                fpRegisters[i] <= 32'b0;
            end
        end else if (we3) begin
            // writeRegType が 0 の場合は整数レジスタ、1 の場合は浮動小数点レジスタに書き込む
            case (writeRegType)
                1'b0: registers[addr3] <= writeData3;
                1'b1: fpRegisters[addr3] <= writeData3;
            endcase
        end
    end

    always @(*) begin
        // $display("x1 %d", registers[1]);
        // $display("x2 %d", registers[2]);
        // $display("x3 %d", registers[3]);
        // $display("x7 %d", registers[5]);
        // $display("x10 %d", registers[10]);
        // $display("$2 %b", registers[2]);
        // $display("$30 %b", registers[30]);
        // $display("$31 %b", registers[31]);
        // $display("f5 %d", fpRegisters[5]);
        // $display("f6 %d", fpRegisters[6]);
        // $display("f7 %d", fpRegisters[7]);
    end
endmodule
