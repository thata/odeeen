(* cos 関数 *)
let rec cos x =
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
  let x4 = x2 *. x2 in
  let x6 = x4 *. x2 in
  let x8 = x6 *. x2 in
  let x10 = x8 *. x2 in
  1.0 -. x2 /. 2.0 +. x4 /. 24.0 -. x6 /. 720.0 +. x8 /. 40320.0 -. x10 /. 3628800.0
in
(* 度数法からラジアンへ変換 *)
let rec deg_to_rad deg =
  deg *. 3.141592653589793 /. 180.0
in
(* cos(0°) * 10000 = 10000 *)
print_int (int_of_float (cos (deg_to_rad 0.0) *. 10000.0));
print_newline ();
(* cos(30°) * 10000 = 8660 *)
print_int (int_of_float (cos (deg_to_rad 30.0) *. 10000.0));
print_newline ();
(* cos(45°) * 10000 = 7071 *)
print_int (int_of_float (cos (deg_to_rad 45.0) *. 10000.0));
print_newline ();
(* cos(60°) * 10000 = 5000 ≒ 4999 *)
print_int (int_of_float (cos (deg_to_rad 60.0) *. 10000.0));
print_newline ();
(* cos(90°) * 10000 = 0 *)
print_int (int_of_float (cos (deg_to_rad 90.0) *. 10000.0));
print_newline ()
