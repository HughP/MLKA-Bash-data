#!/bin/bash

##############################
#Set up the character counts for corpora. This includes James and Wikipedia data. Actually, James and Wikipedia data are both classes of data and also fit into a super-class. If we want to think about them in those terms.
##############################

#This should be for all corpora not just james
echo
echo "INFO: Processing All Corpora."
echo "      Doing an initial character count on all corpora."
echo "      This is the first step of many..."
echo

if [ -d "$DIR_INITIAL_STATS_TITLE" ]; then
    # Control will enter here if DIRECTORY exist.
    rm -R -f "$DIR_INITIAL_STATS_TITLE"
    mkdir "$DIR_INITIAL_STATS_TITLE"
else
    # Control will enter here if DIRECTORY does NOT exist.
    mkdir "$DIR_INITIAL_STATS_TITLE"
fi

for i in $(cat $JAMES_LIST_FILE); do
    for flag in -c -d -u -m "-d -m"; do
        UnicodeCCount $flag $DIR_JAMES_DATA/$i > $DIR_INITIAL_STATS_TITLE/$INITIAL_STATS_TITLE${flag/ /}-${i/ /}
    done
done

##############################
##############################