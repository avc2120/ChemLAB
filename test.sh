#!/bin/bash

make
#javac ChemLAB.java
#java ChemLAB

FILES="test/*.chem"

for f in $FILES
do
	testname=${f%.chem}
	echo
	echo -ne "##### Testing "	#-ne means no new line
	echo $testname
	./chemlab $f
done

# echo
# echo "Cleaning up..."
# make clean