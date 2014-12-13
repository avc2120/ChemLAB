package com.graphics;
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
import java.awt.geom.*;
import java.awt.image.BufferedImage;

/*
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


	public AtomShape(int x, int y, String name, int e_1, int e_2, int e_3, int e_4, int e_5, int e_6, int e_7, int e_8)
	{
		super();
		centerx = x;
		centery = y;
		
		diameter = 1 * UNIT;
		radius = UNIT/2;

		Ellipse2D.Double head = new Ellipse2D.Double(centerx,centery, UNIT, UNIT);
		//top
		if(e_1 ==1)  {Ellipse2D.Double e5 = new Ellipse2D.Double(centerx + 9 ,centery-15, UNIT/4, UNIT/4); add(e5); }
		if(e_2 ==1)  {Ellipse2D.Double e6 = new Ellipse2D.Double(centerx + 29 ,centery-15, UNIT/4, UNIT/4); add(e6);}
		//right
		if(e_3 ==1) {Ellipse2D.Double e1 = new Ellipse2D.Double(centerx + 53 ,centery+10, UNIT/4, UNIT/4); add(e1);}
		if(e_4 ==1)  {Ellipse2D.Double e2 = new Ellipse2D.Double(centerx + 53 ,centery+30, UNIT/4, UNIT/4); add(e2);}
		//bottom
		if(e_5 ==1)  {Ellipse2D.Double e7 = new Ellipse2D.Double(centerx + 9 ,centery+53, UNIT/4, UNIT/4); add(e7);}
		if(e_6 ==1)  {Ellipse2D.Double e8 = new Ellipse2D.Double(centerx + 29 ,centery+53, UNIT/4, UNIT/4); add(e8);}
		//left
		if(e_7 >=1)  {Ellipse2D.Double e3 = new Ellipse2D.Double(centerx - 15 ,centery+10, UNIT/4, UNIT/4); add(e3);}
		if(e_8 >=1)  {Ellipse2D.Double e4 = new Ellipse2D.Double(centerx - 15 ,centery+30, UNIT/4, UNIT/4); add(e4);}

		Font f = new Font("SansSerif", Font.BOLD, 14);

		BufferedImage img = new BufferedImage(100, 100, BufferedImage.TYPE_INT_ARGB);
		
    	Graphics2D g2 = img.createGraphics();

     	GlyphVector vect = f.createGlyphVector(g2.getFontRenderContext(), name);
      	Shape shape = vect.getOutline(centerx+20, centery+30);
		add(head);
		add(shape);
	}


}