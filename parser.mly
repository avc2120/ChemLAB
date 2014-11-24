%{ open Ast %}

%token SEMI LPAREN RPAREN LBRACKET RBRACKET LCURLY RCURLY COMMA
%token PLUS MINUS TIMES DIVIDE MOD ASSIGN PRINTT
%token EQ NEQ LT LEQ GT GEQ
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
	| program fdecl { ($2 :: $1)}

fdecl: 
	FUNCTION datatype id LPAREN formals_list RPAREN LCURLY stmt RCURLY
	{func_decl({fname= $3; formals_list = $5; body = List.rev $8; })}


formals:
	datatype id 	{[]}

formals_list:
	  formals 	{[]}
	| formals_list COMMA formals { List.rev $3 :: $1 }


id: 
	ID {$1}

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

datatype:
	  BOOLEAN {Boolean}
	| INT	{Int}
	| DOUBLE {Double}
	| STRING {String}
	| ELEMENT {Element}
	| MOLECULE {Molecule}
	| EQUATION {Equation}

element:
	ELEMENT STRING_LIT ASSIGN LCURLY INT_LIT COMMA INT_LIT COMMA INT_LIT RCURLY		{Element($1)}

element_list:
	  element 		{[]}
	| element_list COMMA element 	{ ($3 :: $1) }

molecule:
	| LBRACKET element_list RBRACKET {Molecule($2)}

molecule_list:
	molecule 	{[]}
	|  molecule_list COMMA molecule  {Molecule($3)}

equation:
	LCURLY molecule_list SEMI molecule_list RCURLY {Equation($2, $4)}

stmt:
	  expr SEMI			{Expr($1)}
	| PRINT expr SEMI   {Print($2)}
	| RETURN expr SEMI	{Return($2)}
	| IF LPAREN expr RPAREN LCURLY stmt RCURLY ELSE LCURLY stmt RCURLY {If($3, $6, $10)}
	| WHILE LPAREN expr RPAREN LCURLY stmt RCURLY {While($3, $6)}




