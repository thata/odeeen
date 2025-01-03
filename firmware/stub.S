//-------------------------------------------------------------------------
// min_caml_start を呼び出すためのスタブ
//-------------------------------------------------------------------------
    .text
    .globl _start
_start:
    lui gp, 0xf0000 // UARTアクセス用レジスタ
    lui tp, 0xf0001 // LEDアクセス用レジスタ

    // スタックポインタの開始アドレス (0x4F000000 ~ 0x4FFFFFFF)
    li s10, 0x4F000000

    // ヒープポインタの開始アドレス (0x4E000000 ~ 0x4EFFFFFF)
    li s11, 0x4E000000

    call min_caml_clear_screen

    // スタックポインタのアドレスとヒープポインタのアドレスを引数に min_caml_start を呼び出す
    li a0, 0x4F000000
    li a1, 0x4E000000
    call min_caml_start
loop:
    j loop
