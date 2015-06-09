#!/bin/bash

#-smq

column1=( $(csvfix read_dsv -csv -s '|' -f 1 dependencies.data) )
column2=( $(csvfix read_dsv -csv -s '|' -f 2 dependencies.data) )
column3=( $(csvfix read_dsv -csv -s '|' -f 3 dependencies.data) )

for (( i=0; i < ${#column1[*]}; i++ )); do
            echo "1=" ${column1[$i]}
            echo "2=" ${column2[$i]}
            echo "3=" ${column3[$i]}
            echo
done
