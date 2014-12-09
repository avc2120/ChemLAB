open Ast
open Printf


let _ =
	let lexbuf = Lexing.from_channel stdin in
	let ast = Parser.program Scanner.token lexbuf in
	let sast = Semantic.check_program ast in
	Compile.program sast 
