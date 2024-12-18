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

        instructions[0] = 32'h00000013; // nop
        instructions[1] = 32'h00000013; // nop
        instructions[2] = 32'h00000013; // nop
        instructions[3] = 32'h0000006F; // jal x0, 0（無限ループ）

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

        #500;

        $finish;
    end

endmodule
