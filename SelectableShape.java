/**
*{@link SelectableShape} A shape that manages its selection state.
*@author Cay Horstmann, 2006
*@author Alice Chang, avc2120
*/
import java.awt.*;

public abstract class SelectableShape implements SceneShape
{
	/**
	 * Sets selected to true or false;
	 */
	public void setSelected(boolean b)
	{
		selected = b;
	}

	/**
	 * Checks if sceneShape is selected
	 * @return true if selected false if not
	 */
	public boolean isSelected()
	{
		return selected;
	}

	/**
	 * draw selection
	 */
	public void drawSelection(Graphics2D g2)
	{
		translate(1, 1);
		draw(g2);
		translate(1, 1);
		draw(g2);
		translate(-2, -2);
	}

	private boolean selected;
}