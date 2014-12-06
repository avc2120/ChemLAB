import java.util.ArrayList;

public class Parse {

	public static void main(String[] args) {
		String s = "FeCl2, Na3P == Fe3P2, NaCl";
		String[] r = s.split("(, )|(==)|(' ')");
		String[] r2 = s.split("(, )|(' ')");
		String[] individual = s.split("(, )|(==)|(?=\\p{Upper})|(' ')");
		
		ArrayList<String> elements = new ArrayList<String>();

		int counter = 0;
		for(int i=0; i<r2.length; i++){
			if(r2[i].contains("="))
				counter = i;
		}
		counter++;
		
		for (int i = 0; i < individual.length; i++) {
			String x = "";
			for (int j = 0; j < individual[i].length(); j++) {
				if (Character.isLetter(individual[i].charAt(j)))
					x = x + individual[i].charAt(j);
			}
			if (!elements.contains(x) && (x != ""))
				elements.add(x);
		}

		int[][] matrix = new int[elements.size()][r.length];

		for (int i = 0; i < elements.size(); i++) {
			String temp = elements.get(i);
			for (int j = 0; j < r.length; j++) {
				if (r[j].contains(temp)) {
					int k = r[j].indexOf(temp) + temp.length();
					if (k >= r[j].length()) {
						k = 0;
					}
					if (Character.isDigit(r[j].charAt(k))) {
						int dig = Integer.parseInt(r[j].substring(k, k + 1));
						matrix[i][j] = dig;
					} else {
						matrix[i][j] = 1;
					}
				} else {
					matrix[i][j] = 0;
				}
			}
		}
		
		for(int i=0; i<matrix.length; i++){
			for(int j=counter; j<matrix[i].length-1; j++){
				matrix[i][j] = matrix[i][j] * -1;
			}
		}

		int[][] A = new int[matrix.length][matrix[0].length - 1];
		int[] B = new int[matrix.length];

		for (int i = 0; i < matrix.length; i++) {
			for (int j = 0; j < matrix[i].length - 1; j++) {
				A[i][j] = matrix[i][j];
			}
		}
		for (int i = 0; i < B.length; i++) {
			B[i] = matrix[i][matrix[i].length - 1];
		}

		
		boolean needPadding = false;
		
		if(A[0].length<elements.size()){
			needPadding = true;
			for(int i=0; i<matrix.length; i++){
				matrix[i][matrix[i].length-1] = 1;
			}
		}

		
		for (int i = 0; i < A.length; i++) {
			for (int j = 0; j < A[i].length; j++) {
				System.out.print(A[i][j] + " ");
			}
			System.out.println();
		}
		
		for (int i = 0; i < B.length; i++) {
			System.out.println(B[i] + " ");
		}
		
		for (int i = 0; i < matrix.length; i++) {
			for (int j = 0; j < matrix[i].length; j++) {
				System.out.print(matrix[i][j] + " ");
			}
			System.out.println();
		}
		System.out.println();
		
		//if needPadding = true, then use matrix, if needPadding = false, then use A 
		//B always used 
		
		
	}

}
