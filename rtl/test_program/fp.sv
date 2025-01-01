/**
 * 浮動小数点数のテストプログラム
 */

instructions[0] = flw(5, 0, 32'h100);    // f5 = M[x0+0x100]
instructions[1] = fsw(0, 5, 32'h104);    // M[x0+0x104] = f5
instructions[2] = flw(6, 0, 32'h104);    // f6 = M[x0+0x104]
instructions[3] = jal(0, 0);            // 無限ループ


// テスト用の浮動小数点数データ
instructions[64] = 32'h10000000;        // M[0x100] = -0.0


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

$monitoron; // $monitor を再開

/**
 * リセットして、0番地からプログラムを実行
 */
reset_n = 0;
#10;
reset_n = 1;
#10;

#1000;

// 実行が終わった頃合いを見て、メモリの内容を確認
mem_monitor_on = 1;
mem_monitor_valid_reg = 1;
mem_monitor_addr_reg = 32'h104;
mem_monitor_wstrb_reg = 4'b0000;
#10;
wait(mem_ready);
assert(
    mem_rdata === 32'h10000000
) $display("PASSED"); else $display("FAILED: %d", mem_rdata);
mem_monitor_valid_reg = 0;
#10;
