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
# Variables Unique to Clean-up
##############################

NEW_DATA=../MLKA-Data

##############################
# Variables for Directories
##############################

# Variables for UnicodeCCount output
DIR_INITIAL_STATS_TITLE=Initial-Stats
DIR_SECOND_STATS_TITLE=Second-Stats

# Variables for Corpora versions
DIR_JAMES_DATA=James-Data # This variable needs to be updated in the clean-up script. I wish there was a way to refernce these variables from that script.
DIR_WIKI_DATA=Wiki-Data
DIR_TYPOGRAHICAL_CORRECT_DATA=Typographically-Clean-Corpora
DIR_CLEAN_AND_POSSIBLE_DATA=Typo-Clean-And-Possible-To-Type-Corpora
DIR_TEC_FILES=TECkit-tec-Files

##############################
# Variables for File Names Prefixes
##############################

INITIAL_STATS_TITLE=First_Stats
SECOND_STATS_TITLE=Second_Stats
THIRD_STATS_TITLE=Third_Stats

INS_TRANSPOSED=First_Stats_Transposed # Used for transposed CSV files

##############################
# Variables for Other Things
##############################

# List of the file names of the Data files (corpora and keyboards).

JAMES_LIST_FILE=James-list.txt #This is a file list of the James Corpus files.
WIKI_LIST_FILE=Wikipedia-list.txt #This file contains the file names of the Wikipedia data dumps. 
CORPUS_LIST_FILE=Corpus-list.txt #This file is currently unused. It is supposed to be a list of all corproa (James + Wikipedia)
KEYBOARD_LIST_FILE=Keyboard-list.txt #This file lists all the keyboard files. Included are .kmx, .keylayout, .kmn, (and perahps more) other blocks which reference this file need to take into account that there are multible file types in this file.

# List of all languages used in the data processing
LANGAUGE_LIST_FILE=Language_ID.txt # This file is for all languages, not just one of the three arrays.
CORPRA_LANGUAGES=
JAMES_LANGUAGES=
WIKI_LANGUAGES=
OTHER_CORPORA_LANGUAGES=
KEYBOARDS_LANGUAGES=

CMD_UNICODECCOUNT=UnicodeCCount

KEYBOARD_FILE_TYPES=../Keyboard-File-Types/Keyboard-File-Types.txt #This file is externally maintained and imported to help this application determine if there are keyboard file types which need to be searched for.

DATA_TYPE= # This should be an array made dynamically from various atribues of the data types. We have Keyboards, and each type of corpora. This array should motivate the tables in the display output.
CORPUS_TYPE= # This needs to be dynamically determined and then added to an array. Should be like Data_type but only an array.

HOME_FOLDER=`pwd`

rm -f typographically-correct-corpora.txt

if [ -f $WIKI_LIST_FILE ]; then
    # Delete the file
    rm -f $WIKI_LIST_FILE
    echo "INFO: Replacting previously generated files!"
fi

if [ -f $JAMES_LIST_FILE ]; then
    # Delete the file
    rm -f $JAMES_LIST_FILE
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

if [ -f $KEYBOARD_FILE_TYPES  ];then
	
	echo "		Glad to see you have the keyboard file types file."	
		else
	cd ../
	git clone https://github.com/HughP/Keyboard-File-Types.git 	
	echo "      Well it looks like you needed a data file. No worries we cloned it from https://github.com/HughP/Keyboard-File-Types.git and it is parallel to this folder."
	echo
	echo
fi		

echo "That's all I know about... the rest is up to you..."
echo

exit 0