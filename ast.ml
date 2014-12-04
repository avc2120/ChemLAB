type operator = Add | Sub | Mul | Div | Equal | Neq | Lt | Leq | Gt | Geq 
type re = And | Or
type bool = True | False
type types = Int | Boolean | String | Element | Molecule | Equation | Double

type variable = 
Var of string

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
  | Molecule of string * variable list
  | Equation of string * variable list * variable list
  | Concat of string * string
  | Seq of expr * expr 
  | List of expr list 
  | Call of string * expr list
  | Null 
  | Noexpr

type rule = 
    Balance of string
  | Mass of string
  | Charge of string

type stmt = 
    Block of stmt list
  | Expr of expr
  | Return of expr
  | If of expr * stmt * stmt
  | For of expr * expr * expr * stmt
  | While of expr * stmt
  | Print of expr

type variable_decl = {
  vname : string;
  vtype : string;
}

type element_decl = {
  name : string;
  mass : int;
  electrons : int;
  charge : int;
}

type molecule_decl = {
  mname : string;
  elements: variable list;
}

type par_decl = {
  paramname : string; (* Name of the variable *)
  paramtype : string; (* Name of variable type *)
}

type func_decl = {
  fname : string;
  formals : par_decl list;
  locals: variable_decl list;
  elements : element_decl list;
  molecules : molecule_decl list;
  rules : rule list;
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
  | Gt -> ">"
  | Geq -> ">="
  | Lt -> "<"
  | Leq -> "<="
  | Equal -> "=="
  | Neq -> "!="


let string_of_re = function
  And -> "&&"
  | Or -> "||"

let string_of_bool = function
  True -> "true"
  | False -> "false"

let rec string_of_var = function
 Var(v)-> v

let string_of_rule = function
  Balance(s) -> s
  | Mass(m) -> m
  | Charge(c) -> c

let rec string_of_expr = function
  Int(i) -> string_of_int i
  | Double(d) -> string_of_float d
  | Boolean(b) -> string_of_bool b
  | String (s) -> s
  | Asn(id, left) -> (string_of_expr id) ^ " = " ^ (string_of_expr left)
  | Seq(s1, s2) -> (string_of_expr s1) ^ " ; " ^ (string_of_expr s2)
  | Call(s, e) -> s ^ "(" ^ String.concat ", " (List.map string_of_expr e) ^ ")"
  | Binop (e1, op, e2) ->
  (string_of_expr e1) ^ " " ^ (match op with
        Add -> "+"
    | Sub -> "-"
    | Mul -> "*"
    | Div -> "/"
    | Gt -> ">"
    | Geq -> ">="
    | Lt -> "<"
    | Leq -> "<="
    | Equal -> "=="
    | Neq -> "!=")
    ^ " " ^ (string_of_expr e2)
  | Brela (e1, op, e2) -> 
  (string_of_expr e1) ^ " " ^ (match op with
        And -> "&&"
    | Or -> "||")
    ^ " " ^ (string_of_expr e2)
    | Noexpr -> ""
    | Null -> "NULL"
    | Concat(s1, s2) -> s1 ^ "^" ^ s2
    | List(elist) -> "[" ^  String.concat ", " (List.map string_of_expr elist) ^ "]"
    | Balance(v) -> "balance(" ^ v ^ ")"
    | Element(name, mass, electron, charge) -> "element " ^ name ^ "(" ^ (string_of_int mass) ^ "," ^ (string_of_int electron) ^ "," ^ (string_of_int charge) ^ ")" 
    | Molecule(name ,elist) -> "molecule " ^ name ^ "{" ^ String.concat "," (List.map string_of_var elist) ^ "}"
    | Equation(name, rlist, plist) -> "equation" ^ name ^ "{"  ^ String.concat "," (List.map string_of_var rlist) ^ "--" ^ String.concat "," (List.map string_of_var plist) ^ "}"

let string_of_edecl edecl = "element " ^ edecl.name ^ "(" ^ (string_of_int edecl.mass) ^ "," ^ (string_of_int edecl.electrons) ^ "," ^ (string_of_int edecl.charge) ^ ");" 
let string_of_mdecl mdecl =  "molecule " ^ mdecl.mname ^ "{" ^ String.concat "," (List.map string_of_var mdecl.elements) ^ "};"

let string_of_pdecl pdecl = pdecl.paramtype ^ " " ^ pdecl.paramname 
let string_of_vdecl vdecl = vdecl.vtype ^ " " ^ vdecl.vname ^ ";\n" 

let rec string_of_stmt = function
  Block(stmts) ->
    "{\n" ^ String.concat "" (List.map string_of_stmt stmts) ^ "}\n"
  | Expr(expr) -> string_of_expr expr ^ ";\n"
  | Return(expr) -> "return " ^ string_of_expr expr ^ ";\n"
  | If(e, s, Block([])) -> "if (" ^ string_of_expr e ^ ")\n" ^ string_of_stmt s
  | If(e, s1, s2) -> "if (" ^ string_of_expr e ^ ")\n" ^
    string_of_stmt s1 ^ "else\n" ^ string_of_stmt s2
  | For(e1, e2, e3, s) ->
      "for (" ^ string_of_expr e1  ^ " ; " ^ string_of_expr e2 ^ " ; " ^
      string_of_expr e3  ^ ") " ^ string_of_stmt s
  | While(e, s) -> "while (" ^ string_of_expr e ^ ") " ^ string_of_stmt s
  | Print(s) -> print_endline (string_of_expr s); string_of_expr s
  

let string_of_fdecl fdecl =
  "function" ^ " " ^ fdecl.fname ^ "(" ^ String.concat ", " (List.map string_of_pdecl fdecl.formals) ^ ")\n{\n" ^
  String.concat "" (List.map string_of_vdecl fdecl.locals) ^
  String.concat "" (List.map string_of_edecl fdecl.elements) ^
  String.concat "" (List.map string_of_mdecl fdecl.molecules) ^
  String.concat "" (List.map string_of_rule fdecl.rules) ^
  String.concat "" (List.map string_of_stmt fdecl.body) ^
  "}\n"


let string_of_program (vars, funcs) =
  String.concat "" (List.map string_of_vdecl (List.rev vars) ) ^ "\n" ^
  String.concat "\n" (List.map string_of_fdecl (List.rev funcs) ) ^ "\n"


