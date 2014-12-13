
import com.graphics.*;
import java.util.*;
import java.awt.*;
import java.awt.event.*;
import java.util.ArrayList;
import javax.swing.*;

public class ChemLAB 
{
    
    public static boolean debug = false;
    public static int randx;
    public static int randy;
    
    public ChemLAB()
    {
        
    }

    public static void Balance(String s)
    {
        String[] r = s.split("(, )|(==)|(' ')");
        String[] r1 = s.split("\\s*(,|\\s)\\s*");
        String[] r2 = s.split("(, )|(' ')");
        String[] individual = s.split("(, )|(== )|(?=\\p{Upper})|(' ')");
        
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

        double[][] matrix = new double [elements.size()][r.length];

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
        


        double[][] A = new double[matrix.length][matrix[0].length - 1];
        double[][] B = new double[matrix.length][1];

        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix[i].length - 1; j++) {
                A[i][j] = matrix[i][j];
            }
        }

        int n = A[0].length<A.length? A.length : A[0].length;
        int difference = Math.abs(A.length-A[0].length);
        double[][] A1 = new double[n][n];

        for (int i = 0; i < B.length; i++) {
            B[i][0] = matrix[i][matrix[i].length - 1];
        }
        
        
        for(int i = 0; i < A.length; i++)
        {
            for(int j = 0; j < A[0].length; j++)
            {
                A1[i][j] = A[i][j];
            }
        }

        if(A[0].length<A.length){
            for(int i=0; i<n; i++){
                for(int j = n-difference; j< n; j++)
                {
                    A1[i][j] = 1;
                }
            }
        }
        else if (A[0].length> A.length)
        {
            for(int i=0; i<n; i++){
                for(int j = n-difference; j< n; j++)
                {
                    A1[j][i] = 1;
                }
            }
        }

        for(int i=0; i<n; i++)
        {
            for(int j=counter; j<n; j++){
                matrix[i][j] = matrix[i][j] * -1;
            }
        }
        
        double det = determinant(A1, n);
        double inverse[][] = invert(A1);
        double[][] prod = product(inverse, B, det);

        double factor = 0;
        boolean simplified = true;
        for(int i = 0; i < prod.length; i++)
        {
            for(int j = i; j < prod.length; j++)
            {
                if(mod(prod[i][0],prod[j][0]))
                {
                    simplified = false;
                    break;
                }
            }
        }

        if (simplified == false)
        {
            factor = findSmallest(prod);
            simplify(prod, factor);

        }
        boolean subtract = false;

        for(int j = 0; j < r1.length; j++)
        {
            if(j == r1.length-1)
            {
                int sum = 0;
                int count = 0;
                for(int m = 0; m < B[0].length; m++)
                {
                    if(B[m][0] == 0)
                    {
                        count++;
                    }
                }
                for(int k = 0; k < n; k++)
                {
                    sum += Math.round(matrix[count][k]*Math.abs(prod[k][0]));

                }

                if(B[count][0] == 0)
                {

                    System.out.println(1 + " " + r2[j-2]);
                }
                else
                {
                    
                    System.out.println(Math.abs(sum/(int)B[count][0]) + " " + r2[j-2]);
                }
            }
            else if(r1[j].equals("=="))
            {
                System.out.print("--> ");
                subtract = true;
            }
            else if (subtract == true)
            {
                int coeff = (int)Math.round(Math.abs(prod[j-1][0]));
                System.out.print(coeff + " " + r1[j] + " ");
            }
            else
            {
                int coeff = (int)Math.round(Math.abs(prod[j][0]));
                System.out.print(coeff + " " + r1[j] + " ");
            }
        }

    }

    public static boolean mod(double a, double b) 
    {

  		int c = (int)(a)/(int)(b);
  		if (c*b == a)
  			return true;
  		else
  			return false;
  	}

    public static void printMatrix(double[][] matrix)
    {
        for (int i = 0; i < matrix.length; i ++)
        {
            for(int j = 0; j< matrix[0].length; j++)
            {
                System.out.print(matrix[i][j] + " ");
            }
            System.out.print("\n");
        }
    }

    public static double findSmallest(double a[][])
    {
        double smallest = a[0][0];
        for(int i = 0; i < a.length; i++)
        {
            if(Math.abs(a[i][0]) < Math.abs(smallest))
                smallest = a[i][0];
        }
        return smallest;
    }

    public static double[][] simplify(double a[][], double smallest)
    {
        int largest = 0;
        boolean all = true;
        for(int i = 1; i <=  Math.abs(smallest); i++)
        {
            all = true;
            for(int j = 0; j < a.length; j++)
            {
                if(!mod(a[j][0],i) )
                {
                    all = false;
                }
            }
            if (Math.abs(i)>Math.abs(largest) && all == true)
                largest = i;
        }
        if (debug == true)
            System.out.println(largest);
        if(largest!=0)
        {
            for(int k = 0; k < a.length; k++)
            {
                a[k][0] = a[k][0]/largest;
            }
        }
        return a;
    }

    public static double[][] product(double a[][], double b[][], double det)
    {
        int rowsInA = a.length;
       int columnsInA = a[0].length; // same as rows in B
       int columnsInB = b[0].length;
       double[][] c = new double[rowsInA][columnsInB];
       for (int i = 0; i < rowsInA; i++) {
         for (int j = 0; j < columnsInB; j++) {
             for (int k = 0; k < columnsInA; k++) {
                 c[i][j] = c[i][j] + a[i][k] * b[k][j];
             }
         }
     }

     for(int i = 0; i < rowsInA; i++)
     {
        c[i][0] = c[i][0]*det;
    }
    return c;
}
public static double determinant(double A[][],int N)
{
    double det=0;
    if(N == 1)
    {
        det = A[0][0];
    }
    else if (N == 2)
    {
        det = A[0][0]*A[1][1] - A[1][0]*A[0][1];
    }
    else
    {
        det=0;
        for(int j1=0;j1<N;j1++)
        {
            double[][] m = new double[N-1][];
            for(int k=0;k<(N-1);k++)
            {
                m[k] = new double[N-1];
            }
            for(int i=1;i<N;i++)
            {
                int j2=0;
                for(int j=0;j<N;j++)
                {
                    if(j == j1)
                        continue;
                    m[i-1][j2] = A[i][j];
                    j2++;
                }
            }
            det += Math.pow(-1.0,1.0+j1+1.0)* A[0][j1] * determinant(m,N-1);
        }
    }
    return det;
}
public static double[][] invert(double a[][])
{
    int n = a.length;
    double x[][] = new double[n][n];
    double b[][] = new double[n][n];
    int index[] = new int[n];
    for (int i=0; i<n; ++i) 
        b[i][i] = 1;

    gaussian(a, index);

    for (int i=0; i<n-1; ++i)
        for (int j=i+1; j<n; ++j)
            for (int k=0; k<n; ++k)
                b[index[j]][k]
            -= a[index[j]][i]*b[index[i]][k];

            for (int i=0; i<n; ++i) 
            {
                x[n-1][i] = b[index[n-1]][i]/a[index[n-1]][n-1];
                for (int j=n-2; j>=0; --j) 
                {
                    x[j][i] = b[index[j]][i];
                    for (int k=j+1; k<n; ++k) 
                    {
                        x[j][i] -= a[index[j]][k]*x[k][i];
                    }
                    x[j][i] /= a[index[j]][j];
                }
            }
            return x;
        }

