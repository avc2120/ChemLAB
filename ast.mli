type operator = Add | Sub | Mul | Div | Equal | Neq | Lt | Leq | Gt | Geq
type re = And | Or
type bool = True | False
type types = Int | Boolean | String | Element | Molecule | Equation | Double
type expr =
    Binop of expr * operator * expr
  | Brela of expr * re * expr
  | Int of int
  | String of string
  | Boolean of bool
  | Double of float
  | Balance of string
  | Asn of expr * expr
  | Element of string * int * int * int
  | Molecule of string * expr list
  | Equation of string * string list * string list
  | Concat of string * string
  | Seq of expr * expr
  | List of expr list
  | Call of string * expr list
  | Null
  | Noexpr
type stmt =
    Block of stmt list
  | Expr of expr
  | Return of expr
  | If of expr * stmt * stmt
  | For of expr * expr * expr * stmt
  | While of expr * stmt
  | Loop of string * string * stmt
  | Print of expr
type variable_decl = { vname : string; vtype : string; }
type element_decl = {
  name : string;
  mass : int;
  electrons : int;
  charge : int;
}
type molecule_decl = { mname : string; elements : string list; }
type par_decl = { paramname : string; paramtype : string; }
type func_decl = {
  fname : string;
  formals : par_decl list;
  locals : variable_decl list;
  elements : element_decl list;
  molecules : molecule_decl list;
  body : stmt list;
}
type program = func_decl list
val string_of_op : operator -> string
val string_of_re : re -> string
val string_of_bool : bool -> string
val string_of_expr : expr -> string
