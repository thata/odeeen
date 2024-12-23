#define UART_DATA_OFFSET 0
#define UART_CTRL_OFFSET 4

    .text
    .globl _start
_start:
    lui x3, 0xf0000 // UARTアクセス gp
    lui x4, 0xf0001 // LEDアクセス用 gp
loop:
    // UART制御レジスタの値を読み込む
    lw x5, UART_CTRL_OFFSET(x3)
    // 未受信データあり = 1
    li x6, 1
    // 受信データが届くまでループしながら待機
    beq x5, x6, break
    jal x0, loop
break:
    // UARTの受信データを読み込む
    lw x5, UART_DATA_OFFSET(x3)
    // 受信データをループバックする
    sw x5, UART_DATA_OFFSET(x3)
    // 受信データをLEDへ出力
    sw x5, 0(x4)
    jal x0, loop
