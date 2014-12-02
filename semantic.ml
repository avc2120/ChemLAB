open Ast

type env = {
	mutable functions : func_decl list;
}

let function_equal_name name = function
 func-> func.fname = name

(* Checks whether a function has been defined duplicately *)
let function_exist func env = 
	let name = func.fname in
	   try
			   let _ = List.find (function_equal_name name) env.functions in
				   let e = "Duplicate function "^ name ^" has been defined more than once" in
					     raise (Failure e)
			with Not_found -> false

(*Checks if function has been declared*)
let exist_function_name name env = List.exists (function_equal_name name) env.functions

let get_function_by_name name env = 
	try
		   let result = List.find (function_equal_name name) env.functions in
			      result
  with Not_found -> raise(Failure("Function "^ name ^ " has not been declared!"))

let count_function_params func = function a
-> let f count b = 
	if b=a then count+1
else count 
in 
let count = List.fold_left f 0 func.formals in
	if count > 0
		then raise (Failure("Duplicate parameter in function " ^ func.fname))
	else
	count