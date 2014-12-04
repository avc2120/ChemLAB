#!/bin/bash
make
#javac ChemLAB.java
#java ChemLAB

echo
echo ***Begin Tests***
echo Test 1 Hello World
./chemlab < test1.chem
echo
echo Test 2 Variable:
./chemlab < test2.chem
echo
echo Test 3 Arithmetic:
./chemlab < test3.chem
echo
echo Test 4 String Concatenation:
./chemlab < test4.chem
echo
echo Test 5 If Conditional:
./chemlab < test5.chem
echo
echo Test 6 Nested If Else:
./chemlab < test6.chem
echo
echo Test 7 Element Declaration
./chemlab < test7.chem
echo
echo Test 8 Molecule Declaration
./chemlab < test8.chem
echo
echo Test 9 Equation Declaration
./chemlab < test9.chem
echo
echo Test 10 Balance Equation
./chemlab < test10.chem
