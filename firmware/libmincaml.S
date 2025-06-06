#define UART_DATA_OFFSET 0
#define UART_CTRL_OFFSET 4

//---------------------------------------------------------
// create_array
// a0: number of elements
// a1: initial value
//---------------------------------------------------------
  .globl min_caml_create_array
min_caml_create_array:
  mv t2, a0  // t2 = number of elements
  mv a0, s11 // a0 = hp
min_caml_create_array_loop:
  // if number of elements = 0
  beq t2, zero, min_caml_create_array_exit
  // if number of elements > 0
  sw a1, 0(s11)
  addi s11, s11, 4
  addi t2, t2, -1
  j min_caml_create_array_loop
min_caml_create_array_exit:
  ret

//---------------------------------------------------------
// create_float_array
// a0: number of elements
// fa0: initial value
//---------------------------------------------------------
  .globl min_caml_create_float_array
min_caml_create_float_array:
  mv t2, a0  // t2 = number of elements
  mv a0, s11 // a0 = hp
min_caml_create_float_array_loop:
  // if number of elements = 0
  beq t2, zero, min_caml_create_float_array_exit
  // if number of elements > 0
  fsw fa0, 0(s11)
  addi s11, s11, 4
  addi t2, t2, -1
  j min_caml_create_float_array_loop
min_caml_create_float_array_exit:
  ret

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
    // s3: 出力する整数

    // レジスタをスタックへ退避
    addi s10, s10, 16
    sw ra, -12(s10)
    sw s1, -8(s10)
    sw s2, -4(s10)
    sw s3, 0(s10)

    bge a0, zero, min_caml_print_int_positive

min_caml_print_int_negative:

    // 負数の場合、s1 に絶対値を格納
    mv s1, a0
    li t1, 0xffffffff
    xor s1, s1, t1

    // 出力する整数を、作業用レジスタ s1 と s3 にコピー
    addi s1, s1, 1
    mv s3, s1

    // "-" を出力
    li a0, '-'
    call putc

    j min_caml_print_int_main

min_caml_print_int_positive:
    // 出力する整数を、作業用レジスタ s1 と s3 にコピー
    mv s1, a0
    mv s3, s1

min_caml_print_int_main:

    // 10ケタ目を出力
    mv a0, s1 // 割られる数
    li a1, 1000000000 // 割る数
    blt s3, a1, min_caml_print_int_9 // 「出力する整数 < 割る数」の場合、次の桁へ進む
    call div
    mv s1, a1 // 新しい割られる数
    call print_num

    // 9ケタ目を出力
min_caml_print_int_9:
    mv a0, s1 // 割られる数
    li a1, 100000000 // 割る数
    blt s3, a1, min_caml_print_int_8 // 「出力する整数 < 割る数」の場合、次の桁へ進む
    call div
    mv s1, a1 // 新しい割られる数
    call print_num

    // 8ケタ目を出力
min_caml_print_int_8:
    mv a0, s1 // 割られる数
    li a1, 10000000 // 割る数
    blt s3, a1, min_caml_print_int_7 // 「出力する整数 < 割る数」の場合、次の桁へ進む
    call div
    mv s1, a1 // 新しい割られる数
    call print_num

    // 7ケタ目を出力
min_caml_print_int_7:
    mv a0, s1 // 割られる数
    li a1, 1000000 // 割る数
    blt s3, a1, min_caml_print_int_6 // 「出力する整数 < 割る数」の場合、次の桁へ進む
    call div
    mv s1, a1 // 新しい割られる数
    call print_num

    // 6ケタ目を出力
min_caml_print_int_6:
    mv a0, s1 // 割られる数
    li a1, 100000 // 割る数
    blt s3, a1, min_caml_print_int_5 // 「出力する整数 < 割る数」の場合、次の桁へ進む
    call div
    mv s1, a1 // 新しい割られる数
    call print_num

    // 5ケタ目を出力
