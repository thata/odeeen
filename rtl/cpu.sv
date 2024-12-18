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
    //-------------------------------------
    // デバッグ用モニタ
    //-------------------------------------
    initial begin
        // デバッグ用モニタ
        $monitor(
            "%t: pc = %h, stage = %d, instr = %h, mem_valid = %b, mem_ready = %b, mem_addr = %h, mem_wdata = %h, mem_wstrb = %b, mem_rdata = %h",
            $time,
            pc_reg,
            stage_reg,
            instr_reg,
            mem_valid,
            mem_ready,
            mem_addr,
            mem_wdata,
            mem_wstrb,
            mem_rdata
        );
    end

    // CPU ステージ
    //  IF_STAGE: 命令フェッチ
    //  EX_STAGE: 実行
    //  ERR_STAGE: エラー
    typedef enum {
        IF_STAGE,
        EX_STAGE,
        ERR_STAGE
    } stage_t;
    stage_t stage_reg, stage_next;

    logic [31:0] pc_reg, pc_next;       // PC
    logic [31:0] instr_reg, instr_next; // フェッチした命令

    // 出力信号
    assign mem_valid = (stage_reg == IF_STAGE) ? 1'b1 : 1'b0;
    assign mem_instr = (stage_reg == IF_STAGE) ? 1'b1 : 1'b0;
    assign mem_addr = (stage_reg == IF_STAGE) ? pc_reg : 32'h00000000;
    assign mem_wdata = 32'h00000000; // TODO
    assign mem_wstrb = 4'b0000; // TODO

    always_ff @(posedge clk) begin
        if (!reset_n) begin
            stage_reg <= IF_STAGE;
            pc_reg <= 0;
            instr_reg <= 32'h00000000;
        end else begin
            stage_reg <= stage_next;
            pc_reg <= pc_next;
            instr_reg <= instr_next;
        end
    end

    always_comb begin
        // デフォルト値
        stage_next = stage_reg;
        instr_next = instr_reg;
        pc_next = pc_reg;

        case (stage_reg)
            IF_STAGE: begin
                if (mem_ready) begin
                    instr_next = mem_rdata;
                    stage_next = EX_STAGE;
                end else begin
                    instr_next = instr_reg;
                    stage_next = IF_STAGE;
                end
            end
            EX_STAGE: begin
                if (instr_reg == 32'h0000006F) begin
                    // `j x0, 0` の場合は、現在のアドレスで無限ループ
                    pc_next = pc_reg + 0;
                end else begin
                    // それ以外の場合は次の命令へ
                    pc_next = pc_reg + 4;
                end

                stage_next = IF_STAGE;
            end
            ERR_STAGE: begin
                // エラー処理については後で考える
                stage_next = ERR_STAGE;
            end
        endcase
    end
endmodule
