#!/bin/bash
# Author: Jonathan Duff <jonathan@dufffamily.org>
# Version: 1.0
# Usage:
#		Matches all *wiki*.bx2 files
#		to all iso-639-3*.tab files combined.
#		Then creates corisponding directory
#		in Wiki-Data.

# Sweep up
if [ -f tmp_buffer.data ]; then
    rm tmp_buffer.data
fi
if [ -f tmp_buffer_csv_col14.data ]; then
    rm tmp_buffer_csv_col14.data
fi
if [ -f combined-iso-639-3.data ]; then
    rm combined-iso-639-3.data
fi

# Generate a combined and complete master TAB file:
for I in $(find * -maxdepth 0 -iname 'iso-639-3*.tab'); do
	cat $I >> tmp_buffer.data
	echo >> tmp_buffer.data
done

# Create a new TAB with the only needed columbs:
csvfix read_dsv -s '\t' tmp_buffer.data | csvfix order -f 1,4 > tmp_buffer_csv_col14.data

if [ -f tmp_buffer_csv_col14.data ]; then
    for Y in $(cat tmp_buffer_csv_col14.data); do
        if [[ ${Y:7:1} != "\"" ]]; then
            echo $Y >> combined-iso-639-3.data
            #echo >> ready.data
        fi
    done

    cd Wiki-Data

    # For every *wiki*.bz2 file do:
    for FILE in $(find * -maxdepth 0 -iname '*wiki*.bz2'); do
        for DATA in $(cat ../combined-iso-639-3.data); do
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

    cd ..
fi

# Sweep up
if [ -f tmp_buffer.data ]; then
    rm tmp_buffer.data
fi
if [ -f tmp_buffer_csv_col14.data ]; then
    rm tmp_buffer_csv_col14.data
fi
