`include "instructions.sv"

// CPUのテストベンチ
module cpu_test;

    // CPUのインスタンス
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

    bram_controller ram (
        .clk(clk),
        .reset_n(reset_n),
        .mem_valid(mem_monitor_on ? mem_monitor_valid_reg : mem_valid),
        .mem_ready(mem_ready),
        .mem_addr(mem_monitor_on ? mem_monitor_addr_reg : mem_addr),
        .mem_wdata(mem_monitor_on ? mem_monitor_wdata_reg : mem_wdata),
        .mem_wstrb(mem_monitor_on ? mem_monitor_wstrb_reg : mem_wstrb),
        .mem_rdata(mem_rdata)
    );

    // クロック信号
    logic clk = 1'b0;
    always begin
        #5 clk = ~clk;
    end

    // リセット信号
    logic reset_n;
    initial begin
        reset_n = 0;
        #10 reset_n = 1;
    end

    // PicoRV32 Native Memory Interface
    logic mem_valid, mem_instr, mem_ready;
    logic [31:0] mem_addr;
    logic [31:0] mem_wdata;
    logic [3:0] mem_wstrb;
    logic [31:0] mem_rdata;

    // テストベンチからのメモリ操作用信号線
    logic mem_monitor_on = 1'b0;
    logic mem_monitor_valid_reg = 1'b0;
    logic [31:0] mem_monitor_addr_reg;
    logic [31:0] mem_monitor_wdata_reg;
    logic [3:0] mem_monitor_wstrb_reg;

    // 命令列
    logic [31:0] instructions [0:255];
    logic [31:0] addr;

    initial begin
        $dumpfile("cpu_test.vcd");
        $dumpvars(0, cpu_inst);

        // リセット
        reset_n = 0;
        #10 reset_n = 1;

        $monitoroff; // プログラム書き込み中は $monitor を一時停止

        /**
         * プログラムの書き込み
         */

        // lw と sw のテスト
        instructions[0] = addi(1, 0, 10);    // addi x1, x0, 10
        instructions[1] = add(2, 1, 1);      // addi x2, x1, x1
        instructions[2] = add(3, 1, 2);      // addi x3, x1, x2
        instructions[3] = sw(0, 3, 32'h80);  // sw x3, 0x80(x0) （メモリの 0x80 番地へ x3 の値を格納する）
        instructions[4] = lw(4, 0, 32'h80);  // lw x4, 0x80(x0) （メモリの 0x80 番地から x4 へ読み込む）
        instructions[5] = sw(0, 4, 32'h84);  // sw x4, 0x84(x0) （メモリの 0x84 番地へ x4 の値を格納する）
        // beq のテスト
        instructions[6] = addi(5, 0, 42);    // x5 = x0 + 42
        instructions[7] = addi(6, 0, 42);    // x6 = x0 + 42
        instructions[8] = beq(5, 6, 8 >> 1); // if (x5 == x6) 2つ先の命令(8バイト)へジャンプ
        instructions[9] = jal(0, 0);         // 無限ループ
        instructions[10] = sw(0, 5, 32'h88); // sw x5, 0x88(x0) （メモリの 0x88 番地へ x5 の値を格納する）
        // lui と ori のテスト
        instructions[11] = lui(7, 32'h12345000 >> 12); // x7 = 0x12345000
        instructions[12] = sw(0, 7, 32'h8C);           // M[0x8C] = x7
        instructions[13] = ori(7, 7, 32'h0678);        // x7 = x7 | 0x678
        instructions[14] = sw(0, 7, 32'h90);           // M[0x90] = x7
        // 0番地へ戻る
        instructions[15] = jal(0, -60 >> 1); // jal x0, -60 （0番地へ戻る）

        mem_monitor_on = 1;
        addr = 32'h00000000;
        for (int i = 0; i < 255; i++) begin
            mem_monitor_valid_reg = 1;
            mem_monitor_addr_reg = addr;
            mem_monitor_wdata_reg = instructions[i];
            mem_monitor_wstrb_reg = 4'b1111;
            #10;
            wait(mem_ready);
            mem_monitor_valid_reg = 0;
            #10;

            // 書き込みアドレスを進める
            addr = addr + 4;
        end
        mem_monitor_on = 0;

        $monitoron; // $monitor を再開

        /**
         * リセットして、0番地からプログラムを実行
         */
        reset_n = 0;
        #10;
        reset_n = 1;
        #10;

        #2000;

        // 実行が終わった頃合いを見て、メモリの 0x80 番地の内容を確認
        mem_monitor_on = 1;
        mem_monitor_valid_reg = 1;
        mem_monitor_addr_reg = 32'h00000080;
        mem_monitor_wstrb_reg = 4'b0000;
        #10;
        wait(mem_ready);
        $display("mem[0x80] = %d", mem_rdata);
        mem_monitor_valid_reg = 0;
        #10;

        // メモリの 0x84 番地の内容を確認
        mem_monitor_on = 1;
        mem_monitor_valid_reg = 1;
        mem_monitor_addr_reg = 32'h00000084;
        mem_monitor_wstrb_reg = 4'b0000;
        #10;
        wait(mem_ready);
        $display("mem[0x84] = %d", mem_rdata);
        mem_monitor_valid_reg = 0;
        #10;

        // メモリの 0x88 番地の内容を確認
        mem_monitor_on = 1;
        mem_monitor_valid_reg = 1;
        mem_monitor_addr_reg = 32'h00000088;
        mem_monitor_wstrb_reg = 4'b0000;
        #10;
        wait(mem_ready);
        $display("mem[0x88] = %d", mem_rdata);
        mem_monitor_valid_reg = 0;
        #10;

        // メモリの 0x8C 番地の内容を確認
        mem_monitor_on = 1;
        mem_monitor_valid_reg = 1;
        mem_monitor_addr_reg = 32'h0000008C;
        mem_monitor_wstrb_reg = 4'b0000;
        #10;
        wait(mem_ready);
        $display("mem[0x8C] = %h", mem_rdata);
        mem_monitor_valid_reg = 0;
        #10;

        // メモリの 0x90 番地の内容を確認
        mem_monitor_on = 1;
        mem_monitor_valid_reg = 1;
        mem_monitor_addr_reg = 32'h00000090;
        mem_monitor_wstrb_reg = 4'b0000;
        #10;
        wait(mem_ready);
        $display("mem[0x90] = %h", mem_rdata);
        mem_monitor_valid_reg = 0;
        #10;

        $finish;
    end

endmodule
