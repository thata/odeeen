(* sin 関数 *)
let rec sin x =
  (* x が -PI から PI の間に収まるよう調整する *)
  let rec adjust x =
    if x > 3.141592653589793 then
      adjust (x -. 6.283185307179586)
    else if x < -3.141592653589793 then
      adjust (x +. 6.283185307179586)
    else
      x
  in
  let x = adjust x in
  let x2 = x *. x in
  let x3 = x *. x2 in
  let x5 = x3 *. x2 in
  let x7 = x5 *. x2 in
  let x9 = x7 *. x2 in
  x -. x3 /. 6.0 +. x5 /. 120.0 -. x7 /. 5040.0 +. x9 /. 362880.0
in
(* 度数法からラジアンへ変換 *)
let rec deg_to_rad deg =
  deg *. 3.141592653589793 /. 180.0
in
(* sin(0°) * 1000 *)
print_int (int_of_float (sin (deg_to_rad 0.0) *. 10000.0));
print_newline ();
(* sin(30°) * 1000 *)
print_int (int_of_float (sin (deg_to_rad 30.0) *. 10000.0));
print_newline ();
(* sin(45°) * 1000 *)
print_int (int_of_float (sin (deg_to_rad 45.0) *. 10000.0));
print_newline ();
(* sin(60°) * 1000 *)
print_int (int_of_float (sin (deg_to_rad 60.0) *. 10000.0));
print_newline ();
(* sin(90°) * 1000 *)
print_int (int_of_float (sin (deg_to_rad 90.0) *. 10000.0));
print_newline ();
(* アジャストのテスト *)
print_int (int_of_float (sin (deg_to_rad 0.0) *. 10000.0)); (* => 0 *)
print_newline ();
print_int (int_of_float (sin (deg_to_rad 720.0) *. 10000.0)); (* => 0 *)
print_newline ()
