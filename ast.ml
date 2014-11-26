type operator = Add | Sub | Mul | Div
type eq = Equal | Neq | Lt | Leq | Gt | Geq 
type re = And | Or
type bool = True | False
type types = Int | Boolean | String | Element | Molecule | Equation | Double

type expr =
    Binop of expr * operator * expr
  | Bexpr of expr * eq * expr
  | Brela of expr * re * expr
  | Int of int
  | String of string 
  | Balance of string
  | Asn of string * expr
  | Element of string * int * int * int
  | Molecule of string * string list
  | Equation of string * string list * string list
  | Concat of string * string
  | Seq of expr * expr 
  | List of expr list 
  | Equal of expr
  | Var of string
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

type variable_decl = {
  vname : string;
  vtype : types;
}

type element_decl = {
  name : string;
  mass : int;
  electrons : int;
  charge : int;
}

type molecule_decl = {
  mname : string;
  elements: string list;
}

type par_decl = {
  paramname : string; (* Name of the variable *)
  paramtype : types; (* Name of variable type *)
}

type func_decl = {
  fname : string;
  formals : par_decl list;
  locals: variable_decl list;
  elements : element_decl list;
  molecules : molecule_decl list;
  body : stmt list;
}
(* type var_decl = {
  vtype: types list;
  vname: string;
} *)

(* type program = {
  objectdecls : object_decl list;
  gdecls : var_decl list;
  fdecls : func_decl list
} *)

type program = func_decl list

let string_of_op = function
    Add -> "+"
  | Sub -> "-"
  | Mul -> "*"
  | Div -> "/"

let string_of_datatype = function
   | Double -> "double"
   | String -> "string"
   | Int -> "int"
   | Boolean -> "boolean"
   | Element -> "element"
   | Molecule -> "molecule"
   | Equation -> "equation"

let string_of_re = function
  And -> "&&"
  | Or -> "||"

(* let string_of_bool = function
  True -> "true"
  False -> "false"

let string_of_expr = function
Int(s) -> string_of_int s
| Boolean(b) -> string_of_boolean b
| Double(d) -> string_of_double d
| String(s) -> s
(* | Binop (e1, op, e2) -> 
      match op with 
        | Add -> "+"
        | Sub -> "-" *) *)


