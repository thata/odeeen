(* floor関数のテスト *)

(* floor 関数 *)
(*
  floor(0.0) -> 0.0
  floor(1.0) -> 1.0
  floor(1.1) -> 1.0
  floor(1.9) -> 1.0
  floor(2.1) -> 2.0
  floor(-1.0) -> -1.0
  floor(-1.1) -> -2.0
  floor(-1.9) -> -2.0
*)
let rec floor x =
  if x >= 0.0 then
    float_of_int (int_of_float x)
  else
    if x = float_of_int (int_of_float x) then
      x
    else
      float_of_int (int_of_float (x -. 1.0))
in
(* floor(0.0) = 0.0 *)
print_int (int_of_float (floor 0.0 *. 1000.0));
print_newline ();
(* floor(1.0) = 1.0 *)
print_int (int_of_float (floor 1.0 *. 1000.0));
print_newline ();
(* floor(1.1) = 1.0 *)
print_int (int_of_float (floor 1.1 *. 1000.0));
print_newline ();
(* floor(1.9) = 1.0 *)
print_int (int_of_float (floor 1.9 *. 1000.0));
print_newline ();
(* floor(2.1) = 2.0 *)
print_int (int_of_float (floor 2.1 *. 1000.0));
print_newline ();
(* floor(-1.0) = -1.0 *)
print_int (int_of_float (floor (-1.0) *. 1000.0));
print_newline ();
(* floor(-1.1) = -2.0 *)
print_int (int_of_float (floor (-1.1) *. 1000.0));
print_newline ();
(* floor(-1.9) = -2.0 *)
print_int (int_of_float (floor (-1.9) *. 1000.0));
print_newline ()
