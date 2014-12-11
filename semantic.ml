open Ast
open Str

type env = {
	mutable functions : func_decl list;
}

let function_equal_name name = function
 func-> func.fname = name

let function_fparam_name name = function
par -> par.paramname = name

let function_var_name name = function
variable -> variable.vname = name

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

(*Determines if a formal paramter with the given name 'fpname' exits in the given function*)

let exists_formal_param func fpname =
try
 List.exists (function_fparam_name fpname) func.formals
with Not_found -> raise (Failure ("Formal Parameter " ^ fpname ^ " should exist but was not found in compute function " ^ func.fname)) 

(*Determines if a variable declaration with the given name 'vname' exists in the given functioin*)

let exists_variable_decl func vname = 
try
	List.exists (function_var_name vname) func.locals
with Not_found -> raise (Failure ("Variable " ^ vname ^ " should exist but was not found in compute function " ^ func.fname)) 


(*Determines if the given identifier exists*)
let exists_id name func = (exists_variable_decl func name) || (exists_formal_param func name)


(*see if there is a function with given name*)
let find_function func env =
	try
		let _ = List.find (function_equal_name func) env.functions in
			true (*return true on success*)
	with Not_found -> raise Not_found

let is_int s =
	try ignore (int_of_string s); true
	with _ -> false

let is_float s =
	try ignore (float_of_string s); true
	with _ -> false

let is_letter s = string_match (regexp "[A-Za-z]") s 0

let is_string s = string_match (regexp "\".*\"") s 0

let is_string_bool = function "true" -> true | "false" -> true | _ -> false





let check_program flist =
	let (enviornment: env) = { functions = [] } in
		let _dovalidation = List.map ( fun(f) -> valid_func environment f) flist in
		let _ = print_endline "\nSemantic analysis completed successfully.\nCompiling...\n" in
					true



(*
let get_fparam_type func fpname =
	try
		let fparam = List.find (function_equal_name func) func.formals in
				 
	with Not_found -> raise (Failure ("Formal Parameter " ^ fpname ^ " should exist but was not found in compute function " ^ func.fname)) (*this shouldn't not happen*)

*)

