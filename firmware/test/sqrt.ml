(* 平方根 sqrt のテスト *)
let rec sqrt s =
  let x = s /. 2.0 in
  let last_x = 0.0 in
  let rec loop x last_x s =
    if x = last_x then
      x
    else
      loop ((x +. s /. x) /. 2.0) x s
    in
  loop x last_x s
in
(* sqrt(2) * 1000 = 1414 *)
print_int (int_of_float (sqrt 2.0 *. 1000.0));
print_newline ();
(* sqrt(3) * 1000 = 1732 *)
print_int (int_of_float (sqrt 3.0 *. 1000.0));
print_newline ();
(* sqrt(4) * 1000 = 2000 *)
print_int (int_of_float (sqrt 4.0 *. 1000.0));
print_newline ();
(* sqrt(5) * 1000 = 2236 *)
print_int (int_of_float (sqrt 5.0 *. 1000.0));
print_newline ()
