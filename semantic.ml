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
			   let e = "Duplicate function: "^ name ^" has been defined more than once" in
				   raise (Failure e)
		with Not_found -> false




(*Checks if function has been declared*)
let exist_function_name name env = List.exists (function_equal_name name) env.functions


let get_function_by_name name env = 
	try
		   let result = List.find (function_equal_name name) env.functions in
			      result
  with Not_found -> raise(Failure("Function "^ name ^ " has not been declared!"))


let get_formal_by_name name func = 
	try
		let result = List.find(function_fparam_name name) func.formals in
			result
	with Not_found -> raise(Failure("Formal Param" ^ name ^ " has not been declared!"))

let get_variable_by_name name func = 
	try
		let result = List.find(function_var_name name) func.locals in
		result
	with Not_found -> raise(Failure("Local Variable " ^ name ^ "has not been declared!"))


let count_function_params func = function
	a -> let f count b = 
	if b = a 
		then count+1
		else count 
in 
	let count = List.fold_left f 0 func.formals in
		if count > 0
			then raise (Failure("Duplicate parameter in function " ^ func.fname))
			else count

(*Determines if a formal paramter with the given name ‘fpname’ exits in the given function*)

let exists_formal_param func fpname =
try
 List.exists (function_fparam_name fpname) func.formals
with Not_found -> raise (Failure ("Formal Parameter " ^ fpname ^ " should exist but was not found in compute function " ^ func.fname))


(*Determines if a variable declaration with the given name ‘vname’ exists in the given functioin*)

let exists_variable_decl func vname =
try
 List.exists (function_var_name vname) func.locals
with Not_found -> raise (Failure ("Variable " ^ vname ^ " should exist but was not found in compute function " ^ func.fname))




let dup_param_name func fpname = 
	let name = func.formals in
		try 
			List.find (function name -> name.paramname = fpname.paramname ) name 
	with Not_found -> raise (Failure ("Duplicate param names"))


let get_fparam_type func fpname = 
	let name = func.formals in
		try
			let fparam = List.find(function_fparam_name fpname) name in
				fparam.paramtype
		with Not_found -> raise (Failure ("Formal param should exist but not found"))


let get_var_type func vname = 
	let name = func.locals in 
		try
			let var = List.find(function_var_name vname) name in 
				var.vtype
		with Not_found -> raise (Failure ("Variable should exist but not found"))





(*
let param_exist func = 
	let name = func.formals in
	try
		let _ = List.iter (fun f -> List.find (exists_formal_param func f) ) name in
			let e = "Duplicate param: "^ name ^"has been defined more than once" in
				raise (Failure e)
	with Not_found -> false


let get_fparam_type func fpname = 
		try  
			let fparam = 


*)




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


(*Returns the type of a given variable name *)
let get_type func name =
	if exists_variable_decl func name (* True if there exists a var of that name *)
		then get_var_type func name
		else
			if exists_formal_param func name 
				then get_fparam_type func name
				else (*Variable has not been declared as it was not found*)
					let e = "Variable " ^ name ^ " is being used without being declared in function " ^ func.fname in
						raise (Failure e)

let rec get_expr_type expr func = 
	(* Gabe *)

let check_if_else stmt_list = 
	(* Gabe *)

let rec valid_expr expr env =
	

let valid_body func env = 
	let rec check_stmt = function
		  (* Check all statements in a block recursively, will throw error for an invalid stmt *)
		  Block(stmt_list) -> let _ = List.map(fun(s) -> check_stmt s) stmt_list in
		  	true
		| Expr(expr) -> let _ = valid_expr expr env in
			true
		| Return(expr) -> let _ = valid_expr expr env in
			true
		| If(condition, then_stmts, else_stmts) -> let cond_type = get_expr_type condition func in
			match cond_type with
				  Boolean -> 
				  	if (check_stmt then_stmts) && (check_stmt else_stmts)
				  		then true
				  		else raise( Failure("Invalid statements in If statement within function " ^ func.fname))
				| _ -> raise( Failure("Condition of If statement is not a valid boolean expression within function " ^ func.fname) )

		| For(init, condition, do_expr, stmts) -> let cond_type = get_expr_type condition func in 
			let valid_do_expr = valid_expr do_expr env in 
				let valid_init = valid_expr init env in
					match cond_type with 
						  Boolean -> 
						  	if check_stmt stmts
						  		then true
						  		else raise( Failure("Invalid statements in For loop within function " ^ func.fname))
						| _ -> raise( Failure("Condition of For loop is not a valid boolean expression within function " ^ func.fname) )

		| While(condition, stmts) -> let cond_type = get_expr_type condition func in
			match cond_type with
				  Boolean -> 
				  	if check_stmt stmts
				  		then true
						else raise( Failure("Invalid statments in While loop within function " ^ func.fname ) )
				| _ -> raise( Failure("Condition of While loop is not a valid boolean expression within function " ^ func.fname) )

		| Print(expr) -> let expr_type = get_expr_type expr in
			match expr_type with
				  String -> true
				| _ -> raise( Failure("Print in function " ^ func.fname ^ " does not match string type") )
	
	in
		let _ = List.map(check_stmt) func.body in
			true

let valid_func env f = 
	let duplicate_functions = function_exist f env in 
		let duplicate_parameters = count_function_params f in
			let v_body = valid_body f env in 
				let _ = env.functions <- f :: env.functions (* Adding function to environment *) in
					(not duplicate_functions)



let check_program flist =
	let (environment : env) = { functions = [] (* ; variables = [] *) } in
		let _validate = List.map ( fun f -> valid_func environment f) flist in
			let _ = print_endline "\nSemantic analysis completed successfully.\nCompiling...\n" in
				true

