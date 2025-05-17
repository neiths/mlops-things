#!/bin/bash

# declare a variable first_arg to be your input argument
first_arg=$1

# print your first ever variable
echo "your first variable is $first_arg"

# demo if-else 
if [[ $first_arg > 0 ]]; then
	echo "First argument is positive"
elif [[ $first_arg == 0 ]]; then
	echo "First argument is zero"
else
	echo "First argument is negative"
fi

# print all numbers from 0 to first_arg-1
echo "all numbers from 0 to first_arg-1:"
for ((i=0;i<first_arg;i++)); do
	echo $i
done

# demo a function
file_path="data/data1.csv"
my_readfile_func() {
	while read -r line; do
		# use internal Field separator (IFS) to split string,
		# then read the raw input (-r) and create a new array (-a) my_record
		IFS=',' read -ra my_record <<< "$line"
		echo ${my_record[-1]}
	done < $1
}

# foor loop to look up .sh files
echo "all the .sh files in the current directory:"
for i in ./*sh; do
	echo $i
done

# positive and negative number
if (( first_arg > 0 )); then
	echo "Positive number"
else
	echo "Non-positive number"
fi

my_readfile_func $file_path
