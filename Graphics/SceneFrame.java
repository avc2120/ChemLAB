/**
 *{@link SceneFrame}Creates and Handles scene
 *@author Cay Horstmann, 2006
 *@author Alice Chang, avc2120
 */
import java.awt.*;
import java.awt.event.*;
import java.util.ArrayList;

import javax.swing.*;


public class SceneFrame extends JFrame implements Action
{
	private static final long serialVersionUID = 1L;
	public static final int OBJECT_WIDTH = 50;
	public static int leftMostX = WIDTH;
	final static SceneComponent scene = new SceneComponent();

	public static final JButton stickButton = new JButton("Atom");
	public static final JButton removeButton = new JButton("Remove");
	public static int total = 0;

	public SceneFrame()
	{
		final Class<AtomShape> AtomShape = AtomShape.class;
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		removeButton.setEnabled(false);
		
		
		stickButton.addActionListener(new ActionListener()
		{
			public void actionPerformed(ActionEvent event)
			{
				int count = 0;
				int randx1 = (int)(Math.random()*(500));
				int randy1 = (int)(Math.random()*(500)); 
				scene.add(new AtomShape(randx1, randy1, OBJECT_WIDTH));	
			}
		});


		removeButton.addActionListener(new ActionListener()
		{
			public void actionPerformed(ActionEvent event)
			{
				ArrayList<SceneShape> myShapes = scene.getSelected();
				for(int i = 0; i < myShapes.size(); i++)
				{
					SceneShape s = myShapes.get(i);
					if(AtomShape.isInstance(s))
					{
						total-=2;
					}
					else
					{
						total--;
					}
				}
				scene.removeSelected();
			}
		});

		JPanel buttons = new JPanel();
		buttons.add(stickButton);
		buttons.add(removeButton);

		add(scene, BorderLayout.CENTER);
		add(buttons, BorderLayout.NORTH);

		setSize(500, 500);
	}


	public void actionPerformed(ActionEvent e) {

		// TODO Auto-generated method stub

	}

	public Object getValue(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	public void putValue(String arg0, Object arg1) {
		// TODO Auto-generated method stub

	}
}

