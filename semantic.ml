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


(* let exists_formal_param func fpname = List.exists (function FParam(_,cn) -> cn = fpname) func.formals

(*Determines if a formal paramter with the given name 'fpname' exits in the given function*)
let exists_formal_param2 func fpname =
	match func with func -> exists_formal_param func fpname

let exists_variable_decl func vname = List.exists (function VDecl(_,vn,_) -> vn = vname) func.locals
(*Determines if a variable declaration with the given name 'vname' exists in the given functioin*)
let exists_variable_decl2 func vname =
	match func with func -> exists_variable_decl func vname

(*this gets formal paramters for function*)
let get_fparam_type func fpname =
	try
		let fparam = List.find (function FParam(_,cn) -> cn = fpname) func.formals in
			let FParam(dt,_) = fparam in
				dt 
	with Not_found -> raise (Failure ("Formal Parameter " ^ fpname ^ " should exist but was not found in compute function " ^ func.fname))

(*gets the variable type*)
let get_var_type func vname =
	try
		let var = List.find (function VDecl(_,vn,_) -> vn = vname) func.locals in
			let VDecl(dt,_,_) = var in
				dt (*return the data type*)
	with Not_found -> raise (Failure ("Variable " ^ vname ^ " should exist but was not found in compute function " ^ func.fname)) (*this shouldn't not happen*)

(*Returns the type of a given variable name *)
let get_type func name =
	if exists_variable_decl func name (*It's a variable*)
		then get_var_type func name
	else
		if exists_formal_param func name then
			get_fparam_type func name
		else (*Variable has not been declared as it was not found*)
			let e = "Variable " ^ name ^ " is being used without being declared in function " ^ func.fname in
				raise (Failure e)

(*Determines if the given identifier exists*)
let exists_id name func = (exists_variable_decl func name) or (exists_formal_param func name)

(*see if there is a function with given name "main"*)
let find_function func env =
	try
		let _ = List.find (function_equal_name main) env.functions in
			true (*return true on success*)
	with Not_found -> raise Not_found

 *)