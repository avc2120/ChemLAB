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


let count_function_variables func = function
	a -> let f count b = 
	if b = a 
		then count+1
		else count 
in 
	let count = List.fold_left f 0 func.locals in
		if count > 0
			then raise (Failure("Duplicate variable in function " ^ func.fname))
			else count

(*Determines if a formal paramter with the given name ‘fpname’ exits in the given function*)

let exists_formal_param func fpname =
try
 List.exists (function_fparam_name fpname) func.formals
with Not_found -> raise (Failure ("Formal Parameter " ^ fpname ^ " should exist but was not found in function " ^ func.fname))


(*Determines if a variable declaration with the given name ‘vname’ exists in the given functioin*)

let exists_variable_decl func vname =
try
 List.exists (function_var_name vname) func.locals
with Not_found -> raise (Failure ("Variable " ^ vname ^ " should exist but was not found in function " ^ func.fname))




let dup_param_name func fpname = 
	let name = func.formals in
		try 
			List.find (function name -> name.paramname = fpname.paramname ) name 
	with Not_found -> raise (Failure ("Duplicate param names"))



let get_fparam_type func fpname = 
	let name = func.formals in
		try
			let fparam = List.find(fpname) name in
				fparam.paramtype
		with Not_found -> raise (Failure ("Formal param should exist but not found"))


(*given variable name, get type*)
let get_var_type func vname = 
	let name = func.locals in 
		try
			let var = List.find(vname) name in 
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

let rec is_num func = function
	  Int(_) -> true
	| Double(_) -> true
	| Binop(e1,_,e2) -> (is_num func e1) && (is_num func e2)
	| _ -> false

let rec is_boolean func = function
	Boolean(_) -> true
	| _ -> false 

(*check if variable declation is valid*)

(*

let valid_vdecl func = 
	let _ = List.map (function func.locals) -> 
	let e = "Invalid variable declaration for '" ^ nm ^ "' in compute function " ^ func.fname ^ "\n" in
					let be = e ^ "The only allowed values for initializing boolean variables are 'true' and 'false.' \\n" in
						match vtype with
						  "Int"  -> if is_string value then true else raise (Failure e)
						| "Double"  -> if is_float value then true else raise (Failure e)
						| "String"     -> if is_int value then true else raise (Failure e)
						| "Boolean" -> if is_string_bool value then true else raise (Failure be)) func.locals 
						in
							true

*)

let rec get_expr_type e func =
	match e with
		| String(s) -> "String"
		| Int(s) -> "int"
		| Double(f) -> "double"
		| Boolean(b) -> "boolean"
		| Binop(e1,op,e2) -> let t1 = get_expr_type e1 func and t2 = get_expr_type e2 func in
			begin 
				match t1, t2 with 
					"double", "double" -> "double"
				|	"int", "int" -> "int"
				| 	_,_ -> raise (Failure "Invalid types for binary expresion")
			end
		| Brela(e1, re, e2) -> let t1 = get_expr_type e1 func and t2 = get_expr_type e2 func in 
			begin
				match t1, t2 with 
					"boolean", "boolean" -> "boolean"
				| _,_ -> raise (Failure "Invalid type for AND, OR expression") 
			end
		| Asn(expr, expr2) -> get_expr_type expr2 func 
		| Equation (s, vlist, vlist2) -> "equation"
		| Concat(s, s2) -> 
			begin
				match s, s2 with
					"String", "String" -> "String"
			| 		_,_ -> raise (Failure "concatentation needs to be with two strings")
			end





let rec valid_expr (func : Ast.func_decl) expr env =
	match expr with
	  Int(_) -> true
	| Double(_) ->  true
	| Boolean(_) -> true
	| String(_) -> true
	| Binop(e1,_,e2) -> (is_num func e1) && (is_num func e2)
	| Brela (e1,_,e2) -> (is_boolean func e1) && (is_boolean func e2) 
	| Asn(expr, expr2) ->
				let t1 = get_expr_type expr func and t2 = get_expr_type expr2 func in 
					match t1,t2 with
						"String","String" -> true
					| "int","int" -> true
					| "double","double" -> true
					| "element", "element" -> true (*allow int to double conversion*)
					| "molecule","molecule" -> true
					| "equation", "equation" -> true
					| _,_ -> raise(Failure ("DataTypes do not match up in an assignment expression to variable "))			

(*Print(e1) -> 
		let t1 = get_expr_type expr func in 
			match t1 with
				"String" -> true
			|  	"int" -> true
			|  	"double" -> true
			|  	"boolean" -> true
			|   "element" -> true
			| 	"molecule" -> true
			|   "equation" -> true
			| 	_ -> raise(Failure("Can't print type"))*)



let has_return_stmt list =
	if List.length list = 0
		then false
		else match (List.hd (List.rev list)) with
		  Return(_) -> true
		| _ -> false


let if_else_has_return_stmt stmt_list =
	let if_stmts = List.filter (function If(_,_,_) -> true | _ -> false) stmt_list in
    let rets = List.map (
			function
			  If(_,s1,s2) ->
					begin
						match s1,s2 with
							Block(lst1),Block(lst2) -> (has_return_stmt lst1) && (has_return_stmt lst2)
						| _ -> raise(Failure("Error")) 
					end
			| _  -> false
		) if_stmts in
			List.fold_left (fun b v -> b || v) false rets

let has_return_stmt func =
	let stmt_list = func.body in
		if List.length stmt_list = 0
			then false
			else match List.hd (List.rev stmt_list), func.fname with
			  Return(e),"main" -> raise(Failure("Return statement not permitted in main method"))
			| _, "main" -> false 
			| Return(e), _ -> true
			| _,_ -> false



let valid_func env f = 
	let duplicate_functions = function_exist f env in 
		let _ = env.functions <- f :: env.functions (* Adding function to environment *) in
			(not duplicate_functions)

let check_program flist =
	let (environment : env) = { functions = [] (* ; variables = [] *) } in
		let _validate = List.map ( fun f -> valid_func environment f) flist in
			let _ = print_endline "\nSemantic analysis completed successfully.\nCompiling...\n" in
				true