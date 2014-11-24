type operator = Add | Sub | Mul | Div | Equal | Neq | Less | Leq | Greater | Geq

type expr =
    Binop of expr * operator * expr
  | Lit of int
  | Boolean of bool
  | String of string 
  | Element of expr list
  | Molecule of expr list 
  | Equation of expr list 
  | Seq of expr * expr 
  | Asn of string * expr
  | List of expr list 
  | Func of expr 
  | Call of string * expr list
  | Print of expr 
  | Null 
  | Noexpr


type stmt = 
    Block of stmt list
  | Expr of expr
  | Return of expr
  | Print of expr
  | If of expr * stmt * stmt
  | While of expr * stmt


type types = Int | Boolean | List of expr | String | Element | Molecule | Equation 

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

type program = func list