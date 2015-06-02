#!/bin/bash
# Author: Jonathan Duff <jonathan@dufffamily.org>
# Version: 1.0
# Usage:
#		Matches all *wiki*.bx2 files
#		to all iso-639-3*.tab files combined.
#		Then creates corisponding directory
#		in Wiki-Data.

# Sweep up
if [ -f iso-639-3.data ]; then
    rm iso-639-3.data
fi

THE_COUNT=0
for I in $(ls -A1r *.tab); do
    (( THE_COUNT = THE_COUNT + 1 ))
    if (( $THE_COUNT > 1)) || (( $THE_COUNT == 0)); then
        echo "What are you trying to do? Warning you are going to corrupt your data!"
        exit
    fi
done

csvfix read_dsv -f 1,4,7 -s '\t' iso-639-3*.tab | csvfix remove -f 2 -l 0 > iso-639-3.data

if [ -f iso-639-3.data ]; then
    cd Wiki-Data

    # For every *wiki*.bz2 file do:
    for FILE in $(find * -maxdepth 0 -iname '*wiki*.bz2'); do
        for DATA in $(cat ../iso-639-3.data); do
            if [[ ${FILE:0:2} == ${DATA:7:2} ]]; then
                if [ -d ${DATA:1:3} ]; then
                    echo "INFO: Wiki-Data/${DATA:1:3} exists"
                else
                    mkdir ${DATA:1:3}
                    mv $FILE ${DATA:1:3}
                    bzip2 -d ${DATA:1:3}/$FILE
                fi
            fi
        done
    done

    cd .. # NOTE: need to change to $HOME_FOLDER
fi

# Sweep up
if [ -f iso-639-3.data ]; then
    rm iso-639-3.data
fi
