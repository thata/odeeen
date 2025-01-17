// 1から10までの合計を LED に出力

    .text
    .globl _start
_start:
    lui x10, 0xf0001    // LEDアクセス用 gp
    // fa0 = -3.1415927410125732
    la t0, f_minus_3_1415927410125732
    flw fa0, 0(t0)
    // fa1 = -2.2831852436065674
    la t0, f_minus_2_2831852436065674
    flw fa1, 0(t0)
    // t0 = fa0 fle fa1
    fle.s t0, fa0, fa1
    // if t0 == 1 then OK else NG
    beq t0, x0, NG
OK:
    li t0, 128
    sw t0, 0(x10)
    jal x0, 0           // 無限ループ
NG:
    li t0, 1
    sw t0, 0(x10)
    jal x0, 0           // 無限ループ
f_minus_2_2831852436065674:
    .word 0xc0121fb5
f_minus_3_1415927410125732:
    .word 0xc0490fdb
