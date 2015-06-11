#!/bin/bash



for i in dependencies.data; do
x=($(csvfix read_dsv -csv -smq -s '|' -f 1 dependencies.data | ))
y=($(csvfix read_dsv -csv -smq -s '|' -f 2 dependencies.data | ))
z=($(csvfix read_dsv -csv -smq -s '|' -f 3 dependencies.data | ))

 for i in ${x[@]}; do
    if type ${x} &>/dev/null; then
        echo
        printf ${y[*]}
        echo
    else
    	echo
        printf "${z[*]}"
        echo
        exit 1
    fi
done
done

#done
