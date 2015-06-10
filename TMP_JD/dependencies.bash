#!/bin/bash

# -csv -smq
IFS=$'\n'
column1=($(csvfix read_dsv -csv -smq -s '|' -f 1 dependencies.data))
column2=($(csvfix read_dsv -csv -smq -s '|' -f 2 dependencies.data))
column3=($(csvfix read_dsv -csv -smq -s '|' -f 3 dependencies.data))
unset $IFS

for (( i=0; i < ${#column1[@]}; i++ )); do
            echo "row=" $i
            echo "column1=" ${column1[$i]}
            echo "column2=" ${column2[$i]}
            echo "column3=" ${column3[$i]}
            echo
done
