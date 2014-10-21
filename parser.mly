%{ open Ast %}

%token PLUS MINUS TIMES DIVIDE EOF
%token <int> LITERAL
%token <string> VARIABLE
%token ASSIGNMENT SEQUENCE
<<<<<<< HEAD
=======
%token FUNC
>>>>>>> 144cfc7f6719e62ce8fd0f521b56627c6fc7582a

%left SEQUENCE
%right FUNC
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

<<<<<<< HEAD
datatype:
	BOOLEAN {Boolean}
	| INT 	{Int}
	| FLOAT {Float}
	| STRING {String}
	| ELEMENT {Element}
	| MOLECULE {Molecule}
	| EQUATION {Equation}
=======
	| FUNC expr { Func($2) }
>>>>>>> 144cfc7f6719e62ce8fd0f521b56627c6fc7582a
