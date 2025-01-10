/**
 * 浮動小数点数のテストプログラム
 */

/* instruction[0]からinstruction[63]までの命令がメモリに書き込まれる */

// FMV 系のテスト
instructions[0] = flw(5, 0, 32'h108);    // f5 = 3.0
instructions[1] = fmv_x_w(6, 5);         // x6 = f5
instructions[2] = fmv_w_x(7, 6);         // f7 = x6
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

// FEQ 系のテスト
// f5 = 2.0
// f6 = 3.0
// x5 = feq(f5, f6) // 0
// x5 = feq(f5, f5) // 1
// x5 = flt(f5, f6) // 1
// x5 = flt(f6, f5) // 0
// x5 = fle(f5, f6) // 1
// x5 = fle(f6, f5) // 0
// x5 = fle(f5, f5) // 1
instructions[30] = flw(5, 0, 32'h104);    // f5 = 2.0
instructions[31] = flw(6, 0, 32'h108);    // f6 = 3.0
instructions[32] = feq_s(7, 5, 6);        // x7 = (f5 == f6) ? 1 : 0
instructions[33] = sw(0, 7, 32'h13c);     // M[0x13c] = x7 (== 0)
instructions[34] = feq_s(7, 5, 5);        // x7 = (f5 == f5) ? 1 : 0
instructions[35] = sw(0, 7, 32'h140);     // M[0x140] = x7 (== 1)
instructions[36] = flt_s(7, 5, 6);        // x7 = (f5 < f6) ? 1 : 0
instructions[37] = sw(0, 7, 32'h144);     // M[0x144] = x7 (== 1)
instructions[38] = flt_s(7, 6, 5);        // x7 = (f6 < f5) ? 1 : 0
instructions[39] = sw(0, 7, 32'h148);     // M[0x148] = x7 (== 0)
instructions[40] = fle_s(7, 5, 6);        // x7 = (f5 <= f6) ? 1 : 0
instructions[41] = sw(0, 7, 32'h14c);     // M[0x14c] = x7 (== 1)
instructions[42] = fle_s(7, 6, 5);        // x7 = (f6 <= f5) ? 1 : 0
instructions[43] = sw(0, 7, 32'h150);     // M[0x150] = x7 (== 0)
instructions[44] = fle_s(7, 5, 5);        // x7 = (f5 <= f5) ? 1 : 0
instructions[45] = sw(0, 7, 32'h154);     // M[0x154] = x7 (== 1)

// FDIV.S のテスト
instructions[46] = flw(5, 0, 32'h108);    // f5 = 3.0
instructions[47] = flw(6, 0, 32'h104);    // f6 = 2.0
instructions[48] = fdiv_s(7, 5, 6);       // f7 = f5 / f6
instructions[49] = fsw(0, 7, 32'h158);    // M[0x158] = f7

instructions[50] = jal(0, 0);             // 無限ループ

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

#20000;

// 実行が終わった頃合いを見て、メモリの内容を確認
mem_monitor_on = 1;
mem_monitor_valid_reg = 1;
mem_monitor_addr_reg = 32'h110;
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

// FEQ
// (2.0 == 3.0) #=> 0
mem_monitor_on = 1;
mem_monitor_valid_reg = 1;
mem_monitor_addr_reg = 32'h13c;
mem_monitor_wstrb_reg = 4'b0000;
#10;
wait(mem_ready);
assert(
    mem_rdata === 32'h0
) $display("PASSED"); else $display("FAILED: %h", mem_rdata);
mem_monitor_valid_reg = 0;
#10;


mem_monitor_on = 1;
mem_monitor_valid_reg = 1;
mem_monitor_addr_reg = 32'h140;
mem_monitor_wstrb_reg = 4'b0000;
#10;
wait(mem_ready);
assert(
    mem_rdata === 32'h1
) $display("PASSED"); else $display("FAILED: %h", mem_rdata);
mem_monitor_valid_reg = 0;
#10;

mem_monitor_on = 1;
mem_monitor_valid_reg = 1;
mem_monitor_addr_reg = 32'h144;
mem_monitor_wstrb_reg = 4'b0000;
#10;
wait(mem_ready);
assert(
    mem_rdata === 32'h1
) $display("PASSED"); else $display("FAILED: %h", mem_rdata);
mem_monitor_valid_reg = 0;
#10;

mem_monitor_on = 1;
mem_monitor_valid_reg = 1;
mem_monitor_addr_reg = 32'h148;
mem_monitor_wstrb_reg = 4'b0000;
#10;
wait(mem_ready);
assert(
    mem_rdata === 32'h0
) $display("PASSED"); else $display("FAILED: %h", mem_rdata);
mem_monitor_valid_reg = 0;
#10;

mem_monitor_on = 1;
mem_monitor_valid_reg = 1;
mem_monitor_addr_reg = 32'h14c;
mem_monitor_wstrb_reg = 4'b0000;
#10;
wait(mem_ready);
assert(
    mem_rdata === 32'h1
) $display("PASSED"); else $display("FAILED: %h", mem_rdata);
mem_monitor_valid_reg = 0;
#10;

// (3.0 <= 2.0) #=> 0
mem_monitor_on = 1;
mem_monitor_valid_reg = 1;
mem_monitor_addr_reg = 32'h150;
mem_monitor_wstrb_reg = 4'b0000;
#10;
wait(mem_ready);
assert(
    mem_rdata === 32'h0
) $display("PASSED"); else $display("FAILED: %h", mem_rdata);
mem_monitor_valid_reg = 0;
#10;

// (2.0 <= 2.0) #=> 1
mem_monitor_on = 1;
mem_monitor_valid_reg = 1;
mem_monitor_addr_reg = 32'h154;
mem_monitor_wstrb_reg = 4'b0000;
#10;
wait(mem_ready);
assert(
    mem_rdata === 32'h1
) $display("PASSED"); else $display("FAILED: %h", mem_rdata);
mem_monitor_valid_reg = 0;
#10;

mem_monitor_on = 1;
mem_monitor_valid_reg = 1;
mem_monitor_addr_reg = 32'h158;
mem_monitor_wstrb_reg = 4'b0000;
#10;
wait(mem_ready);
assert(
    mem_rdata === 32'h3fc00000 // 1.5
) $display("PASSED"); else $display("FAILED: %h", mem_rdata);
mem_monitor_valid_reg = 0;
#10;
