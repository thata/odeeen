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

    initial begin
        // リセット
        reset_n = 0;
        #10 reset_n = 1;

        // メモリへの書き込み
        mem_monitor_on = 1;
        mem_monitor_valid_reg = 1;
        mem_monitor_addr_reg = 32'h00000000;
        mem_monitor_wdata_reg = 32'h00001111;
        mem_monitor_wstrb_reg = 4'b1111;
        #10;
        wait(mem_ready);
        mem_monitor_valid_reg = 0;
        #10;

        // メモリからの読み込み
        mem_monitor_on = 1;
        mem_monitor_valid_reg = 1;
        mem_monitor_addr_reg = 32'h00000000;
        mem_monitor_wdata_reg = 32'h00000000;
        mem_monitor_wstrb_reg = 4'b0000;
        #10;
        wait(mem_ready);
        mem_monitor_valid_reg = 0;
        #10;
        $display("mem_rdata = %h", mem_rdata);

        #100;

        $finish;
    end

endmodule
