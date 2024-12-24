#define UART_DATA_OFFSET 0
#define UART_CTRL_OFFSET 4

// Hello World !!
    .text
    .globl _start
_start:
    lui gp, 0xf0000 // UARTアクセス gp
loop:
    li a0, 'H'
    call putc
    li a0, 'e'
    call putc
    li a0, 'l'
    call putc
    li a0, 'l'
    call putc
    li a0, 'o'
    call putc
    li a0, ' '
    call putc
    li a0, 'W'
    call putc
    li a0, 'o'
    call putc
    li a0, 'r'
    call putc
    li a0, 'l'
    call putc
    li a0, 'd'
    call putc
    li a0, ' '
    call putc
    li a0, '!'
    call putc
    call putc
    li a0, '\n'
    call putc
    li a0, '\r'
    call putc
    call sleep
    j loop

// getc: UARTから受信データを読み込む
// (1) UART制御レジスタの値を読み込む
// (2) (1)で取得した値が1であれば、受信処理へ進む。無ければ(1)へ戻る
// (3) UARTの受信データを読み込む
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

// 1秒間スリープ
sleep:
    li t0, 0
sleep_loop:
    addi t0, t0, 1
    li t1, 1000000
    beq t0, t1, sleep_break
    j sleep_loop
sleep_break:
    ret