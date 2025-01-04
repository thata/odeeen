/**
 * 浮動小数点数のテストプログラム
 */

/* instruction[0]からinstruction[63]までの命令がメモリに書き込まれる */

// FDIV.S のテスト
instructions[0] = flw(5, 0, 32'h108);    // f5 = 3.0
instructions[1] = flw(6, 0, 32'h104);    // f6 = 2.0
instructions[2] = fdiv_s(7, 5, 6);       // f7 = f5 / f6
instructions[3] = fsw(0, 7, 32'h110);    // M[0x110] = f7

// FADD.S のテスト (1.0 + 2.0)
instructions[4] = flw(5, 0, 32'h100);    // f5 = M[0x100]
instructions[5] = flw(6, 0, 32'h104);    // f6 = M[0x104]
instructions[6] = fadd_s(7, 5, 6);       // f7 = f5 + f6
instructions[7] = fsw(0, 7, 32'h118);    // M[0x118] = f7

// FSUB.S のテスト (3 - 2)
instructions[8] = flw(5, 0, 32'h108);    // f5 = M[0x108]
instructions[9] = flw(6, 0, 32'h104);    // f6 = M[0x104]
instructions[10] = fsub_s(7, 5, 6);       // f7 = f5 + f6
instructions[11] = fsw(0, 7, 32'h11c);    // M[0x11c] = f7

// FMUL.S のテスト (2.0 * 3.0)
instructions[12] = flw(5, 0, 32'h104);    // f5 = M[0x108]
instructions[13] = flw(6, 0, 32'h108);    // f6 = M[0x104]
instructions[14] = fmul_s(7, 5, 6);       // f7 = f5 + f6
instructions[15] = fsw(0, 7, 32'h120);    // M[0x11c] = f7

// FLW と FSW のテスト
instructions[16] = flw(5, 0, 32'h100);    // f5 = M[x0+0x100]
instructions[17] = fsw(0, 5, 32'h124);    // M[0x110] = f5
instructions[18] = flw(6, 0, 32'h124);    // f6 = M[0x110]
instructions[19] = fsw(0, 6, 32'h128);    // M[0x114] = f6

// FCVT のテスト
instructions[20] = flw(5, 0, 32'h108);    // f5 = 3.0
instructions[21] = fcvt_w_s(6, 5);        // x6 = (int)f5
instructions[22] = sw(0, 6, 32'h12c);     // M[0x12c] = x6
instructions[23] = fcvt_s_w(7, 6);        // f7 = (float)x6
instructions[24] = fsw(0, 7, 32'h130);    // M[0x130] = f7

// FSGNJ系のテスト
// f5 = 3.0
// f6 = fsgnj(f6, f5, f5) // f6 = f5
// f7 = fsgnjn(f7, f5, f5) // f7 = -f5
instructions[25] = flw(5, 0, 32'h108);    // f5 = 3.0
instructions[26] = fsgnj_s(6, 5, 5);      // f6 = f5
instructions[27] = fsw(0, 6, 32'h134);    // M[0x134] = f6
instructions[28] = fsgnjn_s(7, 5, 5);     // f7 = -f5
instructions[29] = fsw(0, 7, 32'h138);    // M[0x138] = f7

instructions[30] = jal(0, 0);             // 無限ループ

// テスト用の浮動小数点数データ
instructions[64] = 32'h3f800000;        // M[0x100] = 1.0
instructions[65] = 32'h40000000;        // M[0x104] = 2.0
instructions[66] = 32'h40400000;        // M[0x108] = 3.0


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

#10000;

// 実行が終わった頃合いを見て、メモリの内容を確認
mem_monitor_on = 1;
mem_monitor_valid_reg = 1;
mem_monitor_addr_reg = 32'h110;
mem_monitor_wstrb_reg = 4'b0000;
#10;
wait(mem_ready);
assert(
    mem_rdata === 32'h3fc00000 // 1.5
) $display("PASSED"); else $display("FAILED: %h", mem_rdata);
mem_monitor_valid_reg = 0;
#10;

mem_monitor_on = 1;
mem_monitor_valid_reg = 1;
mem_monitor_addr_reg = 32'h118;
mem_monitor_wstrb_reg = 4'b0000;
#10;
wait(mem_ready);
assert(
    // 0_00000001_00000000000000000000000 = 2.0
    // 0_00000010_00000000000000000000000 =
    // 0_00000011_00000000000000000000000 = 5.0
    mem_rdata === 32'h40400000
) $display("PASSED"); else $display("FAILED: %h", mem_rdata);
mem_monitor_valid_reg = 0;
#10;

mem_monitor_on = 1;
mem_monitor_valid_reg = 1;
mem_monitor_addr_reg = 32'h11c;
mem_monitor_wstrb_reg = 4'b0000;
#10;
wait(mem_ready);
assert(
    mem_rdata === 32'h3f800000
) $display("PASSED"); else $display("FAILED: %h", mem_rdata);
mem_monitor_valid_reg = 0;
#10;

mem_monitor_on = 1;
mem_monitor_valid_reg = 1;
mem_monitor_addr_reg = 32'h120;
mem_monitor_wstrb_reg = 4'b0000;
#10;
wait(mem_ready);
assert(
    mem_rdata === 32'h40c00000
) $display("PASSED"); else $display("FAILED: %h", mem_rdata);
mem_monitor_valid_reg = 0;
#10;

mem_monitor_on = 1;
mem_monitor_valid_reg = 1;
mem_monitor_addr_reg = 32'h124;
mem_monitor_wstrb_reg = 4'b0000;
#10;
wait(mem_ready);
assert(
    mem_rdata === 32'h3f800000
) $display("PASSED"); else $display("FAILED: %h", mem_rdata);
mem_monitor_valid_reg = 0;
#10;

mem_monitor_on = 1;
mem_monitor_valid_reg = 1;
mem_monitor_addr_reg = 32'h128;
mem_monitor_wstrb_reg = 4'b0000;
#10;
wait(mem_ready);
assert(
    mem_rdata === 32'h3f800000
) $display("PASSED"); else $display("FAILED: %h", mem_rdata);
mem_monitor_valid_reg = 0;
#10;

mem_monitor_on = 1;
mem_monitor_valid_reg = 1;
mem_monitor_addr_reg = 32'h12c;
mem_monitor_wstrb_reg = 4'b0000;
#10;
wait(mem_ready);
assert(
    mem_rdata === 32'h3
) $display("PASSED"); else $display("FAILED: %h", mem_rdata);
mem_monitor_valid_reg = 0;
#10;

mem_monitor_on = 1;
mem_monitor_valid_reg = 1;
mem_monitor_addr_reg = 32'h130;
mem_monitor_wstrb_reg = 4'b0000;
#10;
wait(mem_ready);
assert(
    mem_rdata === 32'h40400000
) $display("PASSED"); else $display("FAILED: %h", mem_rdata);
mem_monitor_valid_reg = 0;
#10;

mem_monitor_on = 1;
mem_monitor_valid_reg = 1;
mem_monitor_addr_reg = 32'h134;
mem_monitor_wstrb_reg = 4'b0000;
#10;
wait(mem_ready);
assert(
    mem_rdata === 32'h40400000 // 3.0
) $display("PASSED"); else $display("FAILED: %h", mem_rdata);
mem_monitor_valid_reg = 0;
#10;

mem_monitor_on = 1;
mem_monitor_valid_reg = 1;
mem_monitor_addr_reg = 32'h138;
mem_monitor_wstrb_reg = 4'b0000;
#10;
wait(mem_ready);
assert(
    mem_rdata === 32'hc0400000 // -3.0
) $display("PASSED"); else $display("FAILED: %h", mem_rdata);
mem_monitor_valid_reg = 0;
#10;
