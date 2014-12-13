/**
*{@link SceneShape}Creates and Handles a Shape part of a scene
*@author Cay Horstmann, 2006
*@author Alice Chang, avc2120
*/
package com.graphics;
import java.awt.*;
import java.awt.geom.*;

public interface SceneShape
{

	void draw(Graphics2D g2);

	void drawSelection(Graphics2D g2);

	void setSelected(boolean b);

	boolean isSelected();

	void translate(double dx, double dy);
	boolean contains(Point2D p);

}
