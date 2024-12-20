`ifndef __INSTRUCTIONS__
`include "instructions.sv"
`endif

// BRAM コントローラー
module bram_controller(
    input wire clk,
    input wire reset_n,
    input wire mem_valid,
    output logic mem_ready,
    input wire [31:0] mem_addr,
    input wire [31:0] mem_wdata,
    input wire [3:0]  mem_wstrb, // 0'b0000 の場合は読み込み、0'b1111 の場合は書き込み
    output logic [31:0] mem_rdata
);

    typedef enum logic [2:0] {
        STATE_IDLE,
        STATE_MEMORY_RW_WAIT1,
        STATE_MEMORY_RW_WAIT2,
        STATE_SEND_READY
    } state_t;
    state_t state_reg, state_next;

    //------------------------
    // デバッグ用モニタの設定
    //------------------------
    initial begin
        // $monitor("%t: state = %d, reset_n = %b, mem_valid = %b, mem_ready = %b, mem_addr = %h, mem_wdata = %h, mem_wstrb = %b, mem_rdata = %h", $time, state_reg, reset_n, mem_valid, mem_ready, mem_addr, mem_wdata, mem_wstrb, mem_rdata);
    end

    // 0x0000 ~ 0x1FFF の 8KB の BRAM を用意
    // 1ワード = 32bit = 4byte なので、メモリの深さは 2048 となる
    logic [31:0] mem [0:2047];

    assign mem_ready = (state_reg == STATE_SEND_READY) ? 1'b1 : 1'b0;

    // メモリの初期化
    initial begin
        // LED へ 0b1001_1001 を表示する
        mem[0] = addi(1, 0, 8'b10011001);    // x1 = 0b10011001
        mem[1] = lui(2, 32'hf0001000 >> 12); // x2 = 0xf0001000
        mem[2] = sw(2, 1, 0);                // M[x2+0] = x1
        mem[3] = jal(0, 0);                  // jal x0, 0 (無限ループ）
    end

    always_ff @(posedge clk) begin
        if (!reset_n)
            state_reg <= STATE_IDLE;
        else begin
            state_reg <= state_next;

            // メモリへの書き込み
            // NOTE: 現状は1ワードの書き込みのみに対応
            if (mem_wstrb == 4'b1111 && mem_valid) begin
                mem[mem_addr[9:2]] <= mem_wdata;
            end

            // メモリからの読み込み
            // NOTE: BRAM として推論させるため、クロックの立ち上がりで読み込みを行う
            mem_rdata <= mem[mem_addr[9:2]];
        end
    end

    always_comb begin
        case (state_reg)
            STATE_IDLE: begin
                if (mem_valid) begin
                    state_next = STATE_MEMORY_RW_WAIT1;
                end else begin
                    state_next = STATE_IDLE;
                end
            end
            STATE_MEMORY_RW_WAIT1: begin
                state_next = STATE_MEMORY_RW_WAIT2;
            end
            STATE_MEMORY_RW_WAIT2: begin
                state_next = STATE_SEND_READY;
            end
            STATE_SEND_READY: begin
                state_next = STATE_IDLE;
            end
            default: begin
                state_next = STATE_IDLE;
            end
        endcase
    end

    // always @(*) begin
    //     // 0x80番地のデータをデバッグ出力
    //     $display("mem[80] = %h", mem[32'h80]);
    // end
endmodule
