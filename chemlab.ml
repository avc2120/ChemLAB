open Ast

let var = Array.make 10 0

let rec eval = function
	  Lit(x) -> x
	| Seq(fir,sec) -> ignore(eval fir) ; eval sec
	| Asn(v, e) -> ignore(var.(v) <- eval e) ; eval e
	| Var(v) -> var.(v)
	| Binop(e1, op, e2) ->
		let v1 = eval e1 and v2 = eval e2 in
		( match op with
			  Add -> v1 + v2
			| Sub -> v1 - v2
			| Mul -> v1 * v2
			| Div -> v1 / v2 )
	| Func(f,exp) ->
		let val = eval exp in
			( match f with
				print -> print_endline (val) )

let _ =
	let lexbuf = Lexing.from_channel stdin in
	let expr = Parser.expr Scanner.token lexbuf in
	let result = eval expr in
	print_endline (string_of_int result)