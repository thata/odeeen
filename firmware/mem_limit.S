#define UART_DATA_OFFSET 0
#define UART_CTRL_OFFSET 4

//---------------------------------------------------------
// SDRAM リミット確認プログラム
//
// 0x40000000 ~ 0x40FFFFFF までのデータを読み書きし、
// 書き込んだ値と読み込んだ値が合っていれば次のアドレスへ進む。
// 値が合っていなければ、そのアドレスを UART へ送信する。
// すべてのアドレスの確認が終わったら、OK を UART へ送信する。
//---------------------------------------------------------
    .text
    .globl _start
_start:
    lui gp, 0xf0000     // UARTアクセス gp
    lui tp, 0xf0001     // LEDアクセス用 gp
    li s0, 0x40000000   // データ領域開始アドレス（SDRAM）
    li s1, 0x50000000   // データ領域終了アドレス（SDRAM）
    li s2, 0xDEADBEEF   // テストデータ
    li s3, 0x2          // 書き込み中
    li s4, 0x4          // 読み込み中

loop:
    beq s0, s1, loop_break
    sw s3, 0(tp) // 書き込み中 LED = 2
    sw s2, 0(s0)
    sw s4, 0(tp) // 読み込み中 LED = 4
    lw t0, 0(s0)
    sw s4, 0(tp) // 比較中 LED = 0
    bne t0, s2, error
    // 次のアドレスへ
    addi s0, s0, 4
    j loop

loop_break:
    li t0, 128
    sw t0, 0(tp)
aaa:
    j aaa


error:
    li t0, 1
    sw t0, 0(tp)
bbb:
    j bbb


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
