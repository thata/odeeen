/**
 * テストプログラム
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


/**
 * プログラムの書き込み
 */

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
