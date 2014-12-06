type operator = Add | Sub | Mul | Div | Mod | Equal | Neq | Less | Leq | Greater | Geq | And | Or

type expr =
    Binop of expr * operator * expr
  | Int of int
  | Double of float
  | Boolean of bool
  | String of string 
  | Element of int * int * int
  | Molecule of expr list 
  | Equation of expr list 
  | Seq of expr * expr 
  | Asn of string * expr
  | List of expr list 
  | Equal of expr
  | Var of string
  | Func of expr 
  | Call of string * expr list
  | Null 
  | Noexpr

type stmt = 
    Block of stmt list
  | Expr of expr
  | Return of expr
  | If of expr * stmt * stmt
  | While of expr * stmt
  | Print of expr 

type stmt_list = stmt list

type types = Int | Boolean | List of expr | String

type var_decl = Var_Decl of types * string

(* type var_decl = {
  vtype: types list;
  vname: string;
} *)

type func_decl = {
  fname : string;
  formals : var_decl list;
  (* locals : var_decl list; *)
  body : stmt list;
  ret : types list;
}

type object_decl = {
  sname: string;
  smembers: var_decl list;
  smethods: func_decl list; 
}

(* type program = {
  objectdecls : object_decl list;
  gdecls : var_decl list;
  fdecls : func_decl list
} *)

type func = 
    Func of func_decl
  | Obj of object_decl

type program = stmt list
(* 
let string_of_op = function
 Add -> "="
| Sub -> "-"
| Mult -> "*"
| Div -> "/" *)