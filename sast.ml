open Ast
type datatypes = Element | Molecule | Equation

type sexpr =
    SBinop of expr * operator * expr
  | SBrela of expr * re * expr
  | SInt of int
  | SString of string 
  | SBoolean of bool
  | SDouble of float
  | SAsn of expr * expr
  | SEquation of string * variable list * variable list
  | SConcat of string * string
  | SSeq of expr * expr 
  | SList of expr list 
  | SCall of string * expr list
  | SNull 
  | SNoexpr

type sstmt = 
    Block of stmt list
  | Expr of expr
  | Return of expr
  | If of expr * stmt * stmt
  | For of expr * expr * expr * stmt
  | While of expr * stmt
  | Print of expr

type svariable_decl = {
  vname : string;
  vtype : string;
}

type selement_decl = {
  name : string;
  mass : int;
  electrons : int;
  charge : int;
}

type smolecule_decl = {
  mname : string;
  elements: variable list;
}

type srule = 
    Balance of string
    | Mass of string


type spar_decl = {
  paramname : string; (* Name of the variable *)
  paramtype : string; (* Name of variable type *)
}

type sfunc_decl = {
  fname : sstring;
  formals : spar_decl list;
  locals: svariable_decl list;
  elements : selement_decl list;
  molecules : smolecule_decl list;
  rules : srule list;
  body : sstmt list;
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

type sprogram = sfunc_decl list
