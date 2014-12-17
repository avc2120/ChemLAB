open Ast
open Str
open Printf
open Parser
open Helper
module StringMap = Map.Make(String);;

let string_of_type = function 
      IntType -> "int"
    | BooleanType -> "Boolean"
    | StringType -> "String"
    | DoubleType -> "double"
    | _ -> ""

let string_of_op = function
    Add -> "+"
  | Sub -> "-"
  | Mul -> "*"
  | Div -> "/"
  | Mod -> "%"
  | Gt -> ">"
  | Geq -> ">="
  | Lt -> "<"
  | Leq -> "<="
  | Eq -> "=="
  | Neq -> "!="

let string_of_re = function
  And -> "&&"
  | Or -> "||"

let string_of_boolean = function
  True -> string_of_bool true
  | False -> string_of_bool false

let string_of_var = function
 Var(v)-> v


let string_of_rule = function
      Balance(equation) -> "Balance(" ^  equation ^ ");"
    | Mass(equation)-> "Mass(" ^ equation ^ ");"

let rec string_of_expr = function
  Int(i) -> string_of_int i
  | Double(d) -> string_of_float d
  | Boolean(b) -> string_of_boolean b
  | String (s) -> s
  | Asn(id, left) -> id ^ " = " ^ (string_of_expr left)
  | Seq(s1, s2) -> (string_of_expr s1) ^ " ; " ^ (string_of_expr s2)
  | Call(s,l) -> s ^ "(" ^ String.concat "" (List.map string_of_expr l) ^ ")"
  | Access(o,m) -> (string_of_expr o) ^ "." ^ m ^"();"
  | Draw(s, e1, e2, e3, e4, e5, e6, e7, e8) -> "randx = (int) (Math.random()*400); randy = (int) (Math.random()*400); scene.add(new AtomShape(randx, randy," ^ s ^ "," ^ 
    (string_of_int e1) ^ "," ^
    (string_of_int e2) ^ "," ^
    (string_of_int e3) ^ "," ^
    (string_of_int e4) ^ "," ^
    (string_of_int e5) ^ "," ^
    (string_of_int e6) ^ "," ^
    (string_of_int e7) ^ "," ^
    (string_of_int e8) ^ "))";
  | Binop (e1, op, e2) ->
  (string_of_expr e1) ^ " " ^ (match op with
    Add -> "+"
    | Sub -> "-"
    | Mul -> "*"
    | Div -> "/"
    | Mod -> "%"
    | Gt -> ">"
    | Geq -> ">="
    | Lt -> "<"
    | Leq -> "<="
    | Eq -> "=="
    | Neq -> "!=")
    ^ " " ^ (string_of_expr e2)
  | Brela (e1, op, e2) -> 
  (string_of_expr e1) ^ " " ^ (match op with
        And -> "&&"
    | Or -> "||")
    ^ " " ^ (string_of_expr e2)
    | Noexpr -> ""
    | Null -> "NULL"
    | Concat(s1, s2) -> string_of_expr s1 ^ "+" ^ string_of_expr s2
    | List(elist) -> "[" ^  String.concat ", " (List.map string_of_expr elist) ^ "]"
      | Print(s) -> "System.out.println(" ^ string_of_expr s ^ ");"
    | Equation(name, rlist, plist) -> "equation" ^ name ^ "{"  ^ String.concat "," (List.map string_of_var rlist) ^ "--" ^ String.concat "," (List.map string_of_var plist) ^ "}"

 (*    | Element(name, mass, electron, charge) -> "element " ^ name ^ "(" ^ (string_of_int mass) ^ "," ^ (string_of_int electron) ^ "," ^ (string_of_int charge) ^ ")" 
    | Molecule(name ,elist) -> "molecule " ^ name ^ "{" ^ String.concat "," (List.map string_of_var elist) ^ "}" *)
let string_of_edecl edecl = "Element " ^ edecl.name ^ "= new Element(" ^ (string_of_int edecl.mass) ^ "," ^ (string_of_int edecl.electrons) ^ "," ^ (string_of_int edecl.charge) ^ ");" 
let string_of_mdecl mdecl =  "ArrayList<Element> " ^ mdecl.mname ^ "1 = new ArrayList<Element>(Arrays.asList(" ^ String.concat "," (List.map string_of_var mdecl.elements) ^ "));" ^ 
"Molecule " ^ mdecl.mname ^ "= new Molecule("^ mdecl.mname ^ "1);"

