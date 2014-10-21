open Ast
(*
module NameMap = Map.Make(String)

(* Symbol table for variables: map from variable names to values *)
type vsymtab = int NameMap.t

(* Execution environment: local variables * global variables *)
type env = vsymtab * vsymtab

(* Used to handle the "return" statement: (value, global variables) *)
exception ReturnException of int * vsymtab

(* Main entry point: run a program *)
let run ((vars, funcs) : program) : unit =
    
    (* Build a symbol table for function declarations *)
	let func_decls : (func_decl NameMap.t) = List.fold_left
		(fun funcs fdecl -> NameMap.add fdecl.fname fdecl funcs)
		NameMap.empty funcs
	in

	(* Invoke a function and return an updated global symbol table *)
	let rec call (fdecl : func_decl) (actuals : int list)
		(globals : vsymtab) : vsymtab =

(* Evaluate an expression; return value and updated environment *)
let rec eval (env : env) (exp : expr) : int * env = match exp with
	  Literal(i) -> i, env (* Simplest case: 1 is just 1 *)
	| Noexpr -> 1, env (* must be non-zero for the for loop predicate *)

*)

module StringMap = Map.Make(String)
let var = StringMap.empty
let rec eval = function
	  Lit(x) -> x
	| Seq(fir,sec) -> ignore(eval fir) ; eval sec
	| Asn(v, e) -> StringMap.add v (eval e) var ; eval e
	| Var(v) -> StringMap.find v var
	| Binop(e1, op, e2) ->
		let v1 = eval e1 and v2 = eval e2 in
		( match op with
			  Add -> v1 + v2
			| Sub -> v1 - v2
			| Mul -> v1 * v2
			| Div -> v1 / v2 )
	| Func(exp) -> print_endline (string_of_int (eval exp)) ; (eval exp)

let _ =
	let lexbuf = Lexing.from_channel stdin in
	let expr = Parser.expr Scanner.token lexbuf in
		eval expr