min_caml_print_int_5:
    mv a0, s1 // 割られる数
    li a1, 10000 // 割る数
    blt s3, a1, min_caml_print_int_4 // 「出力する整数 < 割る数」の場合、次の桁へ進む
    call div
    mv s1, a1 // 新しい割られる数
    call print_num

    // 4ケタ目を出力
min_caml_print_int_4:
    mv a0, s1 // 割られる数
    li a1, 1000 // 割る数
    blt s3, a1, min_caml_print_int_3 // 「出力する整数 < 割る数」の場合、次の桁へ進む
    call div
    mv s1, a1 // 新しい割られる数
    call print_num

    // 3ケタ目を出力
min_caml_print_int_3:
    mv a0, s1 // 割られる数
    li a1, 100 // 割る数
    blt s3, a1, min_caml_print_int_2 // 「出力する整数 < 割る数」の場合、次の桁へ進む
    call div
    mv s1, a1 // 新しい割られる数
    call print_num

    // 2ケタ目を出力
min_caml_print_int_2:
    mv a0, s1 // 割られる数
    li a1, 10 // 割る数
    blt s3, a1, min_caml_print_int_1 // 「出力する整数 < 割る数」の場合、次の桁へ進む
    call div
    mv s1, a1 // 新しい割られる数
    call print_num

    // 1ケタ目を出力
min_caml_print_int_1:
    li t1, '0'
    add t2, t1, s1 // 出力する文字
    mv a0, t2
    call putc

    // レジスタの値を復元
    lw ra, -12(s10)
    lw s1, -8(s10)
    lw s2, -4(s10)
    lw s3, 0(s10)
    addi s10, s10, -16

    ret

// 1桁の数字を出力。ただし、0の場合は何も出力しない
// a0: 出力する数字
print_num:
    // レジスタをスタックへ退避
    addi s10, s10, 4
    sw ra, 0(s10)

    // メイン処理
    li t1, '0'
    add t2, t1, a0 // 出力する文字
    mv a0, t2
    call putc

    // レジスタの値を復元
    lw ra, 0(s10)
    addi s10, s10, -4
    ret


// 割り算
//  a0: 割られる数
//  a1: 割る数
//  戻り値: 商
div:
    // レジスタをスタックへ退避
    addi s10, s10, 4
    sw ra, 0(s10)

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
    lw ra, 0(s10)
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
    sw ra, 0(s10)

    // 受信データが来るまで待機
    lw t0, UART_CTRL_OFFSET(gp)
    li t1, 1
    beq t0, t1, getc_break
    j getc
getc_break:
    lw a0, UART_DATA_OFFSET(gp)

    // ra レジスタの値を復元
    lw ra, 0(s10)
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
    sw ra, 0(s10)

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
    lw ra, 0(s10)
    addi s10, s10, -4
    ret


//---------------------------------------------------------
// 改行コードを出力
//---------------------------------------------------------
    .globl put_newline
put_newline:
    // ra をスタックへ退避
    addi s10, s10, 4
    sw ra, 0(s10)

    // 改行コードを出力
    li a0, '\n'
    call putc
    li a0, '\r'
    call putc

    // ra レジスタの値を復元
    lw ra, 0(s10)
    addi s10, s10, -4
    ret

//---------------------------------------------------------
// 画面をクリア
//---------------------------------------------------------
    .globl min_caml_clear_screen
min_caml_clear_screen:
    // ra をスタックへ退避
    addi s10, s10, 4
    sw ra, 0(s10)

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
    lw ra, 0(s10)
    addi s10, s10, -4
    ret


//---------------------------------------------------------
// 1秒間スリープ
//---------------------------------------------------------
    .globl sleep
sleep:
    // ra をスタックへ退避
    addi s10, s10, 4
    sw ra, 0(s10)

    // メイン処理
    li t0, 0
sleep_loop:
    addi t0, t0, 1
    li t1, 1000000
    beq t0, t1, sleep_break
    j sleep_loop

