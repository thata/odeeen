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
    input logic [31:0] mem_rdata
);

    //------------------------
    // デバッグ用モニタ
    //------------------------
    initial begin
        $monitor(
            "%t: pc = %h, stage = %d, instr = %h, imm = %h, mem_valid = %b, mem_ready = %b, mem_addr = %h, mem_wdata = %h, mem_wstrb = %b, mem_rdata = %h",
            $time,
            pc_reg,
            stage_reg,
            instr_reg,
            imm,
            mem_valid_reg,
            mem_ready,
            mem_addr_reg,
            mem_wdata_reg,
            mem_wstrb_reg,
            mem_rdata
        );
    end

    // デコーダ
    // 命令をデコードして制御信号を生成する
    decoder decoder_inst(
        .instr(instr_reg),
        .memWrite(dc_mem_write),
        .regWrite(dc_reg_write),
        .aluIn1Src(alu_in1_src),
        .aluIn2Src(alu_in2_src),
        .aluOp(alu_op),
        .memToReg(dc_mem_to_reg),
        .branch(branch),
        .jump(jump),
        .jumpReg(jump_reg)
    );

    // 即値生成器
    // 命令から即値を取り出す
    immgen immgen_inst(
        .instr(instr_reg),
        .imm(imm)
    );

    // CPU ステージ
    //  if_stage: 命令フェッチステージ
    //  ex_stage: 実行ステージ
    typedef enum { IF_STAGE, EX_STAGE, ERR_STAGE } stage_t;
    stage_t stage_reg, stage_next;

    // プログラムカウンタ
    logic [31:0] pc_reg, pc_next;

    // フェッチした命令
    logic [31:0] instr_reg, instr_next;

    // メモリバス
    logic mem_valid_reg, mem_valid_next;
    logic [31:0] mem_addr_reg, mem_addr_next;
    logic [31:0] mem_wdata_reg, mem_wdata_next;
    logic [3:0] mem_wstrb_reg, mem_wstrb_next;

    // 制御信号
    logic dc_mem_write;
    logic dc_reg_write;
    logic alu_in1_src;
    logic alu_in2_src;
    logic [3:0] alu_op;
    logic dc_mem_to_reg;
    logic branch;
    logic jump;
    logic jump_reg;

    // 即値
    logic [31:0] imm;

    assign mem_valid = mem_valid_reg;
    assign mem_addr = mem_addr_reg;
    assign mem_wdata = mem_wdata_reg;
    assign mem_wstrb = mem_wstrb_reg;
    assign mem_instr = (stage_reg == IF_STAGE);

    always_ff @(posedge clk) begin
        if (!reset_n) begin
            stage_reg = IF_STAGE;
            pc_reg = 32'h00000000;
            instr_reg = 32'h00000000;
            mem_valid_reg = 0;
            mem_addr_reg = 32'h00000000;
            mem_wdata_reg = 32'h00000000;
            mem_wstrb_reg = 4'b0000;
        end else begin
            stage_reg <= stage_next;
            pc_reg <= pc_next;
            instr_reg <= instr_next;
            mem_valid_reg <= mem_valid_next;
            mem_addr_reg <= mem_addr_next;
            mem_wdata_reg <= mem_wdata_next;
            mem_wstrb_reg <= mem_wstrb_next;
        end
    end

    always_comb begin
        stage_next = stage_reg;
        pc_next = pc_reg;
        instr_next = instr_reg;
        mem_valid_next = mem_valid_reg;
        mem_addr_next = mem_addr_reg;
        mem_wdata_next = mem_wdata_reg;
        mem_wstrb_next = mem_wstrb_reg;

        case (stage_reg)
            IF_STAGE: begin
                mem_addr_next = pc_reg;
                mem_valid_next = 1;
                if (mem_valid_reg && mem_ready) begin
                    mem_valid_next = 0;     // 命令のフェッチが終わったので VALID をデアサート
                    instr_next = mem_rdata; // フェッチした命令をレジスタへ格納
                    stage_next = EX_STAGE;  // 実行ステージへ
                end
            end
            EX_STAGE: begin
                stage_next = IF_STAGE; // 命令フェッチステージへ

                if (jump) begin
                    pc_next = pc_reg + imm;
                end else begin
                    // NOP
                    pc_next = pc_reg + 4;
                end
            end
            default: begin
                // 想定外のデータが来た場合
                stage_next = ERR_STAGE;
            end
        endcase
    end
