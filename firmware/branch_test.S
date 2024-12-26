// 条件分岐系のテスト
// - beq
// - bne
// - blt
// - bge
// - bltu
// - bgeu

    .text
    .globl _start
_start:
    lui x10, 0xf0001    // LEDアクセス用 gp
    li s0, 1

    //----------------------------------------
    // beq
    //----------------------------------------

    li t0, 0x00000000
    li t1, 0xFFFFFFFF

    // beq (1): eq の場合ジャンプ
    beq t0, t0, beq1_ok
fail:
    j fail
beq1_ok:
    sw s0, 0(x10)   // LEDに1を出力
    addi s0, s0, 1  // s0 = s0 + 1

    // beq (2): eq じゃない場合ジャンプしない
    beq t0, t1, fail
beq2_ok:
    sw s0, 0(x10)   // LEDに2を出力
    addi s0, s0, 1  // s0 = s0 + 1

    //----------------------------------------
    // bne
    //----------------------------------------

    li t0, 0x00000000
    li t1, 0xFFFFFFFF

    // bne (1): eq の場合ジャンプしない
    bne t0, t0, fail
bne1_ok:
    sw s0, 0(x10)   // LEDに3を出力
    addi s0, s0, 1  // s0 = s0 + 1

    // bne (2): eq じゃない場合ジャンプ
    bne t0, t1, bne2_ok
    j fail
bne2_ok:
    sw s3, 0(x10)   // LEDに4を出力
    addi s0, s0, 1  // s0 = s0 + 1



    //----------------------------------------
    // blt (signed rs1  < signed rs2)
    //----------------------------------------

    li t0, -1
    li t1, 0

    // blt (1): rs1 < rs2 の場合ジャンプ
    blt t0, t1, blt1_ok
    j fail
blt1_ok:
    sw s0, 0(x10)   // LEDに5を出力
    addi s0, s0, 1  // s0 = s0 + 1

    // blt (2): rs1 >= rs2 の場合ジャンプしない
    blt t1, t0, fail
blt2_ok:
    sw s0, 0(x10)   // LEDに6を出力
    addi s0, s0, 1  // s0 = s0 + 1

    // blt (3): rs1 == rs2 の場合ジャンプしない
    blt t0, t0, fail
blt3_ok:
    sw s0, 0(x10)   // LEDに7を出力
    addi s0, s0, 1  // s0 = s0 + 1

    //----------------------------------------
    // bge (signed rs1 >= signed rs2)
    //----------------------------------------

    li t0, -1
    li t1, 0

    // bge (1): rs1 >= rs2 の場合ジャンプ
    bge t1, t0, bge1_ok
    j fail
bge1_ok:
    sw s0, 0(x10)   // LEDに8を出力
    addi s0, s0, 1  // s0 = s0 + 1

    // bge (2): rs1 < rs2 の場合ジャンプしない
    bge t0, t1, fail
bge2_ok:
    sw s0, 0(x10)   // LEDに9を出力
    addi s0, s0, 1  // s0 = s0 + 1

    // bge (3): rs1 == rs2 の場合ジャンプ
    bge t0, t0, bge3_ok
    j fail
bge3_ok:
    sw s0, 0(x10)   // LEDに10を出力
    addi s0, s0, 1  // s0 = s0 + 1

    //----------------------------------------
    // bltu (unsigned rs1  < unsigned rs2)
    //----------------------------------------

    li t0, 0xFFFFFFFF
    li t1, 0

    // bltu (1): rs1 < rs2 の場合ジャンプ
    bltu t1, t0, bltu1_ok
    j fail
bltu1_ok:
    sw s0, 0(x10)   // LEDに11を出力
    addi s0, s0, 1  // s0 = s0 + 1

    // bltu (2): rs1 >= rs2 の場合ジャンプしない
    bltu t0, t1, fail
bltu2_ok:
    sw s0, 0(x10)   // LEDに12を出力
    addi s0, s0, 1  // s0 = s0 + 1

    // bltu (3): rs1 == rs2 の場合ジャンプしない
    bltu t0, t0, fail
bltu3_ok:
    sw s0, 0(x10)   // LEDに13を出力
    addi s0, s0, 1  // s0 = s0 + 1


    //----------------------------------------
    // bgeu (unsigned rs1 >= unsigned rs2)
    //----------------------------------------

    li t0, 0xFFFFFFFF
    li t1, 0

    // bgeu (1): rs1 >= rs2 の場合ジャンプ
    bgeu t0, t1, bgeu1_ok
    j fail
bgeu1_ok:
    sw s0, 0(x10)   // LEDに14を出力
    addi s0, s0, 1  // s0 = s0 + 1

    // bgeu (2): rs1 < rs2 の場合ジャンプしない
    bgeu t1, t0, fail
bgeu2_ok:
    sw s0, 0(x10)   // LEDに15を出力
    addi s0, s0, 1  // s0 = s0 + 1

    // bgeu (3): rs1 == rs2 の場合ジャンプ
    bgeu t0, t0, bgeu3_ok
    j fail
bgeu3_ok:
    sw s0, 0(x10)   // LEDに16を出力
    addi s0, s0, 1  // s0 = s0 + 1

    // 無限ループ
loop:
    jal x0, loop
