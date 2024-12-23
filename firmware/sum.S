// 1から10までの合計を LED に出力

    .text
    .globl _start
_start:
    lui x10, 0xf0001    // LEDアクセス用 gp
    addi x5, x0, 0      // sum = 0
    addi x6, x0, 10     // i = 10
loop:
    beq x6, x0, break   // if (i == 0) break
    add x5, x5, x6      // sum += i
    addi x6, x6, -1     // i--
    jal x0, loop
break:
    sw x5, 0(x10)       // LED に sum を出力
    jal x0, 0           // 無限ループ

