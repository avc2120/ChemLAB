{ open Parser }

rule token = parse 
	  [' ' '\t' '\r' '\n']			{ token lexbuf }
	| '+'							{ PLUS }
	| '-'							{ MINUS }
	| '*'							{ TIMES }
	| '/'							{ DIVIDE }
	| '='							{ ASSIGNMENT }
	| ';'							{ SEQUENCE }
	| ['A'-'Z']+ as lit 			{ VARIABLE(int_of_string lit) }
	| "print"						{ FUNC }
	| ['0'-'9']+ as lit				{ LITERAL(int_of_string lit) }
	| eof							{ EOF }

(*	| '^'      						{ POW }
	| '%'							{ MOD }
	| '('							{ L_PAREN }
	| ')'							{ R_PAREN }
	| '{'							{ L_CURLY }
	| '}'							{ R_CURLY }
	| '['							{ L_BRACK }
	| ']'							{ R_BRACK }
	| "||"							{ OR }
	| "&&"							{ AND }
	| "=="							{ EQ }
	| "!="     						{ NOT_EQ }
	| '<'      						{ LESS_THAN }
	| "<="     						{ LESS_THAN_EQUAL }
	| '>'      						{ GREATER_THAN }
	| ">="     						{ GREATER_THAN_EQUAL }
	| "true" 						{ TRUE }
	| "false"						{ FALSE }
	| "if"     						{ IF }
	| "else"   						{ ELSE }
	| "while"  						{ WHILE }
	| "func"						{ FUNCTION }
	
*)