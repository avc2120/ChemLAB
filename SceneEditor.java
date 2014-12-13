/**
*{@link SceneEditor}Creates SceneEditor that runs program
*@author Cay Horstmann, 2006
*@author Alice Chang, avc2120
*/

public class SceneEditor
{
   public static void main(String[] args)
   {
   	final static SceneComponent scene = new SceneComponent();
   		ChemLAB sceneFrame = new ChemLAB();
   		ChemLAB.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        ChemLAB.setSize(500, 500);
        ChemLAB.add(scene, BorderLayout.CENTER);
		ChemLAB.graphics();
      	sceneFrame.setVisible(true); 
   }
}

