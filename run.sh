#!/bin/bash

TESTFILES="files_test/*.chem"
CODETESTFILES="files_test/CodeTest/*.chem"
ran=0
success=0
fail=0

Compare() {
	diff -bq "$1" "$2" && { 
		(( success++ ))
		echo "PASS"
	} || {
		echo "FAILED: does not match expected output"
		cat "$1"
		(( fail++ ))
	}
}

Test() {
	(( ran++ ))
	name=${f%.chem}			# remove .chem from the end
	name=${name#files_test/}	# remove ./files_test/ from the beginning
	exp=${f%$name.chem}"exp/$name.out"		# insert exp/ into file path
	echo "===================="
	echo "Testing: $name"
	./chemlab "$f" > "files_test/$name.out" 2>&1 && {
	# echo "Comparing with $exp"
		# if [[ -e $exp ]]; then
			Compare "files_test/$name.out" "$exp"
		# else 
			# echo "FAILED: no expected file found"
		# fi
	} || {
		cat "files_test/$name.out"
		echo "FAILED: did not compile"
		(( fail++ ))
	}
}

for f in $TESTFILES
do
	Test f
done

for f in $CODETESTFILES
do
	Test f
done

echo "===================="
echo "SUMMARY"
echo "Number of tests run: $ran"
echo "Number Passed: $success"
echo "Number Failed: $fail"
