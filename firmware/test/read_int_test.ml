let rec read_int _ =
  (* let read_byte () = input_byte stdin in *)
  (* 整数部分をパース *)
  let rec parse_int acc =
    let c = read_byte () in
    if c >= 48 then
      if c <= 57 then
        (* 0 ~ 9 の場合 *)
        let i = (c - 48) + (acc + acc + acc + acc + acc + acc + acc + acc + acc + acc) in
        parse_int i
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
    read_int ()
  else if c = 9 then
    (* TAB の場合、次のトークン取得へ *)
    read_int ()
  else if c = 10 then
    (* 改行の場合、次のトークン取得へ *)
    read_int ()
  else if c = 13 then
    (* 改行の場合、次のトークン取得へ *)
    read_int ()
  else if c = 45 then
    (* "-" の場合 *)
    0 - (parse_int 0)
  else if c >= 48 then
    if c <= 57 then
      (* 0 ~ 9 の場合 *)
      parse_int (c - 48)
    else
      (* エラーっぽい値を返しておく *)
      -11111111
  else
    (* エラーっぽい値を返しておく *)
    -11111111
in

let rec loop _ =
  let i = read_int () in
  print_int i;
  print_newline ();
  loop ()
in
loop ()
