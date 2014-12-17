#!/bin/bash

TESTFILES="test/*.chem"
ran=0
success=0

Compare() {
	diff -bq "$1" "$2" && { 
		(( success++ ))
		echo "PASS"
	} || {
		cat "$1"
		echo "FAILED: does not match expected output"
	}
}

Test() {
	(( ran++ ))
	name=${f%.chem}			# remove .chem from the end
	name=${name#test/}	# remove ./test/ from the beginning
	exp=${f%$name.chem}"exp/$name.out"		# insert exp/ into file path
	echo "===================="
	echo "Testing: $name"
	./chemlab "$f" > "test/$name.out" 2>&1 && {
	# echo "Comparing with $exp"
		# if [[ -e $exp ]]; then
			Compare "test/$name.out" "$exp"
		# else 
			# echo "FAILED: no expected file found"
		# fi
	} || {
		cat "test/$name.out"
		echo "FAILED: did not compile"
	}
}

for f in $TESTFILES
do
	Test f
done

echo "===================="
echo "SUMMARY"
echo "Number of tests run: $ran"
echo "Number Passed: $success"