endmodule

module decoder(
    input logic [31:0] instr,
    output logic memWrite,
    output logic regWrite,
    output logic aluIn1Src,
    output logic aluIn2Src,
    output logic [3:0] aluOp,
    output logic memToReg,
    output logic branch,
    output logic jump,
    output logic jumpReg
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

    assign memWrite = (opCode === 7'b0100011) ? 1'b1 : 1'b0;

    assign regWrite = (opCode === 7'b0000011) ? 1'b1 : // lw
                      (opCode === 7'b0010011) ? 1'b1 : // addi, ori
                      (opCode === 7'b0110011) ? 1'b1 : // R type (add)
                      (opCode === 7'b0110111) ? 1'b1 : // lui
                      (opCode === 7'b1101111) ? 1'b1 : // jal
                      (opCode === 7'b1100111) ? 1'b1   // jalr
                                              : 1'b0;

    // select alu.in1 src
    // 0: 32'b0
    // 1: ds1
    assign aluIn1Src = (opCode === 7'b0110111) ? 1'b0 // lui
                                               : 1'b1;

    // select alu.in2 src
    // 0: imm
    // 1: ds2 (B, R type)
    assign aluIn2Src = (opCode === 7'b0110011) ? 1'b1 : // R type
                    (opCode === 7'b1100011) ? 1'b1   // B type
                                            : 1'b0;

    assign memToReg = (opCode == 7'b0000011) ? 1'b1 : 1'b0;

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
                      (opCode == 7'b0100011) ? 2'b00 : // sw => add
                      (opCode == 7'b1101111) ? 2'b00 : // jal => add
                      (opCode == 7'b1100111) ? 2'b00 : // jalr => add
                      (opCode == 7'b0110111) ? 2'b00 : // lui => add
                      (opCode == 7'b0010011) ? 2'b11   // addi, ori => funct3
                                             : 2'b10;  // funct

    // always @(*) begin
    //     $display("aluIn2Src %b", aluIn2Src);
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
                3'b110: aluOp = 4'b1000; // ori => or
                default: aluOp = 4'bXXXX;
            endcase
            default: case(funct)
                10'b0000000000: aluOp = 4'b0000; // add
                10'b0100000000: aluOp = 4'b0001; // sub
                10'b0000000111: aluOp = 4'b1001; // and
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

module immgen(
    input logic [31:0] instr,
    output logic [31:0] imm
);
    logic [6:0] opCode;
    logic [11:0] imm12;
    logic [12:0] imm13;
    logic [19:0] imm20;
    logic [20:0] imm21;

    assign opCode = instr[6:0];

    assign imm12 = (opCode == 7'b0100011) ? {instr[31:25], instr[11:7]} // S type
                                          : instr[31:20];               // other

    // B type
    assign imm13 = {instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};

    // J type
    assign imm21 = {instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};

    // U type
    assign imm20 = instr[31:12];

    // sign extend or shift
    assign imm = (opCode == 7'b0110111) ? {imm20, 12'b0} : // U type (lui)
                 (opCode == 7'b1100011) ? {{19{imm13[12]}}, imm13} :
                 (opCode == 7'b1101111) ? {{11{imm21[20]}}, imm21}
                                        : {{20{imm12[11]}}, imm12};

    // always @(imm) begin
    //     $display("instr %b", instr);
    //     $display("imm12 %b", imm12);
    //     $display("imm13 %b", imm13);
    //     $display("imm21 %b", imm21);
    //     $display("imm %b", imm);
    // end
endmodule
