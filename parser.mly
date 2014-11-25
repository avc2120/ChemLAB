%{ open Ast %}



%token SEMI LPAREN RPAREN LBRACKET RBRACKET LCURLY RCURLY COMMA STRINGDECL COLON ACCESS CONCAT NOT OBJECT ARROW
%token PLUS MINUS TIMES DIVIDE MOD PRINT
%token EQ NEQ LT LEQ GT GEQ EQUAL
%token RETURN IF ELSE WHILE INT DOUBLE STRING BOOLEAN ELEMENT MOLECULE EQUATION FUNCTION
%token DOT
%token AND OR
%token <bool> BOOLEAN_LIT
%token <string> ELEMENT_LIT
%token <string> MOLECULE_LIT
%token <string> STRING_LIT
%token <string> ID
%token <int> INT_LIT
%token <float> DOUBLE_LIT
%token ASSIGN
%token EOF

%nonassoc UMINUS
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

id: 
	ID {$1}
	| STRING_LIT {$1}

datatype:
	  BOOLEAN {Boolean}
	| INT	{Int}
	| DOUBLE {Double}
	| STRING {String}
	| ELEMENT {Element}
	| MOLECULE {Molecule}
	| EQUATION {Equation}

stmt:
	  expr SEMI			{Expr($1)}
	| RETURN expr SEMI { Return($2) }
	| PRINT expr SEMI { Print($2)}
	| IF LPAREN expr RPAREN LCURLY stmt RCURLY ELSE LCURLY stmt RCURLY   { If($3, $6, $10) }

expr:
		INT_LIT { Int($1) }
	| STRING_LIT {String($1)}
	| ID { Var($1) }
	| ELEMENT ELEMENT_LIT LPAREN INT_LIT COMMA INT_LIT COMMA INT_LIT RPAREN	{ Element($2, $4, $6, $8) }
	| MOLECULE MOLECULE_LIT LCURLY element_list RCURLY {Molecule($2, $4)}
	| EQUATION MOLECULE_LIT LCURLY molecule_list ARROW molecule_list RCURLY {Equation($2, $4, $6)}
	| expr PLUS expr { Binop($1, Add, $3) }
	| expr MINUS expr { Binop($1, Sub, $3) }
	| expr TIMES expr { Binop($1, Mul, $3) }
	| expr DIVIDE expr { Binop($1, Div, $3) }
	| expr LT expr 		{ Binop($1, Lt, $3) }
	| expr GT expr 		{Binop($1, Gt, $3)}
	| datatype id ASSIGN expr {Asn($2, $4)}
	

element_list:
	ELEMENT_LIT			{[$1]}
	| element_list COMMA ELEMENT_LIT {List.rev ($3 :: $1)}

molecule_list:
	MOLECULE_LIT			{[$1]}
	| molecule_list COMMA MOLECULE_LIT {List.rev ($3 :: $1)}











