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
		Font f = new Font("SansSerif", Font.BOLD, 14);

		BufferedImage img = new BufferedImage(100, 100, BufferedImage.TYPE_INT_ARGB);
    	Graphics2D g2 = img.createGraphics();

     	GlyphVector vect = f.createGlyphVector(g2.getFontRenderContext(), "NaCl");
      	Shape shape = vect.getOutline(centerx+10, centery+30);
		add(head);
		add(e1);
		add(shape);
	}


}