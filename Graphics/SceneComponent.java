/**
*{@link SceneComponent}Creates and Handles a SceneComponent
*@author Cay Horstmann, 2006
*@author Alice Chang, avc2120
*/
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.util.*;

public class SceneComponent extends JComponent 
{
	final Class<AtomShape> AtomShape = AtomShape.class;

	/**
	 * Creates a SceneComponent
	 */
	private ArrayList<SceneShape> houseCar = new ArrayList<SceneShape>();
	private static final long serialVersionUID = 1L;
	public SceneComponent()
	{
		final Class<AtomShape> AtomShape = AtomShape.class;
		shapes = new ArrayList<SceneShape>();

		addMouseListener(new MouseAdapter()
		{
			public void mousePressed(MouseEvent event)
			{
				mousePoint = event.getPoint();
				for (SceneShape s : shapes)
				{
					if (s.contains(mousePoint))
					{
						s.setSelected(!s.isSelected());
					}
				}
				repaint();
			}
		});

		addMouseMotionListener(new MouseMotionAdapter()
		{
			public void mouseDragged(MouseEvent event)
			{
				Point lastMousePoint = mousePoint;
				mousePoint = event.getPoint();
				for (SceneShape s :shapes)
				{
					if (s.isSelected())
					{
						double dx = mousePoint.getX() - lastMousePoint.getX();
						double dy = mousePoint.getY() - lastMousePoint.getY();
						s.translate((int) dx, (int) dy);	
					}
				}
				repaint();
			}
		});
	}


	public void add(SceneShape s)
	{
		shapes.add(s);
		repaint();
	}
	


	public void removeSelected()
	{
		for (int i = shapes.size() - 1; i >= 0; i--)
		{
			SceneShape s = shapes.get(i);
			if (s.isSelected()) 
			{
				shapes.remove(i);
			}	
			repaint();
		}
		if (shapes.size() == 0)
		{
			SceneFrame.stickButton.setEnabled(false);
		}
		SceneFrame.leftMostX = SceneFrame.WIDTH;
	}
	
	/**
	 * @return ArrayList of shapes
	 */
	public ArrayList<SceneShape> getShapes()
	{
		return shapes;
	}

	/**
	 * @return ArrayList of Selected Shapes
	 */
	public ArrayList<SceneShape> getSelected()
	{
		ArrayList<SceneShape> selected = new ArrayList<SceneShape>();
		for (int i = shapes.size() - 1; i >= 0; i--)
		{
			SceneShape s = shapes.get(i);
			if(s.isSelected())
			{
				selected.add(s);
			}
		}
		return selected;
	}

	/**
	 * Paints component
	 */
	public void paintComponent(Graphics g)
	{
		Graphics2D g2 = (Graphics2D) g;
		for (SceneShape s : shapes)
		{
			s.draw(g2);
			if (s.isSelected())
				s.drawSelection(g2);
		}
	}
	private ArrayList<SceneShape> shapes;
	private Point mousePoint;
}