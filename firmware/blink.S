// LED に 1010_1010 のパターンを出力
    .text
    .globl _start
_start:
    lui x10, 0xf0001    // LEDアクセス用 gp
    addi x5, x0, 0xAA   // x5 = 1010_1010
    sw x5, 0(x10)       // LED に x5 を出力
loop:
    jal x0, loop
