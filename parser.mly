%{ open Ast %}

%token SEMI LPAREN RPAREN LBRACKET RBRACKET LCURLY RCURLY COMMA
%token PLUS MINUS TIMES DIVIDE MOD ASSIGN 
%token EQ NEQ LT LEQ GT GEQ
%token RETURN IF ELSE WHILE INT DOUBLE STRING BOOLEAN ELEMENT MOLECULE EQUATION FUNCTION OBJECT
%token DOT
%token AND OR
%token <bool> BOOLEAN_LIT
%token <string> STRING_LIT
%token <string> ID
%token <int> INT_LIT
%token <float> DOUBLE_LIT

%left SEMI
%right FUNC
%right ASSIGN
%left PLUS MINUS
%left TIMES DIVIDE

%start expr
%type <Ast.expr> expr

%%

expr:
	  expr PLUS expr { Binop($1, Add, $3) }
	| expr MINUS expr { Binop($1, Sub, $3) }
	| expr TIMES expr { Binop($1, Mul, $3) }
	| expr DIVIDE expr { Binop($1, Div, $3) }
	| LITERAL { Lit($1) }
	| ID { Var($1) }
	| ID ASSIGN expr { Asn($1, $3) }
	| expr SEMI expr { Seq($1, $3) }

	| FUNC expr { Func($2) }