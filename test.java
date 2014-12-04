import java.util.ArrayList;

public class Parse {

	public static void main(String[] args) {
		String s = "MgO, Fe == Fe2O3, Mg";
		String[] r = s.split("(, )|(==)|(' ')");
		String[] individual = s.split("(, )|(==)|(?=\\p{Upper})|(' ')");
		ArrayList<String> elements = new ArrayList<String>();
		
		
		
		
		for(int i=0; i<individual.length; i++){
			String x = "";
			for(int j=0; j<individual[i].length(); j++){
				if(Character.isLetter(individual[i].charAt(j)))
						x = x+individual[i].charAt(j);
			}
			if(!elements.contains(x) && (x!=""))
				elements.add(x);
		}
		
		
	
		
		int[][] matrix = new int[elements.size()][r.length];
		
		for(int i=0; i<elements.size(); i++){
			String temp = elements.get(i);
			for(int j=0; j<r.length; j++){
				if(r[j].contains(temp)){
					int k = r[j].indexOf(temp)+temp.length();
					if(k>=r[j].length()){
						k=0;
					}
					if(Character.isDigit(r[j].charAt(k))){
						int dig = Integer.parseInt(r[j].substring(k,k+1));
						System.out.println(dig);
						matrix[i][j] = dig;
					}else{
						matrix[i][j] = 1;
					}
				}else{
					matrix[i][j] = 0;
				}
			}
		}
		
	
	
		for(int i=0; i<matrix.length; i++){
			for(int j=0; j<matrix[i].length; j++){
				System.out.print(matrix[i][j] + " ");
			}
			System.out.println();
		}

	}

}