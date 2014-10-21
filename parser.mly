%{ open Ast %}

%token PLUS MINUS TIMES DIVIDE EOF
%token <int> LITERAL
%token <int> VARIABLE
%token ASSIGNMENT SEQUENCE

%left SEQUENCE
%right ASSIGNMENT
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

	| VARIABLE { Var($1) }
	| VARIABLE ASSIGNMENT expr { Asn($1, $3) }
	| expr SEQUENCE expr { Seq($1, $3) }

datatype:
	BOOLEAN {Boolean}
	| INT 	{Int}
	| FLOAT {Float}
	| STRING {String}
	| ELEMENT {Element}
	| MOLECULE {Molecule}
	| EQUATION {Equation}