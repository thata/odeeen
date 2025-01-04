#define UART_DATA_OFFSET 0
#define UART_CTRL_OFFSET 4

//---------------------------------------------------------
// print_int: 整数を出力
// a0: 出力する整数
//---------------------------------------------------------
    .text
    .globl min_caml_print_int
min_caml_print_int:
    // 使用するレジスタ
    // s1: 出力する整数（作業用）
    // s2: 商

    // レジスタをスタックへ退避
    addi s10, s10, 12
    sw ra, -12(s10)
    sw s1, -8(s10)
    sw s2, -4(s10)


    bgt a0, zero, min_caml_print_int_positive

min_caml_print_int_negative:

    // 負数の場合、s1 に絶対値を格納
    mv s1, a0
    li t1, 0xffffffff
    xor s1, s1, t1

    // 出力する整数を、作業用レジスタ s1 にコピー
    addi s1, s1, 1

    // "-" を出力
    li a0, '-'
    call putc

    j min_caml_print_int_main

min_caml_print_int_positive:
    // 出力する整数を、作業用レジスタ s1 にコピー
    mv s1, a0

min_caml_print_int_main:

    // 10ケタ目を出力
    mv a0, s1 // 割られる数
    li a1, 1000000000 // 割る数
    call div
    mv s1, a1 // 新しい割られる数
    call print_num

    // 9ケタ目を出力
    mv a0, s1 // 割られる数
    li a1, 100000000 // 割る数
    call div
    mv s1, a1 // 新しい割られる数
    call print_num

    // 8ケタ目を出力
    mv a0, s1 // 割られる数
    li a1, 10000000 // 割る数
    call div
    mv s1, a1 // 新しい割られる数
    call print_num

    // 7ケタ目を出力
    mv a0, s1 // 割られる数
    li a1, 1000000 // 割る数
    call div
    mv s1, a1 // 新しい割られる数
    call print_num

    // 6ケタ目を出力
    mv a0, s1 // 割られる数
    li a1, 100000 // 割る数
    call div
    mv s1, a1 // 新しい割られる数
    call print_num

    // 5ケタ目を出力
    mv a0, s1 // 割られる数
    li a1, 10000 // 割る数
    call div
    mv s1, a1 // 新しい割られる数
    call print_num

    // 4ケタ目を出力
    mv a0, s1 // 割られる数
    li a1, 1000 // 割る数
    call div
    mv s1, a1 // 新しい割られる数
    call print_num

    // 3ケタ目を出力
    mv a0, s1 // 割られる数
    li a1, 100 // 割る数
    call div
    mv s1, a1 // 新しい割られる数
    call print_num

    // 2ケタ目を出力
    mv a0, s1 // 割られる数
    li a1, 10 // 割る数
    call div
    mv s1, a1 // 新しい割られる数
    call print_num

    // 1ケタ目を出力
    li t1, '0'
    add t2, t1, s1 // 出力する文字
    mv a0, t2
    call putc

    // レジスタの値を復元
    lw ra, -12(s10)
    lw s1, -8(s10)
    lw s2, -4(s10)
    addi s10, s10, -12
    ret

// 1桁の数字を出力。ただし、0の場合は何も出力しない
// a0: 出力する数字
print_num:
    // レジスタをスタックへ退避
    addi s10, s10, 4
    sw ra, -4(s10)

    // メイン処理
    beq a0, zero, print_num_break
    li t1, '0'
    add t2, t1, a0 // 出力する文字
    mv a0, t2
    call putc

print_num_break:
    // レジスタの値を復元
    lw ra, -4(s10)
    addi s10, s10, -4
    ret


// 割り算
//  a0: 割られる数
//  a1: 割る数
//  戻り値: 商
div:
    // レジスタをスタックへ退避
    addi s10, s10, 4
    sw ra, -4(s10)

    // メイン処理
    li t1, 0  // 商
    mv t2, a0 // 割られる数

div_loop:
    // 「割られる数 < 割る数」になるまで以下を繰り返す
    blt t2, a1, div_break

    // 割られる数から割る数を引く
    sub t2, t2, a1

    // 商をインクリメント
    addi t1, t1, 1

    // ループ
    j div_loop

div_break:
    // 商を返す
    mv a0, t1
    // 残った割られる数を返す
    mv a1, t2

    // レジスタの値を復元
    lw ra, -4(s10)
    addi s10, s10, -4
    ret


