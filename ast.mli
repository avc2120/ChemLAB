type operator = Add | Sub | Mul | Div | Equal | Neq | Lt | Leq | Gt | Geq
type re = And | Or
type bool = True | False
type data_type = IntType | BooleanType | StringType | DoubleType
type variable = Var of string
type expr =
    Binop of expr * operator * expr
  | Brela of expr * re * expr
  | Int of int
  | String of string
  | Boolean of bool
  | Double of float
  | Asn of expr * expr
  | Equation of string * variable list * variable list
  | Concat of string * string
  | Seq of expr * expr
  | List of expr list
  | Call of string * expr list
  | Null
  | Noexpr
(* 
  | Element of string * int * int * int
  | Molecule of string * variable list *)
type rule = Balance of string | Mass of string
type stmt =
    Block of stmt list
  | Expr of expr
  | Return of expr
  | If of expr * stmt * stmt
  | For of expr * expr * expr * stmt
  | While of expr * stmt
  | Print of expr
type variable_decl = { vname : string; vtype : data_type; }
type element_decl = {
  name : string;
  mass : int;
  electrons : int;
  charge : int;
}
type molecule_decl = { mname : string; elements : variable list; }
type par_decl = { paramname : string; paramtype : data_type; }
type func_decl = {
  fname : string;
  formals : par_decl list;
  locals : variable_decl list;
  elements : element_decl list;
  molecules : molecule_decl list;
  rules : rule list;
  body : stmt list;
}
type program = func_decl list

