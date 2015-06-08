#!/bin/bash
#########################
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
DIR_THIRD_STATS_TITLE=Third-Stats

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
CORPUS_LIST_FILE=Corpus-list.txt #This file is a list of all corpora (James + Wikipedia # + other)
KEYBOARD_LIST_FILE_FP=Full-Path-Keyboard-list.txt # This file lists all the keyboard files with their full path relative to the home directory. Included are .kmx, .keylayout, .kmn, (and perhaps more) other blocks which reference this file need to take into account that there are multiple file types in this file.
KEYBOARD_LIST_FILE=Keyboard-list.txt #This file lists all the keyboard files. Included are .kmx, .keylayout, .kmn, (and perhaps more) other blocks which reference this file need to take into account that there are multiple file types in this file.

# List of all languages used in the data processing
LANGUAGE_LIST_FILE=Language_ID.txt # This file is for all languages, not just one of the three arrays.
CORPORA_LANGUAGES=Corpora_Languages.txt
JAMES_LANGUAGES=James_Languages.txt
WIKI_LANGUAGES=Wikipedia_Languages.txt
OTHER_CORPORA_LANGUAGES=
KEYBOARDS_LANGUAGES=Keyboard_Languages.txt

CMD_UNICODECCOUNT=UnicodeCCount

KEYBOARD_FILE_TYPES=../Keyboard-File-Types/Keyboard-File-Types.txt #This file is externally maintained and imported to help this application determine if there are keyboard file types which need to be searched for.

DATA_TYPE= # This should be an array made dynamically from various atribues of the data types. We have Keyboards, and each type of corpora. This array should motivate the tables in the display output.
CORPUS_TYPE= # This needs to be dynamically determined and then added to an array. Should be like Data_type but only an array.

HOME_FOLDER=`pwd`

# Files to clean up. 
rm -f typographically-correct-corpora.txt

################################
## Cleaning Up Standard Files ##
################################

# Put standard files in the array to remove them. The variables need to be enclosed in double quotes.

clean_file_array=( "$JAMES_LIST_FILE" "$WIKI_LIST_FILE" "$CORPUS_LIST_FILE" "$KEYBOARD_LIST_FILE" "$KEYBOARD_LIST_FILE_FP" "$LANGUAGE_LIST_FILE" "$CORPORA_LANGUAGES" "$JAMES_LANGUAGES" "$WIKI_LANGUAGES" "$KEYBOARDS_LANGUAGES" )

FILE_COUNT=0
for i in ${clean_file_array[@]};do
	if [ -f ${i} ]; then
 	   # Delete the file
 	   rm -f ${i}
 	   (( FILE_COUNT = FILE_COUNT +1 ))
 	   echo -e "INFO:\t Cleaned ${i}.\t It was file # $FILE_COUNT of ${#clean_file_array[@]}."

	else
		echo "WARNING: We actually couldn't find the file ${i}".
 	fi
done

################################
#### End of Standard Files #####
################################

################################
# Cleaning Up Standard Folders #
################################

# Put standard folders in the array to remove them. The variables need to be enclosed in double quotes.

clean_folder_array=("$DIR_INITIAL_STATS_TITLE" "$DIR_SECOND_STATS_TITLE" "$DIR_THIRD_STATS_TITLE" "$DIR_TYPOGRAHICAL_CORRECT_DATA" "$DIR_CLEAN_AND_POSSIBLE_DATA" "$DIR_TEC_FILES" "$DIR_WIKI_DATA" "$DIR_JAMES_DATA" )

FOLDER_COUNT=0
for i in ${clean_folder_array[@]};do
	if [ -d ${i} ]; then
 	   # Delete the folder
 	   rm -Rf ${i}
 	   (( FOLDER_COUNT = FOLDER_COUNT +1 ))
 	   echo -e "INFO:\t Cleaned ${i}.\t It was folder # $FOLDER_COUNT of ${#clean_folder_array[@]}."

	else
		echo "WARNING: We actually couldn't find the folder ${i}".
 	fi
done

################################
### End of Standard Folders ####
################################
	
echo
echo "We cleaned up all the files and folders. Now we are trying to coping over new test data."
echo

################################
####### Copy in New Data #######
################################

# We need clean coppies of test dumps from wikipedia. This chunk pulls them in from the MLKA-Data repo

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

# We need to make sure that we have the file types needed to search for keyboards. This pulls the file in from the repo. If the repo does not exist it clones it from github.

if [ -f $KEYBOARD_FILE_TYPES  ];then
	echo
	echo "		Glad to see you have the keyboard file types file."	
	echo
		else
	cd ../
	git clone https://github.com/HughP/Keyboard-File-Types.git 	
	echo "      Well it looks like you needed a data file. No worries we cloned it from https://github.com/HughP/Keyboard-File-Types.git and it is parallel to this folder."
	echo
	echo
fi		

################################
#### End of Copy in New Data ###
################################

echo
echo "That's all I know about... the rest is up to you..."
echo

exit 0