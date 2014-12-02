open Ast
open Helper

modeule StringMap = MapMake(String);;

let balance  = function
	Balance(left, right) -> "	" ^ "Balance(" ^ left ^ "," ^ right ^ ");"

let mass = function
	Mass(molecule) -> sum molecule.element_list;;

let rec sum element_list = match list with
	| [] -> 0
	| hd :: tl -> hd.mass + sum tl;; 

