#!/bin/bash


#x:: thing to type
#y:: success message
#z:: Failure message

###################
# Commandline tools used as dependencies
###################

IFS=$'\n'
for i in dependencies.data; do
x=($(csvfix read_dsv -csv -smq -s '|' -f 1 dependencies_commandline.data ))
y=($(csvfix read_dsv -csv -smq -s '|' -f 2 dependencies_commandline.data ))
z=($(csvfix read_dsv -csv -smq -s '|' -f 3 dependencies_commandline.data ))

unset $IFS
	for (( i=0; i < ${#x[@]}; i++ )); do
	#The above code lets me put in the sequential number of the dependency check. So if I wanted to give each check an number I could.
	    if type ${x} &>/dev/null; then
	        echo -e $(eval "echo ${y[$i]}")
	    else
	    	echo
	        echo -e $(eval "echo ${z[$i]}")
	        echo
	        exit 1
	    fi
	done
done

###################
# Python modules used as dependencies
###################

IFS=$'\n'
for i in dependencies.data; do
x=($(csvfix read_dsv -csv -smq -s '|' -f 1 dependencies_py.data ))
y=($(csvfix read_dsv -csv -smq -s '|' -f 2 dependencies_py.data ))
z=($(csvfix read_dsv -csv -smq -s '|' -f 3 dependencies_py.data ))

unset $IFS
	for (( i=0; i < ${#x[@]}; i++ )); do
	#The above code lets me put in the sequential number of the dependency check. So if I wanted to give each check an number I could.
	    if python -c ${x} &>/dev/null; then
	        echo -e $(eval "echo ${y[$i]}")
	    else
	    	echo
	        echo -e $(eval "echo ${z[$i]}")
	        echo
	        exit 1
	    fi
	done
done
