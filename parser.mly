%{ open Ast %}

%token SEMI COLON LPAREN RPAREN LBRACKET RBRACKET LCURLY RCURLY COMMA ACCESS CONCAT STRINGDECL
%token PLUS MINUS TIMES DIVIDE MOD ASSIGN PRINT
%token EQ NEQ LT LEQ GT GEQ NOT 
%token RETURN IF ELSE WHILE INT DOUBLE STRING BOOLEAN
%token ELEMENT MOLECULE EQUATION FUNCTION
%token DOT
%token AND OR
%token <bool> BOOLEAN_LIT
%token <string> STRING_LIT
%token <string> ID
%token <int> INT_LIT
%token <float> DOUBLE_LIT
%token EOF

%nonassoc NOELSE
%nonassoc ELSE
%left SEMI
%right FUNC
%right ASSIGN
%left PLUS MINUS
%left TIMES DIVIDE

%start program
%type <Ast.program> program

%%
program:
	  /* Nothing */				{ [] }
	| program stmt_list			{ $2 :: $1 }

stmt_list:
	  /* Nothing */				{ [] }
	| stmt_list stmt 			{ $2 :: $1 }

stmt:
	  expr SEMI									{ Expr($1) }
	| LCURLY stmt_list RCURLY					{ Block(List.rev $2) }
	| IF LPAREN expr RPAREN stmt ELSE stmt		{ If($3, $5, $7) }
	| PRINT expr SEMI							{ Print($2) }

expr:
	  LPAREN expr RPAREN		{ $2 }
	| DOUBLE_LIT				{ Double($1) }
	| INT_LIT					{ Int($1) }
	| STRING_LIT				{ String($1) }
	| ID						{ Var($1) }
	| datatype ID ASSIGN expr	{ Asn($2, $4) }
	| expr PLUS expr 			{ Binop($1, Add, $3) }
	| expr MINUS expr 			{ Binop($1, Sub, $3) }
	| expr TIMES expr 			{ Binop($1, Mul, $3) }
	| expr DIVIDE expr 			{ Binop($1, Div, $3) }
	| expr MOD expr 			{ Binop($1, Mod, $3) }
	| expr EQ expr 				{ Binop($1, Equal, $3) }
	| expr NEQ expr				{ Binop($1, Neq, $3) }
	| expr LT expr 				{ Binop($1, Less, $3) }
	| expr GT expr 				{ Binop($1, Greater, $3) }
	| expr GEQ expr 			{ Binop($1, Geq, $3) }
	| expr LEQ expr 			{ Binop($1, Leq, $3) }
	| expr AND expr 			{ Binop($1, And, $3) }
	| expr OR expr 				{ Binop($1, Or, $3) }

datatype:
	  INT 						{ Int }
	| STRING 					{ String }
