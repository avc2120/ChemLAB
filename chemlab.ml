open Ast

let lexbuf = Lexing.from_channel stdin in
	Parser.expr Scanner.token lexbuf