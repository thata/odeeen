    .text
    .globl min_caml_print_int
min_caml_print_int:
    // ひとまず LED に出力
    lui s0, 0xf0001
    sw a0, 0(s0)
    ret