//---------------------------------------------------------
// getc: UARTから受信データを読み込む
// 戻り値: 受信データ
//---------------------------------------------------------
    .globl getc
getc:
    // ra をスタックへ退避
    addi s10, s10, 4
    sw ra, -4(s10)

    // 受信データが来るまで待機
    lw t0, UART_CTRL_OFFSET(gp)
    li t1, 1
    beq t0, t1, getc_break
    j getc
getc_break:
    lw a0, UART_DATA_OFFSET(gp)

    // ra レジスタの値を復元
    lw ra, -4(s10)
    addi s10, s10, -4
    ret


//---------------------------------------------------------
// putc: UARTへ送信データを書き込む
// a0: 送信データ
//---------------------------------------------------------
    .globl putc
putc:
    // ra をスタックへ退避
    addi s10, s10, 4
    sw ra, -4(s10)

    // メイン処理
    sw a0, UART_DATA_OFFSET(gp)
putc_wait:
    // 送信が終わるまで待機
    lw t0, UART_CTRL_OFFSET(gp)
    li t2, 2 // 送信中
    li t3, 3 // 送信中かつ受信済
    beq t0, t2, putc_wait
    beq t0, t3, putc_wait

putc_break:
    // ra レジスタの値を復元
    lw ra, -4(s10)
    addi s10, s10, -4
    ret


//---------------------------------------------------------
// 改行コードを出力
//---------------------------------------------------------
    .globl put_newline
put_newline:
    // ra をスタックへ退避
    addi s10, s10, 4
    sw ra, -4(s10)

    // 改行コードを出力
    li a0, '\n'
    call putc
    li a0, '\r'
    call putc

    // ra レジスタの値を復元
    lw ra, -4(s10)
    addi s10, s10, -4
    ret

//---------------------------------------------------------
// 画面をクリア
//---------------------------------------------------------
    .globl min_caml_clear_screen
min_caml_clear_screen:
    // ra をスタックへ退避
    addi s10, s10, 4
    sw ra, -4(s10)

    // 画面クリアのためのエスケープシーケンスを送信
    li a0, 27
    call putc
    li a0, '['
    call putc
    li a0, '2'
    call putc
    li a0, 'J'
    call putc

    // カーソルを左に移動
    li a0, 27
    call putc
    li a0, '['
    call putc
    li a0, 'H'
    call putc

    // ra レジスタの値を復元
    lw ra, -4(s10)
    addi s10, s10, -4
    ret


//---------------------------------------------------------
// 1秒間スリープ
//---------------------------------------------------------
    .globl sleep
sleep:
    // ra をスタックへ退避
    addi s10, s10, 4
    sw ra, -4(s10)

    // メイン処理
    li t0, 0
sleep_loop:
    addi t0, t0, 1
    li t1, 1000000
    beq t0, t1, sleep_break
    j sleep_loop

sleep_break:
    // ra レジスタの値を復元
    lw ra, -4(s10)
    addi s10, s10, -4
    ret

//---------------------------------------------------------
// float_of_int: 整数を浮動小数点数に変換
// a0: 整数
// 戻り値: 浮動小数点数
//
// fcvt.s.w 命令を利用して、整数を浮動小数点数に変換する
//---------------------------------------------------------
    .text
    .globl min_caml_float_of_int
min_caml_float_of_int:
    fcvt.s.w fa0, a0
    ret

//---------------------------------------------------------
// int_of_float: 浮動小数点数を整数に変換
// fa0: 浮動小数点数
// 戻り値: 整数
//
// fcvt.w.s 命令を利用して、浮動小数点数を整数に変換する
//---------------------------------------------------------
    .text
    .globl min_caml_int_of_float
min_caml_int_of_float:
    fcvt.w.s a0, fa0
    ret


//---------------------------------------------------------
// 改行コードを出力
//---------------------------------------------------------
    .globl min_caml_print_newline
min_caml_print_newline:
    // ra をスタックへ退避
    addi s10, s10, 4
    sw ra, -4(s10)

    // 改行コードを出力
    li a0, '\n'
    call putc
    li a0, '\r'
    call putc

    // ra レジスタの値を復元
    lw ra, -4(s10)
    addi s10, s10, -4
    ret
