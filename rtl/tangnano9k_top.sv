module tangnano9k_top (
    input wire clk,
    input wire uart_rx,
    output wire uart_tx,
    output wire [5:0] led,
    input wire btn_n0
);

    localparam SYSCLK = 27_000_000;

    //------------------------------------------------------------------
    // 外部信号線との接続
    //------------------------------------------------------------------
    assign clk = clk_27mhz;
    assign reset_n = btn_n0;

    assign led = led_ctl_mem_rdata[5:0];

    //------------------------------------------------------------------
    // CPU
    //------------------------------------------------------------------
    cpu cpu_inst(
        .clk(clk),
        .reset_n(reset_n),
        .mem_valid(mem_valid),
        .mem_instr(mem_instr),
        .mem_ready(mem_ready),
        .mem_addr(mem_addr),
        .mem_wdata(mem_wdata),
        .mem_wstrb(mem_wstrb),
        .mem_rdata(mem_rdata),
        .peek(peek)
    );

    logic clk, reset_n;
    logic mem_valid, mem_ready, mem_instr;
    logic [31:0] mem_addr, mem_wdata, mem_rdata;
    logic [3:0] mem_wstrb;

    // デバッグ用の信号線
    logic [31:0] peek;

    //------------------------------------------------------------------
    // メモリコントローラ
    //------------------------------------------------------------------
    bram_controller #(
        .FIRMWARE_PATH("firmware/firmware.hex")
    ) ram (
        .clk(clk),
        .reset_n(reset_n),
        .mem_valid(bram_en && mem_valid),
        .mem_ready(bram_mem_ready),
        .mem_addr(mem_addr),
        .mem_wdata(mem_wdata),
        .mem_wstrb(mem_wstrb),
        .mem_rdata(bram_mem_rdata)
    );

    logic bram_mem_ready;
    logic [31:0] bram_mem_rdata;

    //------------------------------------------------------------------
    // LED コントローラ
    //------------------------------------------------------------------
    led_controller led_ctl (
        .clk(clk),
        .reset_n(reset_n),
        .mem_valid(led_ctl_en && mem_valid),
        .mem_ready(led_ctl_mem_ready),
        .mem_addr(mem_addr),
        .mem_wdata(mem_wdata),
        .mem_wstrb(mem_wstrb),
        .mem_rdata(led_ctl_mem_rdata)
    );

    logic led_ctl_mem_ready;
    logic [31:0] led_ctl_mem_rdata;


    //------------------------------------------------------------------
    // 周辺機器との接続
    //------------------------------------------------------------------

    // アクセスしたアドレスに応じた周辺機器を有効にする
    assign bram_en = (mem_addr < 262144) ? 1'b1 : 1'b0; // 0x0000_0000 ~ 0x0003_FFFF (256KB)
    // assign sdram_en = ((mem_addr & 32'hf000_0000) == 32'h4000_0000) ? 1'b1 : 1'b0;
    // assign uart_data_en = (mem_addr == 32'hf0000000) ? 1'b1 : 1'b0;
    // assign uart_ctl_en = (mem_addr == 32'hf0000004) ? 1'b1 : 1'b0;
    assign led_ctl_en = (mem_addr == 32'hf0001000) ? 1'b1 : 1'b0;

    // 周辺機器 => CPU
    assign mem_ready = (bram_en)      ? bram_mem_ready :
                    //    (sdram_en)     ? sdram_mem_ready :
                    //    (uart_data_en) ? uart_data_mem_ready :
                    //    (uart_ctl_en)  ? uart_ctl_mem_ready :
                       (led_ctl_en)   ? led_ctl_mem_ready
                                      : 1'b1; // 接続先のペリフェラルが存在しない場合は常に ready = 1 とする

    assign mem_rdata = (bram_en)      ? bram_mem_rdata :
                    //    (sdram_en)     ? sdram_mem_rdata :
                    //    (uart_data_en) ? uart_data_mem_rdata :
                    //    (uart_ctl_en)  ? uart_ctl_mem_rdata :
                       (led_ctl_en)   ? led_ctl_mem_rdata
                                      : 32'h0;

endmodule

// LED コントローラを雑に実装
module led_controller (
    input wire clk,
    input wire reset_n,
    input wire mem_valid,
    output logic mem_ready,
    input wire [31:0] mem_addr,  // 使わない
    input wire [31:0] mem_wdata,
    input wire [3:0]  mem_wstrb, // 0'b1111 の場合は書き込み
    output logic [31:0] mem_rdata,
);

    logic [7:0] led_data_reg;

    always_ff @(posedge clk) begin
        if (!reset_n) begin
            led_data_reg <= 8'b0;
        end else begin
            if (mem_valid && (mem_wstrb == 4'b1111)) begin
                led_data_reg <= mem_wdata[7:0];
            end
        end
    end

    assign mem_rdata = { 25'b0, led_data_reg };
    assign mem_ready = 1'b1;

endmodule
