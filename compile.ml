open Ast
open Helper

let balance  = function
	Balance(left, right) -> "	" ^ "Balance(" ^ left ^ "=" ^ right ^ ");"