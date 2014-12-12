type operator = Add | Sub | Mul | Div | Equal | Neq | Lt | Leq | Gt | Geq
type re = And | Or
type bool = True | False
type types = Int | Boolean | String | Element | Molecule | Equation | Double
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
  | Print of expr
  | List of expr list
  | Call of string * expr list
  | Access of expr * string
  | Null
  | Noexpr

type rule = Balance of string | Mass of string

type stmt =
    Block of stmt list
  | Expr of expr
  | Return of expr
  | If of expr * stmt list * stmt list
  | For of expr * expr * expr * stmt
  | While of expr * stmt list
  | Print of expr


type variable_decl = { vname : string; vtype : string; }
type element_decl = {
  name : string;
  mass : int;
  electrons : int;
  charge : int;
}
type molecule_decl = { mname : string; elements : variable list; }
type par_decl = { paramname : string; paramtype : string; }
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

import java.awt.*;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.*;
import javax.swing.*;
import java.applet.*;
import java.awt.Container;
import java.awt.Font;
import java.awt.RenderingHints;
import java.awt.Shape;
import java.awt.font.FontRenderContext;
import java.awt.font.GlyphVector;
import java.awt.geom.AffineTransform;
import java.awt.geom.Point2D;
import javax.swing.JComponent;
import javax.swing.JFrame;
/**
*{@link CarShape} Creates and handles a CarShape
*@author Cay Horstmann, 2006
*@author Alice Chang, avc2120
*/
public class AtomShape extends CompoundShape
{
  private int centerx;
  private int centery;
  private final int UNIT = 50;
  private int radius;
  private int diameter;
  private int offset = 20;


  public AtomShape(int x, int y, int electrons)
  {
    super();
    centerx = x;
    centery = y;
    
    diameter = 1 * UNIT;
    radius = UNIT/2;

    Ellipse2D.Double head = new Ellipse2D.Double(centerx,centery, UNIT, UNIT);
    Ellipse2D.Double e1 = new Ellipse2D.Double(centerx + UNIT ,centery, UNIT/4, UNIT/4);
    Shape e = this.convert('C');
    add(head);
    add(e1);
    add(e);
  }

  public Shape convert(char c) {
    Font f = new Font("Serif", Font.PLAIN, 24);
    // Optionally change font characteristics here
    // f = f.deriveFont(Font.BOLD, 70);

    FontRenderContext frc = getFontMetrics(f).getFontRenderContext();
    GlyphVector v = f.createGlyphVector(frc, new char[] { c });
    return v.getOutline();
}
}

