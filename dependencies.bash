#!/bin/bash

x=$(csvfix read_dsv -smq -s "\t" -f 1 dependencies.data)
y=$(csvfix read_dsv -smq -s "\t" -f 2 dependencies.data)
z=$(csvfix read_dsv -smq -s "\t" -f 3 dependencies.data)

for i in ${x[*]}; do
    echo "X=" ${x[$i]}
    echo "Y=" ${y[$i]}
    echo "Z=" ${z[$i]}
done


#    if type $x &>/dev/null; then
#        echo
#        echo $y
#    else
#        echo $z
#        exit 1
#    fi

#done
