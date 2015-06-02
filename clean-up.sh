#########################
#!/bin/bash
# Script Name: awesome-script.bash
# Authors: Hugh Paterson III <email here>
#          Jonathan Duff <jonathan@dufffamily.org>
# Version: 0.02
# License: GPL
####To quickly removecontent produced by awesome bash script.

 
SCRIPT_NAME="awesome-script.bash"
AUTHORS="Hugh Paterson III, Jonathan Duff"
VERSION="0.02"
License="GPL"

##############################
# Variables for Directories
##############################

# Variables for UnicodeCCount output
DIR_INITIAL_STATS_TITLE=Initial-Stats
DIR_SECOND_STATS_TITLE=Second-Stats

# Variables for Corpora versions
DIR_JAMES_DATA=James-Data #this variable needs to be updated in the clean-up script. I wish there was a way to refernce these variables from that script.
DIR_WIKI_DATA=Wiki-Data
DIR_TYPOGRAHICAL_CORRECT_DATA=Typographically-Clean-Corproa
DIR_CLEAN_AND_POSSIBLE_DATA=Typo-Clean-And-Possible-To-Type-Corpora
DIR_TEC_FILES=TECkit-tec-Files
NEW_DATA=../MLKA-Data

##############################
# Variables for File Names Prefixes
##############################

INITIAL_STATS_TITLE=First_Stats
SECOND_STATS_TITLE=Second_Stats
THIRD_STATS_TITLE=Third_Stats

##############################
# Variables for Other Things
##############################

JAMES_LIST_FILE=James-list.txt 
WIKI_LIST_FILE=Wikipedia-list.txt
CORPUS_LIST_FILE=Corpus-list.txt #This file is currently only the James corpus, but after the wikidata is available this file should a combined list of all corpora. (I think - hp3)
LANGAUGE_LIST_FILE=Language_ID.txt

CMD_UNICODECCOUNT=UnicodeCCount


CORPUS_TYPE=bla #This needs to be dynamically determined and then added to an array.
LANGUAGE_CODE=blabla #This is same as Language_ID
INTIAL_COUNT=blablabla #Not sure what this is or why it is needed.
HOME_FOLDER=`pwd`

rm -f typographically-correct-corpora.txt

if [ -f $WIKI_LIST_FILE ]; then
    # Delete the file
    rm -f $WIKI_LIST_FILE
    echo "INFO: Replacting previously generated files!"
fi

if [ -f $CORPUS_LIST_FILE ]; then
    # Delete the file
    rm -f $CORPUS_LIST_FILE
    echo "      Clean! Clean!"
fi

if [ -f $LANGAUGE_LIST_FILE ]; then
    # Delete the file
    rm -f $LANGAUGE_LIST_FILE
    echo "      Clean! Clean! Clean!"
fi

# Folders to clean up.
if [ -d $DIR_INITIAL_STATS_TITLE ]; then
    # Delete the folder
    rm -Rf $DIR_INITIAL_STATS_TITLE
    echo "      Clean! Clean! Clean! Cleaned the $DIR_INITIAL_STATS_TITLE folder"
fi

# Folders to clean up.
if [ -d $DIR_SECOND_STATS_TITLE ]; then
    # Delete the folder
    rm -Rf $DIR_SECOND_STATS_TITLE
    echo "      Clean! Clean! Clean! Cleaned the $DIR_SECOND_STATS_TITLE folder"
fi

if [ -d $DIR_TYPOGRAHICAL_CORRECT_DATA ]; then
    # Delete the folder
    rm -Rf $DIR_TYPOGRAHICAL_CORRECT_DATA
    echo "      Clean! Clean! Clean! Cleaned the $DIR_TYPOGRAHICAL_CORRECT_DATA folder"
fi

if [ -d $DIR_TEC_FILES ]; then
    # Delete the folder
    rm -Rf $DIR_TEC_FILES
    echo "      Clean! Clean! Clean! Cleaned the $DIR_TEC_FILES folder"
fi


if [ -d $DIR_WIKI_DATA ];then
	rm -rf $DIR_WIKI_DATA
	echo "		Got rid of all that processed Wikipedia data."
fi	

if [ -d $DIR_JAMES_DATA ];then
	rm -rf $DIR_JAMES_DATA
	echo "		Got rid of all that processed James data."

fi	

echo "We cleaned up all the files Now we are trying to coping over new test data."

if [ -d $NEW_DATA ];then
	for i in $(find "$NEW_DATA"  -name '*.txt');do
			cp $i .
			echo "		Added default '.txt' data back to the folder."
	done		
	for i in $(find "$NEW_DATA"  -name '*.bz2');do
			cp $i .
			echo "		Added default '.bz2' data back to the folder."
	done
	else
	echo "      You should get the test data. You can do this by using the following command in the parent of this repository ($ cd ../)."
	echo "      git clone https://github.com/HughP/MLKA-Data.git"
fi		

echo "That's all I know about... the rest is up to you..."