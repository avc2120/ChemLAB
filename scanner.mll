{ open Parser }

let digit = ['0'-'9']
let letter = ['A'-'Z' 'a'-'z']
let element = ['A'-'Z']['a'-'z']?		(* Symbol of element such as: H, Cl *)

rule token = parse 
	  [' ' '\t' '\r' '\n']					{ token lexbuf }
	| "/*"									{ comment lexbuf }
	| "//"									{ line_comment lexbuf }
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
	| "-->"									{ ARROW }
	| "if"				   					{ IF }
	| "else"			   					{ ELSE }
	| "while"			   					{ WHILE }
	| "for"									{ FOR }
	| "int"					   				{ INT }
	| "double"					   			{ DOUBLE }
	| "string"					 			{ STRING }
	| "boolean"					   			{ BOOLEAN }
	| "element"					   			{ ELEMENT }
	| "molecule"				   			{ MOLECULE}
	| "equation"				   			{ EQUATION }
	| "balance"								{ BALANCE }
	| "Mass"								{ MASS }
	| "mass"		as attr					{ ATTRIBUTE(attr) }
	| "charge"		as attr					{ ATTRIBUTE(attr) }
	| "electrons"	as attr					{ ATTRIBUTE(attr) }
	| "function"		   					{ FUNCTION }
	| "object"			   					{ OBJECT }
	| "main"								{ MAIN }
	| "return"			   					{ RETURN }
	| "print"			   					{ PRINT }
	| "call"								{ CALL }
	| "draw"								{ DRAW }
	| "true"			   									{ BOOLEAN_LIT(true) }
	| "false"							   					{ BOOLEAN_LIT(false) }
	| (digit)+ '.' (digit)+ as lxm 							{ DOUBLE_LIT(float_of_string lxm) }
	| digit+ as lxm    										{ INT_LIT(int_of_string lxm) }
	| ['A'-'Z'](letter | digit | '_')* as lxm				{ ID(lxm)}
	| '"' [^'"']* '"'  as lxm 								{ STRING_LIT(lxm) }
	| element as lxm							{ ELEMENT_LIT(lxm)}
	| (element ['0'-'9']*)+ as lxm				{ MOLECULE_LIT(lxm)}
	| eof                  					{ EOF }
	| _ as char 							{ raise (Failure("illegal character " ^
												Char.escaped char)) }


and comment = parse
	  "*/"					{ token lexbuf }
	| _						{ comment lexbuf }

and line_comment = parse
	  "\n"					{ token lexbuf }
	| _						{ line_comment lexbuf }
