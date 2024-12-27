`ifndef __INSTRUCTIONS__
`include "instructions.sv"
`endif

// CPUのテストベンチ
//  iverilog -g 2012 -s cpu_test rtl/instructions.sv rtl/cpu_test.sv rtl/bram_controller.sv rtl/cpu.sv && ./a.out
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

        // beq のテスト
        instructions[0] = addi(5, 0, 42);     // x5 = x0 + 42
        instructions[1] = addi(6, 0, 42);     // x6 = x0 + 42
        instructions[2] = beq(5, 6, 8 >> 1);  // if (x5 == x6) 2つ先の命令(8バイト)へジャンプ
        instructions[3] = jal(0, 0);          // 無限ループ
        instructions[4] = sw(0, 5, 12'h400); // M[0x400] = x5

        // auipc のテスト
        instructions[5] = auipc(5, 20'h12345);   // x5 = pc + 0x12345000
        instructions[6] = sw(0, 5, 12'h404);  // M[0x404] = x5
        instructions[7] = jal(0, 0);           // 無限ループ

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

        // $monitoron; // $monitor を再開

        /**
         * リセットして、0番地からプログラムを実行
         */
        reset_n = 0;
        #10;
        reset_n = 1;
        #10;

        #2000;

        // 実行が終わった頃合いを見て、メモリの内容を確認
        mem_monitor_on = 1;
        mem_monitor_valid_reg = 1;
        mem_monitor_addr_reg = 32'h00000400;
        mem_monitor_wstrb_reg = 4'b0000;
        #10;
        wait(mem_ready);
        assert(
            mem_rdata === 42
        ) $display("PASSED"); else $display("expected 42 but actual %d", mem_rdata);
        mem_monitor_valid_reg = 0;
        #10;

        mem_monitor_valid_reg = 1;
        mem_monitor_addr_reg = 32'h00000404;
        mem_monitor_wstrb_reg = 4'b0000;
        #10;
        wait(mem_ready);
        assert(
            mem_rdata === 32'h12345014
        ) $display("PASSED"); else $display("expected 42 but actual %h", mem_rdata);
        mem_monitor_valid_reg = 0;
        #10;

        $finish;
    end

endmodule
