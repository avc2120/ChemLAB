type operator = Add | Sub | Mul | Div | Mod
type rop = Eq | Neq | Lt | Leq | Gt | Geq 
type re = And | Or
type bool = True | False
type data_type = IntType | BooleanType | StringType | DoubleType | ElementType | MoleculeType | EquationType
type element = Element of string
type molecule = Molecule of string

type expr =
    Binop of expr * operator * expr
  | Brela of expr * re * expr
  | Int of int
  | String of string 
  | Boolean of expr * rop * expr
  | Double of float
  | Asn of string * expr
  | Equation of string * element list * element list
  | Balance of molecule list * molecule list
  | Concat of expr * expr
  | Print of expr
  | List of expr list 
  | Call of string * expr list
  | Access of expr * string
  | Bracket of expr
  | Charge of string
  | Electrons of string
  | Mass of string
  | Null 
  | Noexpr

type stmt = 
    Block of stmt list
  | Expr of expr
  | Return of expr
  | If of expr * stmt * stmt
  | For of expr * expr * expr * stmt
  | While of expr * stmt
  | Print of expr
  | Draw of string * int * int * int * int * int * int * int * int

type variable_decl = {
  vname : string;
  vtype : data_type;
}

type element_decl = {
  name : string;
  mass : int;
  electrons : int;
  charge : int;
}

type molecule_decl = {
  mname : string;
  elements: element list;
}




type par_decl = {
  paramname : string; (* Name of the variable *)
  paramtype : data_type; (* Name of variable type *)
}

type func_decl = {
  fname : string;
  formals : par_decl list;
  locals: variable_decl list;
  elements : element_decl list;
  molecules : molecule_decl list;
  body : stmt list;
}

(* type program = {
  gdecls : var_decl list;
  fdecls : func_decl list
}
 *)
type program = func_decl list






