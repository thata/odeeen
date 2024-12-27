// I形式の命令のテスト
//  - xori
//  - ori
//  - andi
//  - slli
//  - srli
//  - srai
//  - slti
//  - sltiu
//  - （おまけ）auipc

    .text
    .globl _start
_start:
    lui gp, 0xf0001    // LEDアクセス用 gp
    li s0, 1
    j test_start

fail:
    // 失敗時は LED に 1 を出力
    li t0, 1
    sw t0, 0(gp)
    j fail

test_start:

    //----------------------------------------
    // xori
    //----------------------------------------

    // 1111 xor 1010 = 0101
    li t0, 0b1111

    xori t1, t0, 0b1010 // actual
    li t2, 0b0101       // expected
    bne t1, t2, fail

    //----------------------------------------
    // ori
    //----------------------------------------

    // 1100 or 1010 = 1110
    li t0, 0b1100
    ori t1, t0, 0b1010 // actual
    li t2, 0b1110      // expected
    bne t1, t2, fail

    //----------------------------------------
    // andi
    //----------------------------------------

    // 1100 and 1010 = 1000
    li t0, 0b1100
    andi t1, t0, 0b1010 // actual
    li t2, 0b1000       // expected
    bne t1, t2, fail

    //----------------------------------------
    // slli
    //----------------------------------------

    // 0011_1100 << 2 = 1111_000
    li t0, 0b00111100
    slli t1, t0, 2     // actual
    li t2, 0b11110000 // expected
    bne t1, t2, fail

    //----------------------------------------
    // srli
    //----------------------------------------

    // 0011_1100 >> 5 = 0000_0001
    li t0, 0b00111100
    srli t1, t0, 5     // actual
    li t2, 0b00000001  // expected
    bne t1, t2, fail

    // 0011_1100 >> 2 = 0000_1111
    li t0, 0b00111100
    srli t1, t0, 2     // actual
    li t2, 0b00001111  // expected
    bne t1, t2, fail

    // 0xFFFF_0000 >> 4 = 0x0FFF_F000
    li t0, 0xFFFF0000
    srli t1, t0, 4     // actual
    li t2, 0x0FFFF000  // expected
    bne t1, t2, fail

    //----------------------------------------
    // srai
    //----------------------------------------

    // 0011_1100 >> 5 = 0000_0001
    li t0, 0b00111100
    srai t1, t0, 5     // actual
    li t2, 0b00000001  // expected
    bne t1, t2, fail

    // 0xFFFF_0000 >> 4 = 0x0FFF_F000
    li t0, 0xFFFF0000
    srai t1, t0, 4     // actual
    li t2, 0xFFFFF000  // expected
    bne t1, t2, fail

    //----------------------------------------
    // slti
    //----------------------------------------

    // 1 < 2 = 1
    li t0, 1

    // slti を正しい書き方でお願い
    slti t2, t0, 2 // actual
    li t3, 1       // expected
    bne t2, t3, fail

    // 1 < 1 = 0
    li t0, 1
    slti t2, t0, 1  // actual
    li t3, 0        // expected
    bne t2, t3, fail

    // 2 < 1 = 0
    li t0, 2
    slti t2, t0, 1  // actual
    li t3, 0        // expected
    bne t2, t3, fail

    // 0xffffffff(-1) < 0 = 1
    li t0, 0xffffffff
    slti t2, t0, 1  // actual
    li t3, 1        // expected
    bne t2, t3, fail


    //----------------------------------------
    // sltiu
    //----------------------------------------

    // 1 < 2 = 1
    li t0, 1
    sltiu t2, t0, 2 // actual
    li t3, 1        // expected
    bne t2, t3, fail

    // 1 < 1 = 0
    li t0, 1
    sltiu t2, t0, 1 // actual
    li t3, 0        // expected
    bne t2, t3, fail

    // 2 < 1 = 0
    li t0, 2
    sltiu t2, t0, 1 // actual
    li t3, 0        // expected
    bne t2, t3, fail

    // 0xffffffff < 0 = 0
    li t0, 0xffffffff
    sltiu t2, t0, 0  // actual
    li t3, 0         // expected
    bne t2, t3, fail

    //----------------------------------------
    // auipc
    //----------------------------------------

    // PCの値(0x128) + 0x12345000 を t0 に格納
    // NOTE: プログラムを書き換えると、この値も変わるので注意
    auipc t0, 0x12345  // t0 = pc + 0x12345000
    // t1 に期待値を格納
    li t1, 0x12345000
    addi t1, t1, 0x128 // expected
    // テスト
    bne t0, t1, fail

    // Success
    // LED に 128 を出力
    li t0, 128
    sw t0, 0(gp)

loop:
    j loop
