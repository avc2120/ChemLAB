exception NoInputFile
exception InvalidProgram

let usage = Printf.sprintf "Usage: chemlab FILE_NAME"
(* Get the name of the program from the file name. *)						
let get_prog_name source_file_path =
	let split_path = (Str.split (Str.regexp_string "/") source_file_path) in
	let file_name = List.nth split_path ((List.length split_path) - 1) in
	let split_name = (Str.split (Str.regexp_string ".") file_name) in
		List.nth split_name ((List.length split_name) - 2)

(* Entry Point: starts here *)
let _ =
	try 
		let prog_name = 
			if Array.length Sys.argv > 1 then
				get_prog_name Sys.argv.(1)
			else raise NoInputFile in

		let input_channel = open_in Sys.argv.(1) in

		let lexbuf = Lexing.from_channel input_channel in
			let prog = Parser.program Scanner.token lexbuf in
				(* if Semantic.check_program prog *)
					(* then *) Compile.program prog prog_name
					(* else raise InvalidProgram *)
	with (* Not sure why this wants an int instead of unit *)
		| NoInputFile -> ignore(Printf.printf "Please provide a name for a ChemLAB file\n");1
		| InvalidProgram -> ignore(Printf.printf "Invalid program\n");0