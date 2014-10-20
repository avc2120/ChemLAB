{ open Parser }
string_lit = ['0'-'9'] | ['a'-'z' 'A' - 'Z']
punctuation = [',' '.' '?' '/' '<' '>' ':' '''  ';' '{' '}' '[' ']' '|' ' ' '~' '`' '!' '@' '#' '$' '%' '^' '&' '*' '(' ')' '-' '+' '=' ]
rule token = parse 
	  [' ' '\t' '\r' '\n']			{ token lexbuf }
	| '+'							{ PLUS }
	| '-'							{ MINUS }
	| '*'							{ TIMES }
	| '/'							{ DIVIDE }
	| '='							{ ASSIGNMENT }
	| ';'							{ SEQUENCE }
	| ['a'-'z']+ as lit 			{ VARIABLE(int_of_string lit) }
	| "print"						{ PRINT }
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
	| ['0'-'9']+ as lit				{ LITERAL(int_of_string lit) }
<<<<<<< HEAD
	| '$'['0'-'9'] as lit 			{ VARIABLE(int_of_char lit.[1] - 48) }
	| "\*"							{comment lexbuf}

and comment  = parse
'\n' { token lexbuf }
| _ {comment lexbuf }
=======
*)
>>>>>>> FETCH_HEAD
