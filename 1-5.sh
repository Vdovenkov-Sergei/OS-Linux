#!/bin/bash
if [[( -n "$1") && ("$#" -eq 1)]]
then
	# Check documentation
	if [ "$1" == "-h" ]
	then
		echo "> One parameter(flag) is required"
		echo "> Try flag '-h' to check documentation"
		echo "> Try [x] as parameter to generate 'x' examples of 'user_i_passwd'"
		echo "> Note, 'x' must be integer"
		exit 0
	# Use regular expression to check parameter
	# Main code of script
	elif [[ "$1" =~ ^[0-9]+$ ]]
	then
		# Check for file existence
		if [ -e "./users.csv" ]
		then
			# Check  for writing to file
			if [ -w "./users.csv" ]
			then
				# Clean file
				echo -n > users.csv
			else
				echo "> Fail: no write access to 'users.csv'"
				exit 1
			fi
		# Create new file users.csv
		else
			touch users.csv
		fi
		# Input prefix of user using stdin
		read prefix
		for (( i = 0; i < $1; i++ ))
		do
			# Generate random password and put it in variable
			password=$(pwgen -1 -s -y)
			# Write information in file
			echo -n "$prefix" >> users.csv
			echo "_$[ $i + 1 ],$password" >> users.csv
		done
		# Script executed successfully
		echo "All information added to fail 'users.csv'"
		exit  0
	else
		echo "> Parameter isn't a non-negative integer number"
		exit 1
	fi
elif [ -z "$1" ]
then
	echo "> Fail: 1 required parameter missed; try flag '-h'"
	exit 1
else
	# Calculate the number of extra parameters
	# $# is the total number of parameters
	overflow=$(($# - 1))
	echo "> Fail: $overflow extra parameters passed; try flag '-h'"
	exit 1
fi
