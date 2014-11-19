{ open Parser }

rule token = parse 
<<<<<<< Updated upstream
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
=======
	  [' ' '\t' '\r' '\n']			{ token lexbuf }
	| '+'							{ PLUS }
	| '-'							{ MINUS }
	| '*'							{ TIMES }
	| '/'							{ DIVIDE }
	| '='							{ ASSIGNMENT }
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

and comment = parse
	  "*/" {token lexbuf}
	| _ {comment lexbuf}


	
>>>>>>> Stashed changes
