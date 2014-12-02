import java.util.Scanner;
import java.util.*;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Scanner;
public class ChemLAB 
{
    public static Scanner scan;
    public static int n;
    public static void main(String argv[]) 
    {
        try
        {
            scan = new Scanner(new File("text.txt")); 
        }
        catch (FileNotFoundException e) //catches IO exception
        {
            e.printStackTrace();
        }
        if (scan.hasNextLine())
        {
            n = Integer.parseInt(scan.nextLine());//n is size of n*n matrix
        }
        double[][] matrix = new double[n][n];
        int count = 0;
        while (count < n && scan.hasNextLine())//stores sparse matrix into 2D array
        {
            String next = scan.nextLine();
            String [] matrixLine = next.split(" ");

            for (int i = 0; i < n; i++)
            {
                matrix[count][i] = Double.parseDouble(matrixLine[i]);
            }
            count++;
        }

        double[][] b = new double[n][1];
        if (scan.hasNextLine())//stores sparse matrix into 2D array
        {
            String next = scan.nextLine();
            String [] matrixLine = next.split(" ");

            for (int i = 0; i < n; i++)
            {
                b[i][0] = Double.parseDouble(matrixLine[i]);
            }
        }

        double inverse[][] = invert(matrix);
        double det = determinant(matrix, n);
        double[][] prod = product(inverse, b, det);

        System.out.println("Original Matrix \n");
        printMatrix(matrix);
        System.out.println("\n");

        System.out.println("The inverse is: ");
        printMatrix(inverse);
        System.out.println('\n');

        System.out.println("det is: " + det + "\n");
        
        System.out.println("prod A^(-1)*B*det is: " + n + "\n");
        printMatrix(prod);

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

 // Transform the matrix into an upper triangle
    gaussian(a, index);

 // Update the matrix b[i][j] with the ratios stored
    for (int i=0; i<n-1; ++i)
        for (int j=i+1; j<n; ++j)
            for (int k=0; k<n; ++k)
                b[index[j]][k]
            -= a[index[j]][i]*b[index[i]][k];

 // Perform backward substitutions
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
    }

