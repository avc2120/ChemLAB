%{ open Ast %}



%token SEMI LPAREN RPAREN LBRACKET RBRACKET LCURLY RCURLY COMMA STRINGDECL COLON ACCESS CONCAT NOT OBJECT ARROW
%token PLUS MINUS TIMES DIVIDE MOD PRINT ASSIGN
%token EQ NEQ LT LEQ GT GEQ EQUAL
%token RETURN IF ELSE WHILE INT DOUBLE STRING BOOLEAN ELEMENT MOLECULE EQUATION FUNCTION
%token CALL ACCESS
%token BALANCE MASS CHARGE ELECTRONS
%token AND OR
%token <string> DATATYPE ATTRIBUTE
%token <bool> BOOLEAN_LIT
%token <string> ELEMENT_LIT
%token <string> MOLECULE_LIT
%token <string> STRING_LIT
%token <string> ID
%token <int> INT_LIT
%token <float> DOUBLE_LIT
%token EOF

%nonassoc NOELSE
%nonassoc ELSE
%right ASSIGN
%left ACCESS
%left OR
%left AND
%left EQ NEQ
%left LT GT LEQ GEQ
%left PLUS MINUS
%left TIMES DIVIDE

%start program
%type <Ast.program> program

%%
program:
	{ [] }
	| program fdecl 																	{ ($2 :: $1) }

id: 
	ID 																					{ $1 }
	| STRING_LIT 																		{ $1 }
	| ELEMENT_LIT 																		{ $1 }
	| MOLECULE_LIT 																		{ $1 }

var: 
	id {Var($1)}

vdecl:
DATATYPE ID SEMI
{{ vname = $2;
	vtype = $1;
}}

vdecl_list:
	{[]}
	| vdecl_list vdecl {($2::$1)}

stmt:
	  expr SEMI																			{ Expr($1) }
	| RETURN expr SEMI 							{ Return($2)}
	| IF LPAREN expr RPAREN LCURLY stmts_list RCURLY %prec NOELSE 						{ If($3, $6, []) }
	| IF LPAREN expr RPAREN LCURLY stmts_list RCURLY ELSE LCURLY stmts_list RCURLY   	{ If($3, $6, $10) }
	| WHILE LPAREN expr RPAREN LCURLY stmts_list RCURLY          { While($3, $6) }
	| PRINT expr SEMI { Print($2)}

stmts_list:
	stmt_list {List.rev $1}

stmt_list:
	/* nothing */ { [] }
	| stmt_list stmt { ($2 :: $1) }



expr:
	INT_LIT 														{ Int($1) }
	| id 															{ String($1) }
	| PRINT expr SEMI { Print($2)}
	| EQUATION id LCURLY element_list ARROW element_list RCURLY 	{ Equation($2, $4, $6) }
	| id CONCAT id 													{ Concat($1, $3) }
	| expr PLUS expr 												{ Binop($1, Add, $3) }
	| expr MINUS expr 												{ Binop($1, Sub, $3) }
	| expr TIMES expr 												{ Binop($1, Mul, $3) }
	| expr DIVIDE expr 												{ Binop($1, Div, $3) }
	| expr LT expr 													{ Binop($1, Lt, $3) }
	| expr GT expr 													{ Binop($1, Gt, $3) }
	| expr LEQ expr 												{ Binop($1, Leq, $3) }
	| expr AND expr                									{ Brela($1, And, $3) }
	| expr OR expr                									{ Brela($1, Or, $3) }
	| expr ASSIGN expr 												{ Asn($1, $3) }
	| CALL id LPAREN actuals_opt RPAREN 							{ Call($2, $4) }
	| expr ACCESS ATTRIBUTE 										{ Access($1, $3)}



edecl:
	ELEMENT id LPAREN INT_LIT COMMA INT_LIT COMMA INT_LIT RPAREN SEMI
	{{
		name = $2;
		mass = $4;
		electrons = $6;
		charge = $8

	}}

edecl_list:   
       			   	     			{ [] }  
	 | edecl_list edecl  			{ List.rev ($2 :: $1)}   


mdecl:
	MOLECULE id LCURLY element_list RCURLY SEMI
	{{
		mname = $2;
		elements = $4;
	}}

mdecl_list:
		{ [] }
	| mdecl_list mdecl 				{ ($2 :: $1) }

element_list:
	var								{ [$1] }
	| element_list COMMA var 		{ ($3 :: $1)}

 rule:
  BALANCE LPAREN id RPAREN SEMI {Balance($3)}


 rule_list:
 	{[]}
 	| rule_list rule 				{ ($2 :: $1)}

formals_opt:
	/* nothing */					{ [] }
	| formal_list					{ List.rev $1 }

formal_list:
	param_decl 						{ [$1] }
	| formal_list COMMA param_decl 	{ $3 :: $1 }

actuals_opt:
	  /* nothing */ 				{ [] }
	| actuals_list  				{ List.rev $1 }

actuals_list:
	  expr                    		{ [$1] }
	| actuals_list COMMA expr 		{ $3 :: $1 }

param_decl:
	DATATYPE id
		{ {	paramname = $2;
			paramtype = $1 } }

fdecl:
	FUNCTION id LPAREN formals_opt RPAREN LCURLY vdecl_list edecl_list mdecl_list rule_list stmt_list RCURLY
	{ { 
		fname = $2;
		formals = $4; 
		locals = List.rev $7;
		elements =  List.rev $8;
		molecules = List.rev $9;
		rules =  List.rev $10;
		body = List.rev $11
	} }