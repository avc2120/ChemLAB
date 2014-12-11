/**
*{@link SceneShape}Creates and Handles a Shape part of a scene
*@author Cay Horstmann, 2006
*@author Alice Chang, avc2120
*/
import java.awt.*;
import java.awt.geom.*;

public interface SceneShape
{

	void draw(Graphics2D g2);

	void drawSelection(Graphics2D g2);

	void setSelected(boolean b);

	boolean isSelected();

	void translate(double dx, double dy);
	/**
	 * returns the X position of the left of sceneShape
	 * @return the X position of the left of sceneShape
	 */
	int getPositionXLeft();
	/**
	 * @return X position of the right of sceneShape
	 */
	int getPositionXRight();
	/**
	 * @return Y position of the bottom of sceneShape
	 */
	int getPositionYBot();
	/**
	 * @return Y position of top of sceneShape
	 */
	int getPositionYTop();
	/**
   Tests whether this item contains a given point.
   @param p a point
   @return true if this item contains p
	 */
	boolean contains(Point2D p);
	/**
	 * Returns width of shape
	 * @return width of shape
	 */
	int getWidth();
	/**
	 * Return height of shape
	 * @return height of shape
	 */
	int getHeight();
}
