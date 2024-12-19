//------------------------------------------------------------------
// ULX3S 上で Odeeen CPU を動かすためのトップモジュール
//------------------------------------------------------------------
module ulx3s_top(
    input wire clk_25mhz,
    input wire [6:0] btn,
    output wire [7:0] led
);
    logic clk, reset_n;
    logic mem_valid, mem_ready, mem_instr;
    logic [31:0] mem_addr, mem_wdata, mem_rdata;
    logic [3:0] mem_wstrb;

    // 外部信号線との接続
    assign clk = clk_25mhz;
    assign reset_n = btn[0]; // btn[0] は押すとデアサートされる
    assign led = mem_addr[7:0];

    // CPU のインスタンス
    cpu cpu_inst(
        .clk(clk),
        .reset_n(reset_n),
        .mem_valid(mem_valid),
        .mem_instr(mem_instr),
        .mem_ready(mem_ready),
        .mem_addr(mem_addr),
        .mem_wdata(mem_wdata),
        .mem_wstrb(mem_wstrb),
        .mem_rdata(mem_rdata)
    );

    // メモリコントローラのインスタンス
    bram_controller ram (
        .clk(clk),
        .reset_n(reset_n),
        .mem_valid(mem_valid),
        .mem_ready(mem_ready),
        .mem_addr(mem_addr),
        .mem_wdata(mem_wdata),
        .mem_wstrb(mem_wstrb),
        .mem_rdata(mem_rdata)
    );

endmodule
