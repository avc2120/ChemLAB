%{ open Ast %}

%token SEMI LPAREN RPAREN LBRACKET RBRACKET LCURLY RCURLY COMMA
%token PLUS MINUS TIMES DIVIDE MOD ASSIGN PRINT
%token EQ NEQ LT LEQ GT GEQ EQUAL
%token RETURN IF ELSE WHILE INT DOUBLE STRING BOOLEAN ELEMENT MOLECULE EQUATION FUNCTION
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
	{ [] }
	| program stmt { ($2 :: $1)}

stmt:
	  expr SEMI			{$1}
	| IF LPAREN expr RPAREN LCURLY stmt RCURLY ELSE LCURLY stmt RCURLY {If($3, $6, $10)}
	| WHILE LPAREN expr RPAREN LCURLY stmt RCURLY {While($3, $6)}

expr:
	  expr PLUS expr { Binop($1, Add, $3) }
	| expr MINUS expr { Binop($1, Sub, $3) }
	| expr TIMES expr { Binop($1, Mul, $3) }
	| expr DIVIDE expr { Binop($1, Div, $3) }
	| INT_LIT { Lit($1) }
	| STRING_LIT {String_Lit($1)}
	| DOUBLE_LIT {Double_Lit($1)}
	| ID { Var($1) }
	| ID ASSIGN expr { Asn($1, $3) }

id: 
	ID {$1}

datatype:
	  BOOLEAN {Boolean}
	| INT	{Int}
	| DOUBLE {Double}
	| STRING {String}
	| ELEMENT {Element}
	| MOLECULE {Molecule}
	| EQUATION {Equation}