let string_of_pdecl pdecl = string_of_type pdecl.paramtype ^ " " ^ pdecl.paramname 
let string_of_pdecl_list pdecl_list = String.concat "" (List.map string_of_pdecl pdecl_list)
let string_of_vdecl vdecl = string_of_type vdecl.vtype ^ " " ^ vdecl.vname ^ ";\n" 

let rec string_of_stmt = function
      Block(stmts) ->
        "{\n" ^ String.concat "" (List.map string_of_stmt stmts) ^ "}\n"
    | Expr(expr) -> string_of_expr expr ^ ";\n"
    | Return(expr) -> "return " ^ string_of_expr expr ^ ";\n"
    | If(e, s, Block([])) -> "if (" ^ string_of_expr e ^ ")\n{" ^ (string_of_stmt s) ^ "}"
    | If(e, s1, s2) -> "if (" ^ string_of_expr e ^ ")\n{" ^ (string_of_stmt s1) ^ "}\n" ^ "else\n{" ^ (string_of_stmt s2) ^ "}"
    | For(e1, e2, e3, s) ->
      "for (" ^ string_of_expr e1  ^ " ; " ^ string_of_expr e2 ^ " ; " ^
      string_of_expr e3  ^ ") " ^ string_of_stmt s
    | While(e, s) -> "while (" ^ string_of_expr e ^ ") {" ^ (string_of_stmt s) ^ "}"
    | Print(s) -> "System.out.println(" ^ string_of_expr s ^ ");"

  

let string_of_vdecl vdecl= 
    string_of_type vdecl.vtype ^ " " ^ vdecl.vname ^ ";"

let string_of_fdecl fdecl =
    if fdecl.fname = "main" then "public static void main(String args[])\n{\n" ^
  String.concat "" (List.map string_of_vdecl fdecl.locals) ^
  String.concat "" (List.map string_of_edecl fdecl.elements) ^
  String.concat "" (List.map string_of_mdecl fdecl.molecules) ^
  String.concat "" (List.map string_of_rule fdecl.rules) ^
  String.concat "" (List.map string_of_stmt fdecl.body) ^
  "}\n"
else
  "public static void " ^ fdecl.fname ^ "(" ^ String.concat ", " (List.map string_of_pdecl fdecl.formals) ^ ")\n{\n" ^
  String.concat "" (List.map string_of_vdecl fdecl.locals) ^
  String.concat "" (List.map string_of_edecl fdecl.elements) ^
  String.concat "" (List.map string_of_mdecl fdecl.molecules) ^
  String.concat "" (List.map string_of_rule fdecl.rules) ^
  String.concat "" (List.map string_of_stmt fdecl.body) ^
  "}\n"

let string_of_fdecl_list fdecl_list = 
    String.concat "" (List.map string_of_fdecl fdecl_list)

let string_of_program (vars, funcs) =
  String.concat "" (List.map string_of_vdecl (List.rev vars) ) ^ "\n" ^
  String.concat "\n" (List.map string_of_fdecl (List.rev funcs) ) ^ "\n"


 let rec mass_sum element_list = match element_list with
	| [] -> 0
	| hd :: tl -> hd.mass + mass_sum tl;; 
	

let rec charge_sum molecule = match molecule with
	| [] -> 0
	| hd :: tl -> hd.charge + charge_sum tl;;


let contains s1 s2 =
    let re = Str.regexp_string s2
    in
        try ignore (Str.search_forward re s1 0); true
        with Not_found -> false

let program program prog_name =
     let prog_string = Helper.balance_head ^ prog_name ^ Helper.balance_mid ^ "public static final SceneComponent scene = new SceneComponent();" ^ Helper.balance_mid1 ^ prog_name ^ Helper.balance_mid15 ^ Helper.balance_mid2 ^ (string_of_fdecl_list program) ^ Helper.balance_end in
       let out_chan = open_out (Printf.sprintf "%s.java" prog_name) in
          ignore(Printf.fprintf out_chan "%s" prog_string); 
      close_out out_chan; 
      ignore(Sys.command(Printf.sprintf "javac %s.java" prog_name)); 
    let contains s1 s2 =
    let re = Str.regexp_string s2
    in
        try ignore (Str.search_forward re s1 0); true
        with Not_found -> false
    in
                if (contains (string_of_fdecl_list program) "graphics") then (ignore(Sys.command ("javac ChemLAB.java SceneEditor.java")); ignore(Sys.command("java SceneEditor")));
                ignore(Sys.command(Printf.sprintf "java %s" prog_name)); 
