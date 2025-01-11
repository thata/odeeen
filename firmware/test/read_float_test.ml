(* "-" -> 45 *)
(* "." -> 46 *)
(* "0" -> 48 *)
(* "9" -> 57 *)
(* " " -> 32 *)
(* TAB -> 9 *)
(* CR -> 10 *)
(* LF -> 13 *)
let rec read_float _ =
  (* 小数部分をパース *)
  let rec parse_fraction _ =
    let c = read_byte () in
    if c >= 48 then
      if c <= 57 then
        (* 0 ~ 9 の場合 *)
        let i = float_of_int (c - 48) in
        i +. parse_fraction () /. 10.0
      else
        (* 数字以外が来たら、パースを終える *)
        0.0
    else
      (* 数字以外が来たら、パースを終える *)
      0.0
  in
  (* 整数部分をパース *)
  let rec parse_float acc =
    let c = read_byte () in
    if c = 46 then
      (* "." の場合、小数点部分を読み込む *)
      acc +. (parse_fraction () /. 10.0)
    else if c >= 48 then
      if c <= 57 then
        (* 0 ~ 9 の場合 *)
        let i = float_of_int (c - 48) +. acc *. 10.0 in
        parse_float i
      else
        (* 数字以外が来たら、パースを終える *)
        acc
    else
      (* 数字以外が来たら、パースを終える *)
      acc
  in
  let c = read_byte () in
  if c = 32 then
    (* 空白の場合、次のトークン取得へ *)
    read_float ()
  else if c = 9 then
    (* TAB の場合、次のトークン取得へ *)
    read_float ()
  else if c = 10 then
    (* 改行の場合、次のトークン取得へ *)
    read_float ()
  else if c = 13 then
    (* 改行の場合、次のトークン取得へ *)
    read_float ()
  else if c = 45 then
    (* "-" の場合 *)
    (parse_float 0.0) *. -1.0
  else if c >= 48 then
    if c <= 57 then
      (* 0 ~ 9 の場合 *)
      parse_float (float_of_int (c - 48))
    else
      (* エラーっぽい値を返しておく *)
      -11111.0
  else
    (* エラーっぽい値を返しておく *)
    -11111.0
in
print_int (int_of_float (read_float () *. 1000.0));
print_newline ()
