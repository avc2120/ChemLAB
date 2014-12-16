#!/bin/bash

make

TESTFILES="./test/*.chem"

Compare() {
	diff -bq "$1" "$2" || echo "FAILED" 1>&2
}

for f in $TESTFILES
do
	name=${f%.chem}			# remove .chem from the end
	name=${name#./test/}	# remove ./test/ from the beginning
	exp=${f%$name.chem}"exp/$name.out"		# insert exp/ into file path
	echo
	echo "##### Testing: $name"
	./chemlab "$f" > "./test/$name.out" 2>&1
	# echo "Comparing with $exp"
	Compare "./test/$name.out" "$exp"
done
