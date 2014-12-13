/**
*{@link SceneEditor}Creates SceneEditor that runs program
*@author Cay Horstmann, 2006
*@author Alice Chang, avc2120
*/

public class SceneEditor
{

   public static void main(String[] args)
   {
      ChemLAB sceneFrame = new ChemLAB();
      ChemLAB.draw();
      sceneFrame.setVisible(true);
   }
}

