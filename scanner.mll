{ open Parser }
digit = ['0'-'9']
string_lit = ['0'-'9'] | ['a'-'z' 'A' - 'Z']
punctuation = [',' '.' '?' '/' '<' '>' ':' '''  ';' '{' '}' '[' ']' '|' ' ' '~' '`' '!' '@' '#' '$' '%' '^' '&' '*' '(' ')' '-' '+' '=' ]
rule token = parse 
		[' ' '\t' '\r' '\n']	{ token lexbuf }
	| '+'							{ PLUS }
	| '-'							{ MINUS }
	| '*'							{ TIMES }
	| '/'							{ DIVIDE }
	| '^'      						{ POW }
	| '%'							{ MOD }
	| '='							{ ASSIGNMENT }
<<<<<<< HEAD
	| ','							{ SEQUENCE }
	| eof							{ EOF }
=======
	| ';'							{ SEQUENCE }
	| ['A'-'Z']['a'-'z']* as lit 	{ VARIABLE(lit) }
	| "print"						{ FUNC }
	| ['0'-'9']+ as lit				{ LITERAL(int_of_string lit) }
	| eof							{ EOF }
	| "/*"							{comment lexbuf}
	| '^'      						{ POW }
	| '%'							{ MOD }
	| '('							{ L_PAREN }
	| ')'							{ R_PAREN }
	| '{'							{ L_CURLY }
	| '}'							{ R_CURLY }
	| "||"							{ OR }
	| "&&"							{ AND }
	| '['							{ L_BRACK }
	| ']'							{ R_BRACK }
	|  "=="							{ EQ }
	| "!="     						{ NOT_EQ }
	| '<'      						{ LESS_THAN }
	| "<="     						{ LESS_THAN_EQUAL }
	| ">"      						{ GREATER_THAN }
	| ">="     						{ GREATER_THAN_EQUAL }
	| "true" 						{ TRUE }
	| "false"						{ FALSE }
	| "if"     						{ IF }
	| "else"   						{ ELSE }
	| "while"  						{ WHILE }
	| "func"						{ FUNCTION }
	| "print"						{ PRINT }
	| ['0'-'9']+ as lit				{ LITERAL(int_of_string lit) }
	| (digit* '.' digit+)|(digit+ ',' digit*) {float_of_string lit}
	| '$'['0'-'9'] as lit 			{ VARIABLE(int_of_char lit.[1] - 48) }
	| "\*"							{comment lexbuf}

and comment  = parse
'\n' { token lexbuf }
| _ {comment lexbuf }
