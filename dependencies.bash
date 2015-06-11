#!/bin/bash

IFS=$'\n'
for i in dependencies.data; do
x=($(csvfix read_dsv -csv -smq -s '|' -f 1 dependencies.data ))
y=($(csvfix read_dsv -csv -smq -s '|' -f 2 dependencies.data ))
z=($(csvfix read_dsv -csv -smq -s '|' -f 3 dependencies.data ))

unset $IFS
	for (( i=0; i < ${#x[@]}; i++ )); do
	    if type ${x} &>/dev/null; then
	        echo
	        echo ${y[$i]}
	        echo
	    else
	    	echo
	        echo ${z[$i]}
	        echo
	        exit 1
	    fi
	done
done