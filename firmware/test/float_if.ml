let a = 1.23 in
let b = 2.45 in
let rec test1 x y =
  (* IfFEq で真の場合 *)
  if x = y then
    print_int 1
  else
    print_int 0 in
let rec test2 x y =
  (* IfFEq で偽の場合 *)
  if x = y then
    print_int 0
  else
    print_int 1 in
let rec test3 x y =
  (* IfFLE で真の場合 *)
  if x <= y then
    print_int 1
  else
    print_int 0 in
let rec test4 x y =
  (* IfFLE で偽の場合 *)
  if x <= y then
    print_int 0
  else
    print_int 1 in
let rec test5 x y =
  if x = y then 1 else 0
in

test1 a a;
test2 a b;
test3 a b;
test4 b a;
print_int (test5 a a);
print_newline ()
