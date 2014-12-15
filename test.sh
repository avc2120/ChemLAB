#!/bin/bash

make

TESTFILES="test/*.chem"

for f in $TESTFILES
do
	testname=${f%.chem}
	echo
	echo -ne "##### Running "	#-ne = no new line
	echo $testname
	./chemlab $f
done

# echo
# echo "Cleaning up..."
# make clean
