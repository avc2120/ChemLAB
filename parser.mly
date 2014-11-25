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
	{ [] }
	| program stmt { ($2 :: $1)}

stmt:
	  expr SEMI			{ Expr($1) }
	| PRINT expr SEMI   { Print($2) }

expr:
	  INT_LIT { Int($1) }
	| STRING_LIT { String($1) }
	| ID ASSIGN expr { Asn($1, $3) }

datatype:
	  INT 		{ Int }
	| STRING 	{ String }