// Method to carry out the partial-pivoting Gaussian
// elimination.  Here index[] stores pivoting order.

        public static void gaussian(double a[][], int index[]) 
        {
            int n = index.length;
            double c[] = new double[n];

 // Initialize the index
            for (int i=0; i<n; ++i) 
                index[i] = i;

 // Find the rescaling factors, one from each row
            for (int i=0; i<n; ++i) 
            {
                double c1 = 0;
                for (int j=0; j<n; ++j) 
                {
                    double c0 = Math.abs(a[i][j]);
                    if (c0 > c1) c1 = c0;
                }
                c[i] = c1;
            }

 // Search the pivoting element from each column
            int k = 0;
            for (int j=0; j<n-1; ++j) 
            {
                double pi1 = 0;
                for (int i=j; i<n; ++i) 
                {
                    double pi0 = Math.abs(a[index[i]][j]);
                    pi0 /= c[index[i]];
                    if (pi0 > pi1) 
                    {
                        pi1 = pi0;
                        k = i;
                    }
                }

   // Interchange rows according to the pivoting order
                int itmp = index[j];
                index[j] = index[k];
                index[k] = itmp;
                for (int i=j+1; i<n; ++i)   
                {
                    double pj = a[index[i]][j]/a[index[j]][j];

 // Record pivoting ratios below the diagonal
                    a[index[i]][j] = pj;

 // Modify other elements accordingly
                    for (int l=j+1; l<n; ++l)
                        a[index[i]][l] -= pj*a[index[j]][l];
                }
            }   
        }
        public static void main(String args[])
{
Balance("MgO, Fe == Fe2O3, Mg");Balance("Cu2S, O2 == Cu, SO2");Balance("Mg, HCl == MgCl2, H2");Balance("Ag, HNO3 == AgNO3, NO, H2O");Balance("Cl2, CaO2H2 == CaCl2O2, CaCl2, H2O");Balance("HNO3, Cu == CuN2O6, H2O, NO");Balance("C3H8O, O2 == CO2, H2O");Balance("KBr, KMnO4, H2SO4 == Br2, MnSO4, K2SO4, H2O");Balance("HNO3, Cu == CuN2O6, H2O, NO");}

    }