import java.awt.geom.*;
/**
*{@link CarShape} Creates and handles a CarShape
*@author Cay Horstmann, 2006
*@author Alice Chang, avc2120
*/
public class AtomShape extends CompoundShape
{
	private int centerx;
	private int centery;
	private final int UNIT;
	private int radius;
	private int diameter;
	private int offset = 20;


	public AtomShape(int x, int y, int width)
	{
		super();
		centerx = x;
		centery = y;
		UNIT = width/2;
		
		diameter = 1 * UNIT;
		radius = UNIT/2;
		
		Ellipse2D.Double head = new Ellipse2D.Double(centerx,centery, diameter, diameter);
		

		add(head);
	}
	/**
	 * return X position of left of person
	 */
	public int getPositionXLeft()
	{
		return centerx - radius;
	}
	/**
	 * return Y position of top of person
	 */
	public int getPositionYTop()
	{
		return centery - radius;
	}
	/**
	 * return X position of right of person
	 */
	public int getPositionXRight()
	{
		return centerx + radius;
	}
	/**
	 * return Y position of bottom of person
	 */
	public int getPositionYBot()
	{
		return centery + diameter + 3*UNIT;
	}
	/**
	 * checks if intersects with sceneShape
	 * @param s
	 * @return true if intersects false if not
	 */
	public boolean intersects(SceneShape s)
	{
		Rectangle2D.Double rec = new Rectangle2D.Double(s.getPositionXLeft(), s.getPositionYTop(), s.getWidth(), s.getHeight());
		return super.intersects(rec);
	}

	/**
	 * return width of person
	 * @return width
	 */
	public int getWidth()
	{
		return UNIT;
	}
	
	/**
	 * return height of person
	 * @return height
	 */
	public int getHeight() {
		return radius+ centery + diameter + 3*UNIT;
	}
}