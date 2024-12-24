#define UART_DATA_OFFSET 0
#define UART_CTRL_OFFSET 4

// UARTループバック

    .text
    .globl _start
_start:
    lui gp, 0xf0000 // UARTアクセス gp
    lui tp, 0xf0001 // LEDアクセス用 gp
loop:
    call getc    // UARTからデータを受信
    sw a0, 0(tp) // LEDに受信データを出力
    call putc    // UARTへデータを送信
    j loop

// getc: UARTから受信データを読み込む
getc:
    // 受信データが来るまで待機
    lw t0, UART_CTRL_OFFSET(x3)
    li t1, 1
    beq t0, t1, getc_break
    j getc
getc_break:
    lw a0, UART_DATA_OFFSET(x3)
    ret

// putc: UARTへ送信データを書き込む
putc:
    sw a0, UART_DATA_OFFSET(x3)
putc_wait:
    // 送信が終わるまで待機
    lw t0, UART_CTRL_OFFSET(x3)
    li t2, 2 // 送信中
    li t3, 3 // 送信中かつ受信済
    beq t0, t2, putc_wait
    beq t0, t3, putc_wait
putc_break:
    ret
