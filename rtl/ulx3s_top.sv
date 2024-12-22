//------------------------------------------------------------------
// ULX3S 上で Odeeen CPU を動かすためのトップモジュール
//------------------------------------------------------------------
module ulx3s_top(
    input wire clk_25mhz,
    input wire [6:0] btn,
    output wire [7:0] led,
    output wire ftdi_rxd, // FPGA transmits to ftdi
    input wire ftdi_txd   // FPGA receives from ftdi
);

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

    assign tx_byte = mem_wdata[7:0];                 // 送信データ
    assign uart_data_mem_rdata = { 24'h0, rx_byte }; // 受信データ

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
        end else begin
            tx_state_reg <= tx_state_next;
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
    // 周辺機器との接続
    //------------------------------------------------------------------

    // メモリマップ
    assign bram_en = (mem_addr < 8192) ? 1'b1 : 1'b0;
    assign uart_data_en = (mem_addr == 32'hf0000000) ? 1'b1 : 1'b0;
    assign uart_ctl_en = (mem_addr == 32'hf0000004) ? 1'b1 : 1'b0;
    assign led_ctl_en = (mem_addr == 32'hf0001000) ? 1'b1 : 1'b0;

    // 周辺機器 => CPU
    assign mem_ready = (bram_en)      ? bram_mem_ready :
                       (led_ctl_en)   ? led_ctl_mem_ready :
                       (uart_data_en) ? uart_data_mem_ready :
                       (uart_ctl_en)  ? uart_ctl_mem_ready
                                      : 1'b1; // 接続先のペリフェラルが存在しない場合は常に ready = 1 とする

    assign mem_rdata = (bram_en)      ? bram_mem_rdata :
                       (led_ctl_en)   ? led_ctl_mem_rdata :
                       (uart_data_en) ? uart_data_mem_rdata :
                       (uart_ctl_en)  ? uart_ctl_mem_rdata
                                      : 32'h0;


    //------------------------------------------------------------------
    // 外部信号線との接続
    //------------------------------------------------------------------
    assign clk = clk_25mhz;
    assign reset_n = btn[0]; // btn[0] は押すとデアサートされる

    assign led = led_ctl_mem_rdata[7:0];
    // assign led = peek[7:0];
    // assign led = { uart_data_en, tx_trigger, uart_data_mem_valid, 2'b0, tx_state_reg };

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
