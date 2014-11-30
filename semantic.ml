open Ast
open Str

type env = {
	mutable functions : func_decl list;
}

let func_equal_name name = function
 func-> func.fname = name

let func_exist func env = 
	let name = func.fname in
	   try
			   let _ = List.find (func_equal_name name) env.functions in
				   let e = "Duplicate function "^ name ^" has been defined more than once" in
					     raise (Failure e)
			with Not_found -> false
			