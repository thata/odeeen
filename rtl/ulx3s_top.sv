//------------------------------------------------------------------
// ULX3S 上で Odeeen CPU を動かすためのトップモジュール
//------------------------------------------------------------------
module ulx3s_top(
    input wire clk_25mhz,
    input wire [6:0] btn,
    output wire [7:0] led,
    // UART
    output wire ftdi_rxd, // FPGA transmits to ftdi
    input wire ftdi_txd,  // FPGA receives from ftdi
    // SDRAM
    output [12:0] sdram_a,
    inout [15:0] sdram_dq,
    output sdram_cs_n,
    output sdram_cke,
    output sdram_ras_n,
    output sdram_cas_n,
    output sdram_we_n,
    output [1:0] sdram_dm,
    output [1:0] sdram_ba,
    output sdram_clock
);

    localparam SYSCLK = 25_000_000;

    //------------------------------------------------------------------
    // 外部信号線との接続
    //------------------------------------------------------------------
    assign clk = clk_25mhz;
    assign reset_n = btn[0]; // btn[0] は押すとデアサートされる

    assign led = led_ctl_mem_rdata[7:0];
    // assign led = peek[7:0];
    // assign led = uart_ctl_mem_rdata;


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
    bram_controller bram_ctl (
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
    // UART コントローラ
    //------------------------------------------------------------------

    uart uart_inst (
        .clk(clk),
        .rst(1'b0),
        .rx(ftdi_txd),
        .tx(ftdi_rxd),
        .transmit(tx_trigger),
        .tx_byte(tx_byte),
        .received(received),
        .rx_byte(rx_byte),
        .is_receiving(is_receiving),
        .is_transmitting(is_transmitting),
        .recv_error(recv_error)
    );

    // UART コア用の信号線
    logic tx_trigger;       // Signal to start transmission
    logic [7:0] tx_byte;    // Byte to transmit
    logic received;         // Signal indicating a byte is received
    logic [7:0] rx_byte;    // Received byte
    logic is_receiving;     // Indicates receiving state
    logic is_transmitting;  // Indicates transmitting state
    logic recv_error;       // Indicates receive error

    // UART と CPU との通信用の信号線
    logic uart_data_mem_ready;
    logic [31:0] uart_data_mem_rdata;
    logic uart_ctl_mem_ready;
    logic [31:0] uart_ctl_mem_rdata;

    assign uart_data_mem_valid = uart_data_en && mem_valid;
    assign uart_ctl_mem_valid = uart_ctl_en && mem_valid;
    assign uart_data_mem_ready = (tx_state_reg === TX_STATE_FINISH) ? 1'b1 : 1'b0;

    // 送受信データ置き場
    assign tx_byte = mem_wdata[7:0];                 // 送信データ
    assign uart_data_mem_rdata = { 24'h0, rx_byte }; // 受信データ
    assign uart_ctl_mem_rdata = { 6'b0, is_transmitting, unread_reg }; // { 000000, 送信中, 未読有無 }

    // 未読データの有無
    logic unread_reg, unread_next;
    assign unread_next = (received) ? 1'b1 : unread_reg;

    // UART トランスミッタのステート
    //  001: 待機
    //  010: 送信開始
    //  100: 送信中
    typedef enum logic [2:0] {
        TX_STATE_IDLE = 3'b001,
        TX_STATE_START = 3'b010,
        TX_STATE_FINISH = 3'b100
    } tx_state_t;

    tx_state_t tx_state_reg, tx_state_next;

    always_ff @(posedge clk) begin
        if (!reset_n) begin
            tx_state_reg <= TX_STATE_IDLE;

            unread_reg <= 1'b0;
        end else begin
            tx_state_reg <= tx_state_next;

            if (uart_data_mem_valid && mem_wstrb === 4'b0000)
                unread_reg <= 1'b0;
            else
                unread_reg <= unread_next;
        end
    end

    always_comb begin
        tx_trigger = 1'b0;

        case (tx_state_reg)
            TX_STATE_IDLE: begin
                if (uart_data_mem_valid && mem_wstrb === 4'b1111) begin
                    // 送信の場合
                    tx_state_next = TX_STATE_START;
                end else if (uart_data_mem_valid && mem_wstrb === 4'b0000) begin
                    // 受信の場合
                    // ready だけ返せばいいので、直接 TX_STATE_FINISH に遷移
                    tx_state_next = TX_STATE_FINISH;
                end else begin
                    tx_state_next = TX_STATE_IDLE;
                end
            end
            TX_STATE_START: begin
                tx_trigger = 1'b1;

                tx_state_next = TX_STATE_FINISH;
            end
            TX_STATE_FINISH: begin
                tx_state_next = TX_STATE_IDLE;
            end
            default: begin
                tx_state_next = TX_STATE_IDLE;
            end
        endcase
    end


    //------------------------------------------------------------------
    // SDRAM コントローラ
    //------------------------------------------------------------------

	sdram #(
		.SDRAM_CLK_FREQ(SYSCLK / 1_000_000)
    ) sdram_inst (
		.clk(clk),
		.resetn(reset_n),
		.addr(sdram_mem_addr),
		.din(mem_wdata),
		.dout(sdram_mem_rdata),
		.wmask(mem_wstrb),
		.ready(sdram_mem_ready),
		.sdram_clk(sdram_clock),
		.sdram_cke(sdram_cke),
		.sdram_csn(sdram_cs_n),
		.sdram_rasn(sdram_ras_n),
		.sdram_casn(sdram_cas_n),
		.sdram_wen(sdram_we_n),
		.sdram_addr(sdram_a),
		.sdram_ba(sdram_ba),
		.sdram_dq(sdram_dq),
		.sdram_dqm(sdram_dm),
		.valid(sdram_valid)
	);

    logic sdram_valid;
    logic sdram_mem_ready;
    logic [31:0] sdram_mem_rdata;
    logic [24:0] sdram_mem_addr;

    assign sdram_mem_addr = { (mem_addr & 32'h0fff_ffff) >> 2, 2'b00 };
    assign sdram_valid = sdram_en && mem_valid;

    //------------------------------------------------------------------
    // 周辺機器との接続
    //------------------------------------------------------------------

    // アクセスしたアドレスに応じた周辺機器を有効にする
    assign bram_en = (mem_addr < 262144) ? 1'b1 : 1'b0; // 0x0000_0000 ~ 0x0003_FFFF (256KB)
    // assign bram_en = (mem_addr < 524288) ? 1'b1 : 1'b0; // 0x0000_0000 ~ 0x0007_FFFF（512KB）
    // assign bram_en = (mem_addr < 131072) ? 1'b1 : 1'b0; // 0x0000_0000 ~ 0x0001_FFFF（128KB）
    // assign bram_en = (mem_addr < 65536) ? 1'b1 : 1'b0;  // 0x0000_0000 ~ 0x0000_FFFF（64KB）
    assign sdram_en = ((mem_addr & 32'hf000_0000) == 32'h4000_0000) ? 1'b1 : 1'b0;
    assign uart_data_en = (mem_addr == 32'hf0000000) ? 1'b1 : 1'b0;
    assign uart_ctl_en = (mem_addr == 32'hf0000004) ? 1'b1 : 1'b0;
    assign led_ctl_en = (mem_addr == 32'hf0001000) ? 1'b1 : 1'b0;

    // 周辺機器 => CPU
    assign mem_ready = (bram_en)      ? bram_mem_ready :
                       (sdram_en)     ? sdram_mem_ready :
                       (led_ctl_en)   ? led_ctl_mem_ready :
                       (uart_data_en) ? uart_data_mem_ready :
                       (uart_ctl_en)  ? uart_ctl_mem_ready
                                      : 1'b1; // 接続先のペリフェラルが存在しない場合は常に ready = 1 とする

    assign mem_rdata = (bram_en)      ? bram_mem_rdata :
                       (sdram_en)     ? sdram_mem_rdata :
                       (led_ctl_en)   ? led_ctl_mem_rdata :
                       (uart_data_en) ? uart_data_mem_rdata :
                       (uart_ctl_en)  ? uart_ctl_mem_rdata
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
