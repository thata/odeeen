#define UART_DATA_OFFSET 0
#define UART_CTRL_OFFSET 4

// MinCaml のライブラリ関数の動作確認用
// NOTE: スタックポインタは sp ではなく s10 を使う

    .text
    .globl _start
_start:
    lui gp, 0xf0000 // UARTアクセス用レジスタ
    lui tp, 0xf0001 // LEDアクセス用レジスタ
    li s10, 0x4F000000 // スタックポインタの開始アドレス
    li s11, 0x4E000000 // ヒープポインタの開始アドレス

// xor が正常に動いていないような...
test:
    li t1, 0xAAAAAAAA
    li t2, 0xFFFFFFFF
    xor t3, t1, t2
    li t4, 0x55555555
    beq t3, t4, ok_label
    j ng_label
ok_label:
    li t1, 128
    sw t1, 0(tp)
    j test
ng_label:
    li t1, 1
    sw t1, 0(tp)
    j test

loop:
    call getc    // UARTからデータを受信

    // call putc    // UARTへデータを送信
    li a0, 2147483647
    call min_caml_print_int

    j loop

// a0 に渡された整数を ASCII 形式の文字列として UART に出力する
// 疑似コード:
//
// def min_caml_print_int(a0)
//   s0 = a0
//
//   # 最上位ビットを取得
//   msb =  (n & 0x80000000) >> 31
//
//   if msb == 1
//     # "-" を出力
//     putc "-"
//
//     # 負数の絶対値を取得
//     s0 = ((s0 & 0xffffffff) ^ 0xffffffff) + 1
//   end
//
//   # 10ケタ目を出力
//   q = div(s0, 1000000000)
//   s0 = s0 - q * 1000000000
//   c = ('0'.ord + q).chr
//   putc(c) if q > 0
//
//   # 9ケタ目を出力
//   q = div(s0, 100000000)
//   s0 = s0 - q * 100000000
//   c = ('0'.ord + q).chr
//   putc(c) if q > 0
//
//   # 8ケタ目を出力
//   q = div(s0, 10000000)
//   s0 = s0 - q * 10000000
//   c = ('0'.ord + q).chr
//   putc(c) if q > 0
//
//   # 7ケタ目を出力
//   q = div(s0, 1000000)
//   s0 = s0 - q * 1000000
//   c = ('0'.ord + q).chr
//   putc(c) if q > 0
//
//   # 6ケタ目を出力
//   q = div(s0, 100000)
//   s0 = s0 - q * 100000
//   c = ('0'.ord + q).chr
//   putc(c) if q > 0
//
//   # 5ケタ目を出力
//   q = div(s0, 10000)
//   s0 = s0 - q * 10000
//   c = ('0'.ord + q).chr
//   putc(c) if q > 0
//
//   # 4ケタ目を出力
//   q = div(s0, 1000)
//   s0 = s0 - q * 1000
//   c = ('0'.ord + q).chr
//   putc(c) if q > 0
//
//   # 3ケタ目を出力
//   q = div(s0, 100)
//   s0 = s0 - q * 100
//   c = ('0'.ord + q).chr
//   putc(c) if q > 0
//
//   # 2ケタ目を出力
//   q = div(s0, 10)
//   s0 = s0 - q * 10
//   c = ('0'.ord + q).chr
//   putc(c) if q > 0
//
//   # 1ケタ目を出力
//   putc ('0'.ord + s0).chr
// end
//
// # 割り算
// def div(n, d)
//   raise "err" if n < 0
//   raise "err" if d <= 0
//
//   q = 0
//   r = n
//
//   while r >= d
//     r = r - d
//     q = q + 1
//   end
//
//   return q
// end

min_caml_print_int:
    // 使用するレジスタ
    // s1: 出力する整数（作業用）
    // s2: 商

    // レジスタをスタックへ退避
    addi s10, s10, 12
    sw ra, -12(s10)
    sw s1, -8(s10)
    sw s2, -4(s10)

    // 出力したい整数（作業用）を s1 にコピー

    // TODO: 負数の絶対値がうまく取れて無いような気がする...
    bgt a0, zero, min_caml_print_int_positive
    // 負数の場合、s1 に絶対値を格納
    mv s1, a0
    li t1, 0xffffffff
    xor s1, s1, t1
    addi s1, s1, 1
    mv a0, s1

min_caml_print_int_positive:
    mv s1, a0

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


// getc: UARTから受信データを読み込む
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

// putc: UARTへ送信データを書き込む
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

// 改行コードを出力
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

// 1秒間スリープ
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