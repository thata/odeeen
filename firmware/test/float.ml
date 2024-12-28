(* このテストを実行する場合は、Main.file等を呼び出す前に
   Typing.extenvを:=等で書き換えて、あらかじめsinやcosなど
   外部関数の型を陽に指定する必要があります（そうしないと
   MinCamlでは勝手にint -> intと推論されるため）。 *)

let rec cos x =
   let pi = 3.141592654 in
   if x >= 0.0 then
      if x <= pi then
         let x2 = x *. x in
         1.0 -. x2 *. (0.5 -. x2 *. (0.04166666667 -. x2 *. (0.001388888889 -. x2 *. 0.00002480158730)))
      else
         if x <= 2.0 *. pi then
         -. cos(x -. pi)
         else
         cos(x -. 2.0 *. pi)
   else
      cos(-. x)
   in
let rec sin x =
   let pi = 3.141592654 in
   if x >= 0.0 then
      if x <= pi then
         let x2 = x *. x in
         x *. (1.0 -. x2 *. (0.1666666667 -. x2 *. (0.008333333333 -. x2 *. 0.0001984126984)))
      else
         if x <= 2.0 *. pi then
         -. sin(x -. pi)
         else
         sin(x -. 2.0 *. pi)
   else
      -. sin(-. x)
   in
print_int
  (int_of_float
     ((sin (cos (sqrt (abs_float (-12.3))))
         +. 4.5 -. 6.7 *. 8.9 /. 1.23456789)
        *. float_of_int 1000000))
(* float な min-caml だと -44604260 が返る *)
(* double な OCaml だと -44604262 が返る *)
