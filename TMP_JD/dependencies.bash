#!/bin/bash

#-smq

column1=($(csvfix read_dsv -csv -s '|' -f 1 dependencies.data | tr '\n' ' '))
column2=($(csvfix read_dsv -csv -s '|' -f 2 dependencies.data | tr '\n' ' '))
column3=($(csvfix read_dsv -csv -s '|' -f 3 dependencies.data | tr '\n' ' '))

for (( i=0; i < ${#column1[*]}; i++ )); do
            echo "row=" $i
            echo "column1=" ${column1[$i]}
            echo "column2=" ${column2[$i]}
            echo "column3=" ${column3[$i]}
            echo
done

echo
echo
echo

myarray=("this has spaces" "this has spaces also")

for (( i=0; i < ${#myarray[*]}; i++)); do
    echo "item=" $i
    echo "myarray=" ${myarray[$i]}
done
