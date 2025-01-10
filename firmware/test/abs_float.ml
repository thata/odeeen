(* abs_float 0.0 => 0.0 *)
print_int (int_of_float (abs_float 0.0 *. 1000.0));
print_newline ();
(* abs_float 1.0 => 1.0 *)
print_int (int_of_float (abs_float 1.0 *. 1000.0));
print_newline ();
(* abs_float (-1.0) => 1.0 *)
print_int (int_of_float (abs_float (-1.0) *. 1000.0));
print_newline ();
(* abs_float 1.1 => 1.1 *)
print_int (int_of_float (abs_float 1.1 *. 1000.0));
print_newline ();
(* abs_float (-1.1) => 1.1 *)
print_int (int_of_float (abs_float (-1.1) *. 1000.0));
print_newline ();
(* abs_float 1.9 => 1.9 *)
print_int (int_of_float (abs_float 1.9 *. 1000.0));
print_newline ();
(* abs_float (-1.9) => 1.9 *)
print_int (int_of_float (abs_float (-1.9) *. 1000.0));
print_newline ();
(* abs_float 2.1 => 2.1 *)
print_int (int_of_float (abs_float 2.1 *. 1000.0));
print_newline ();
(* abs_float (-2.1) => 2.1 *)
print_int (int_of_float (abs_float (-2.1) *. 1000.0));
print_newline ()
