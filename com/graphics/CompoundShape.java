	/**
	*{@link CompoundShape}Creates and Handles a CompoundShape Shape
	*@author Cay Horstmann, 2006
	*@author Alice Chang, avc2120
	*/
	package com.graphics;
	import java.awt.*;
	import java.awt.geom.*;
	
	public abstract class CompoundShape extends SelectableShape
	{
		/**
		 * Creates a new CompoundShape
		 */
	   public CompoundShape()
	   {
	      path = new GeneralPath();
	   }
	
	   /**
	    * Adds shape s into GeneralPath
	    * @param s
	    */
	   protected void add(Shape s)
	   {
	      path.append(s, false);
	   }
	
	   /**
	    * Checks if path contains aPoint
	    */
	   public boolean contains(Point2D aPoint)
	   {
	      return path.contains(aPoint);
	   }
	   
	   /**
	    * CHecks if path intersects rectangle
	    * @param rec
	    * @return
	    */
	   public boolean intersects(Rectangle2D rec)
	   {
		   return path.intersects(rec);
	   }
	
	   /**
	    * translates car by dx and dy
	    * @param dx 
	    * @param dy
	    */
	   public void translate(double dx, double dy)
	   {
	      AffineTransform t = AffineTransform.getTranslateInstance(dx, dy);
	      path.transform(t);
	   }
	
	   /**
	    * draws car
	    */
	   public void draw(Graphics2D g2)
	   {
	      g2.draw(path);
	   }
	   
	   private GeneralPath path;
	}
	
	
	
	
	
	
