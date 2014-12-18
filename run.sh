#!/bin/bash

TESTFILES="files_test/*.chem"
DEMOFILES="files_demo/*.chem"
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

for f in $TESTFILES
do
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
	}
done

for f in $DEMOFILES
do
	(( ran++ ))
	name=${f%.chem}			# remove .chem from the end
	name=${name#files_demo/}	# remove ./files_demo/ from the beginning
	exp=${f%$name.chem}"exp/$name.out"		# insert exp/ into file path
	echo "===================="
	echo "Testing: $name"
	./chemlab "$f" > "files_demo/$name.out" 2>&1 && {
	# echo "Comparing with $exp"
		# if [[ -e $exp ]]; then
			Compare "files_demo/$name.out" "$exp"
		# else 
			# echo "FAILED: no expected file found"
		# fi
	} || {
		cat "files_demo/$name.out"
		echo "FAILED: did not compile"
	}
done

echo "===================="
echo "SUMMARY"
echo "Number of tests run: $ran"
echo "Number Passed: $success"
