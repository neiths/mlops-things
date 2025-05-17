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
