all:
	ocamllex scanner.mll
	ocamlyacc parser.mly
	ocamlyacc parser.mly; 
	ocamlc -i ast.ml > ast.mli;
	ocamlc -c ast.mli;
	ocamlc -c ast.ml; 
	ocamlc -c parser.mli; 
	ocamlc -c scanner.ml; 
	ocamlc -c parser.ml
	ocamlc -o ast.cmo parser.cmo scanner.cmo
