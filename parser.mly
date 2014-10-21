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

%start program
%type <Ast.program> program

%% 