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
	| "--"									{ ARROW }
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
	| "int"	as tpe			   				{ DATATYPE(tpe) }
	| "double"	as tpe			   			{ DATATYPE(tpe) }
	| "string"	as tpe			 			{ DATATYPE(tpe) }
	| "boolean"	as tpe			   			{ DATATYPE(tpe) }
	| "element"	as tpe			   			{ DATATYPE(tpe) }
	| "molecule"	as tpe		   			{ DATATYPE(tpe)}
	| "equation"	as tpe		   			{ DATATYPE(tpe) }
	| "balance"								{ BALANCE }
	| "function"		   					{ FUNCTION }
	| "object"			   					{ OBJECT }
	| "return"			   					{ RETURN }
	| "true"			   					{ BOOLEAN_LIT(true) }
	| "false"			   					{ BOOLEAN_LIT(false) }
	| "print"			   					{ PRINT }
	| ['0'-'9']+ as lxm    					{ INT_LIT(int_of_string lxm) }
	| ('0' | ['1'-'9']+['0'-'9']*)(['.']['0'-'9']+)? as lxm { DOUBLE_LIT(float_of_string lxm) }
	| ['A'-'Z' 'a'-'z' '0'-'9']+ as lxm		{ ID(lxm)}
	| '"' [^'"']* '"'  as lxm 				{ STRING_LIT(lxm) }
	| ['A'-'Z' ]['a'-'z']* as lxm			{ ELEMENT_LIT(lxm)}
	| (['A'-'Z']['a'-'z']* ['0'-'9']*)+ as lxm		{ MOLECULE_LIT(lxm)}
	| eof                  					{ EOF }
	| _ as char 							{ raise (Failure("illegal character " ^
												Char.escaped char)) }

and comment = parse
	  "*/"					{ token lexbuf }
	| _						{ comment lexbuf }
	 

