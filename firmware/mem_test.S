#define UART_DATA_OFFSET 0
#define UART_CTRL_OFFSET 4

//---------------------------------------------------------
// SDRAM メモリ読み書きテスト
//
// 0x40000000 番地から始まる SDRAM にデータを書き込み、
// そこから読み出したデータを UART へ送信する。
//---------------------------------------------------------
    .text
    .globl _start
_start:
    lui gp, 0xf0000     // UARTアクセス gp
    lui tp, 0xf0001     // LEDアクセス用 gp
    li s0, 0x40000000   // データ領域開始アドレス（SDRAM）

    // SDRAM へデータを格納して...
    li t0, 'A'
    sw t0, 0(s0)
    li t0, 'B'
    sw t0, 4(s0)
    li t0, 'C'
    sw t0, 8(s0)

loop:
    // SDRAM から読み出したデータを UART へ送信
    lw a0, 0(s0)
    sw a0, 0(tp)
    call putc
    call sleep

    lw a0, 4(s0)
    sw a0, 0(tp)
    call putc
    call sleep

    lw a0, 8(s0)
    sw a0, 0(tp)
    call putc
    call sleep

    j loop

//---------------------------------------------------------
// getc: UARTから受信データを読み込む
//---------------------------------------------------------
getc:
    // 受信データが来るまで待機
    lw t0, UART_CTRL_OFFSET(x3)
    li t1, 1
    beq t0, t1, getc_break
    j getc
getc_break:
    lw a0, UART_DATA_OFFSET(x3)
    ret

//---------------------------------------------------------
// putc: UARTへ送信データを書き込む
//---------------------------------------------------------
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

//---------------------------------------------------------
// だいたい1秒間スリープ
//---------------------------------------------------------
sleep:
    li t0, 0
sleep_loop:
    addi t0, t0, 1
    li t1, 1000000
    beq t0, t1, sleep_break
    j sleep_loop
sleep_break:
    ret