sleep_break:
    // ra レジスタの値を復元
    lw ra, 0(s10)
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
    // スタックへ退避
    addi s10, s10, 4
    sw ra, 0(s10)

    fcvt.s.w fa0, a0

    // ra レジスタの値を復元
    lw ra, 0(s10)
    addi s10, s10, -4
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
    // スタックへ退避
    addi s10, s10, 4
    sw ra, 0(s10)

    fcvt.w.s a0, fa0

    // ra レジスタの値を復元
    lw ra, 0(s10)
    addi s10, s10, -4
    ret

//---------------------------------------------------------
// truncate: 浮動小数点数を整数に変換(int_of_float のエイリアス)
// fa0: 浮動小数点数
// 戻り値: 整数
//
// fcvt.w.s 命令を利用して、浮動小数点数を整数に変換する
//---------------------------------------------------------
    .text
    .globl min_caml_truncate
min_caml_truncate:
    // スタックへ退避
    addi s10, s10, 4
    sw ra, 0(s10)

    fcvt.w.s a0, fa0

    // ra レジスタの値を復元
    lw ra, 0(s10)
    addi s10, s10, -4
    ret

//---------------------------------------------------------
// 改行コードを出力
//---------------------------------------------------------
    .globl min_caml_print_newline
min_caml_print_newline:
    // ra をスタックへ退避
    addi s10, s10, 4
    sw ra, 0(s10)

    // 改行コードを出力
    li a0, '\n'
    call putc
    li a0, '\r'
    call putc

    // ra レジスタの値を復元
    lw ra, 0(s10)
    addi s10, s10, -4
    ret

//---------------------------------------------------------
// min_caml_abs_float: 絶対値を返す
// (float -> float)
//---------------------------------------------------------
    .text
    .globl min_caml_abs_float
min_caml_abs_float:
    // t1 = fa0
    fmv.x.w t1, fa0
    // 符号ビットに0（正）をセット
    li t2, 0x7fffffff
    and t1, t1, t2
    // fa0 = t1
    fmv.w.x fa0, t1
    ret

//---------------------------------------------------------
// min_caml_print_byte (int -> void)
//---------------------------------------------------------
    .text
    .globl min_caml_print_byte
min_caml_print_byte:
    // ra をスタックへ退避
    addi s10, s10, 4
    sw ra, 0(s10)

    // メイン処理
    call putc

    // ra レジスタの値を復元
    lw ra, 0(s10)
    addi s10, s10, -4
    ret

//---------------------------------------------------------
// min_caml_read_byte (void -> int)
//---------------------------------------------------------
    .text
    .globl min_caml_read_byte
min_caml_read_byte:
    // ra をスタックへ退避
    addi s10, s10, 4
    sw ra, 0(s10)

    // メイン処理
    call getc

    // ra レジスタの値を復元
    lw ra, 0(s10)
    addi s10, s10, -4
    ret

//---------------------------------------------------------
// 添付データから1バイト読み込み
//---------------------------------------------------------
    .text
    .globl min_caml_read_byte2
min_caml_read_byte2:
    // ra をスタックへ退避
    addi s10, s10, 4
    sw ra, 0(s10)

    // SLD データインデックスを読み込み
    la t0, sld_data_index
    lw t1, 0(t0)

    // SLD データを読み込み
    la t0, sld_data
    add t0, t0, t1
    lw a0, 0(t0)

    // SLD データインデックスをインクリメント
    la t0, sld_data_index
    lw t1, 0(t0)
    addi t1, t1, 4
    sw t1, 0(t0)

    // ra レジスタの値を復元
    lw ra, 0(s10)
    addi s10, s10, -4
    ret

//---------------------------------------------------------
// SLD データ
//---------------------------------------------------------

// sld_data.S をインクルード
    .text
	.align 4
	.globl sld_data
sld_data:
.include "firmware/sld_data.s"

sld_data_index:
    .int 0

//---------------------------------------------------------
// SLD インデックスの初期化
//---------------------------------------------------------
    .text
    .globl min_caml_init_sld_data_index
min_caml_init_sld_data_index:
    la t0, sld_data_index
    sw zero, 0(t0)
    ret
