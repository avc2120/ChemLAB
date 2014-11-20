{ open Parser }

rule token = parse 
	  [' ' '\t' '\r' '\n']					{ token lexbuf }
	| "/*"									{ comment lexbuf }
	| '(' 				   					{ LPAREN }
	| ')'				   					{ RPAREN }
	| '['				   					{ LBRACKET }
	| ']'				   					{ RBRACKET }
	| '{'				   					{ LCURLY }
	| '}'				   					{ RCURLY }
	| '"'				   					{ STRINGDECL }
	| ';'                  					{ SEMI }
	| ':'                  					{ COLON }
	| ','                  					{ COMMA }
	| '.'                  					{ ACCESS }
	| '+'                  					{ PLUS }
	| '-'                  					{ MINUS }
	| '*'                  					{ TIMES }
	| '/'                  					{ DIVIDE }
	| '%'                  					{ MOD }
	| '='                  					{ ASSIGN }
	| '^'                  					{ CONCAT }
	| "=="                 					{ EQ }
	| "!="                 					{ NEQ }
	| '<'                  					{ LT }
	| "<="                 					{ LEQ }
	| '>'                  					{ GT }
	| ">="                 					{ GEQ }
	| "&&"                 					{ AND }
	| "||"                 					{ OR }
	| '!'                  					{ NOT }
	| "if"				   					{ IF }
	| "else"			   					{ ELSE }
	| "while"			   					{ WHILE }
	| "int"				   					{ INT }
	| "double"			   					{ DOUBLE }
	| "string"			   					{ STRING }
	| "boolean"			   					{ BOOLEAN }
	| "element"			   					{ ELEMENT }
	| "molecule"		   					{ MOLECULE}
	| "equation"		   					{ EQUATION }
	| "function"		   					{ FUNCTION }
	| "object"			   					{ OBJECT }
	| "return"			   					{ RETURN }
	| "true"			   					{ BOOLEAN_LIT(true) }
	| "false"			   					{ BOOLEAN_LIT(false) }
	| "print"			   					{ PRINT }
	| ['0'-'9']+ as lxm    					{ INT_LIT(int_of_string lxm) }
	| ('0' | ['1'-'9']+['0'-'9']*)(['.']['0'-'9']+)? as lxm { DOUBLE_LIT(float_of_string lxm) }
	| '"' [^'"']* '"'  as lxm 				{ STRING_LIT(lxm) }
	| ['A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_']* as lxm { ID(lxm) }
	| eof                  					{ EOF }
	| _ as char 							{ raise (Failure("illegal character " ^
												Char.escaped char)) }

and comment = parse
	  "*/"					{ token lexbuf }
	| _						{ comment lexbuf }
	 

