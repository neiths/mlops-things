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

my_readfile_func $file_path

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

# don't use [[ 10 > 9 ]], but use
# (( 10 > 9 )) for numerical operations

if [[ 10 > 9 ]]; then
	echo "10 > 9 is true"
else
	echo "10 > 9 is false"
fi

# replace string
my_path="/home/thien/home/mnt/linux"

echo "replaced the first 'home': ${my_path/home/house}"

echo "replaced all the element 'home': ${my_path//home/house}"

echo "split my_path by / into an array:"

IFS="/" read -ra my_array <<< $my_path && echo ${my_array[@]} && echo "last element: ${my_array[-1]}"


echo "delete everything up to the last slash: ${my_path##*/}"

echo "lower case: ${my_path,,}; Upper case: ${my_path^^}"

my_array=(10 2 300)

echo "all the elements: ${my_array[@]}"

echo "First element: ${my_array[0]}"

echo "Last element: ${my_array[-1]}"

echo "Number of elements: ${#my_array[@]}"
