`include "instructions.sv"

// CPUのテストベンチ
//  $ iverilog -s cpu_test cpu_test.sv cpu.sv && ./a.out
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

    bram_controller prog_ram (
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
        // リセット
        reset_n = 0;
        #10 reset_n = 1;

        $monitoroff; // プログラム書き込み中は $monitor を一時停止

        /**
         * プログラムの書き込み
         */

        // 命令列を初期化
        instructions[0] = addi(1, 0, 10); // x1 = 10
        instructions[1] = addi(2, 0, 20); // x2 = 20
        instructions[2] = add(1, 1, 2);   // x1 = x1 + x2
        instructions[3] = jal(0, 0); // 無限ループ
        // instructions[0] = add(0, 0, 0); // nop
        // instructions[1] = add(0, 0, 0); // nop
        // instructions[2] = add(0, 0, 0); // nop
        // instructions[3] = 32'hFF5FF06F; // jal x0, -12 （3つ前の命令のアドレスへジャンプ）

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

        /**
         * リセットして、0番地からプログラムを実行
         */
        $monitoron; // $monitor を再開

        reset_n = 0;
        #10;
        reset_n = 1;
        #10;

        #1000;

        $finish;
    end

endmodule
