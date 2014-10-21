{ open Parser }

rule token = parse 
	  [' ' '\t' '\r' '\n']					{ token lexbuf }
	| "/*"									{ comment lexbuf }

	| '+'									{ PLUS }
	| '-'									{ MINUS }
	| '*'									{ TIMES }
	| '/'									{ DIVIDE }
	| '='									{ ASSIGN }
	| ';'									{ SEMI }

	| "print"								{ FUNC }

	| ['0'-'9']+ as lit						{ LITERAL(int_of_string lit) }
	| ['A'-'Z']['A'-'Z' 'a'-'z' '0'-'9']* as lit 	{ ID(lit) }

	| eof									{ EOF }
	| _ as char 							{ raise (Failure("illegal character " ^
												Char.escaped char)) }

and comment = parse
	  "*/"					{ token lexbuf }
	| _						{ comment lexbuf }