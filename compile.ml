open Ast
open Printf

(* module StringMap = MapMake(String);;

let balance  = function
	Balance(left, right) -> "	" ^ "Balance(" ^ left ^ "," ^ right ^ ");"

let mass = function
	Mass(molecule) -> mass_sum molecule.element_list;;

let rec mass_sum element_list = match list with
	| [] -> 0
	| hd :: tl -> hd.mass + mass_sum tl;; 

let charge molecule = function
	Charge(molecule) -> charge_sum  molecule.element_list;;

let rec charge_sum molecule = match list with
	| [] -> 0
	| hd :: tl -> hd.charge + charge_sum tl;; *)
(* let program program =
	let out_chan = open_out ("test.txt") in
		Printf.sprintf out_chan "Hello %d" 123; close_out out_chan; 
 *)

let program ast =
	let out_chan = open_out ("test.txt") in
		ignore(Printf.fprintf out_chan "%s" "HELLO"); 
				close_out out_chan; 
				Sys.command (Printf.sprintf "echo %s.java" "Parser")
