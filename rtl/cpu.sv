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
        // $monitor(
        //     "%t: pc = %h, stage = %d, instr = %h, mem_valid = %b, mem_ready = %b, mem_addr = %h, mem_wdata = %h, mem_wstrb = %b, mem_rdata = %h",
        //     $time,
        //     pc_reg,
        //     stage_reg,
        //     instr_reg,
        //     mem_valid_reg,
        //     mem_ready,
        //     mem_addr_reg,
        //     mem_wdata_reg,
        //     mem_wstrb_reg,
        //     mem_rdata
        // );
    end

    // CPU ステージ
    //  if_stage: 命令フェッチステージ
    //  ex_stage: 実行ステージ
    typedef enum { IF_STAGE, EX_STAGE } stage_t;
    stage_t stage_reg, stage_next;

    logic [31:0] pc_reg, pc_next; // プログラムカウンタ
    logic [31:0] instr_reg, instr_next; // フェッチした命令
    logic mem_valid_reg, mem_valid_next;
    logic [31:0] mem_addr_reg, mem_addr_next;
    logic [31:0] mem_wdata_reg, mem_wdata_next;
    logic [3:0] mem_wstrb_reg, mem_wstrb_next;

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
    end

endmodule
