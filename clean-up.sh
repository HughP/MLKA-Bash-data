#!/bin/bash
#########################
# Script Name: awesome-script.bash
# Authors: Hugh Paterson III <email here>
#          Jonathan Duff <jonathan@dufffamily.org>
# Version: 0.02
# License: GPL
#Purpose: To quickly remove content produced by awesome bash script.


SCRIPT_NAME="awesome-script.bash"
AUTHORS="Hugh Paterson III, Jonathan Duff"
VERSION="0.02"
License="GPL"

##############################
# Variables Unique to Clean-up
##############################

NEW_DATA=Dependencies/Data/MLKA-Test-Data

##############################
##############################

##############################
# Project Wide Variables
##############################

# All variables which are used by multible portions of the script are stated in a script called 'global-vars.bash'. The intent is that each sub-portion can call and include 'global-vars.bash'.

# Grab global variables:
source Dependencies/global-vars.bash

##############################
##############################


# Files to clean up.
rm -f typographically-correct-corpora.txt

################################
## Cleaning Up Standard Files ##
################################

# Put standard files in the array to remove them. The variables need to be enclosed in double quotes.

clean_file_array=( "$JAMES_LIST_FILE" "$JAMES_LIST_FILE_FP" "$WIKI_LIST_FILE" "$WIKI_LIST_FILE_FP" "$CORPUS_LIST_FILE" "$KEYBOARD_LIST_FILE" "$KEYBOARD_LIST_FILE_FP" "$LANGUAGE_LIST_FILE" "$CORPORA_LANGUAGES" "$JAMES_LANGUAGES" "$WIKI_LANGUAGES" "$KEYBOARDS_LANGUAGES" )

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

clean_folder_array=("$DIR_INITIAL_STATS_TITLE" "$DIR_SECOND_STATS_TITLE" "$DIR_THIRD_STATS_TITLE" "$DIR_TYPOGRAHICAL_CORRECT_DATA" "$DIR_CLEAN_AND_POSSIBLE_DATA" "$DIR_TEC_FILES" )

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


#Other folders like "$DIR_WIKI_DATA" "$DIR_JAMES_DATA" might need some special attention.

echo
echo "We cleaned up all the files and folders. Now we are trying to coping over new test data."
echo

################################
####### Copy in New Data #######
################################

# We need clean coppies of test dumps from wikipedia. This chunk pulls them in from the MLKA-Data repo


if [ -d $NEW_DATA ];then
	echo "		Removing '.txt' data from the data source folder."
	printf "STATUS: "
	for i in $(find "$NEW_DATA" -name '*.txt' -exec basename \{} \; );do
			rm "$DIR_JAMES_DATA"/$i
			printf "+"
	done
	echo

	echo "		Removing '.bz2' data from the data source folder."
	printf "STATUS: "
	for i in $(find "$NEW_DATA"  -name '*.bz2' -exec basename \{} \; );do
			rm "$DIR_WIKI_DATA"/$i
			printf "+"
	done
	echo

	else
	echo "      You should get the test data. It is included as a sub-module in this repo. However you can also get it independently via the following command:"
	echo "      git clone https://github.com/HughP/MLKA-Test-Data.git"
fi

# This check and copy was blocked out on 11 June 2015 because the Repo was added as a sub-module and files should not need to be coppied in.
if [ -d $NEW_DATA ];then
	echo "		Added default '.txt' data back to the main folder."
	printf "STATUS: "
	for i in $(find "$NEW_DATA"  -name '*.txt');do
			cp $i .
			printf "+"
	done
	echo


	echo "		Added default '.bz2' data back to the main folder."
	printf "STATUS: "
	for i in $(find "$NEW_DATA"  -name '*.bz2');do
			cp $i .
			printf "+"
	done
	echo

	else
	echo "      You should get the test data. It is included as a sub-module in this repo. However you can also get it independently via the following command:"
	echo "      git clone https://github.com/HughP/MLKA-Test-Data.git"
fi

# We need to make sure that we have the file types needed to search for keyboards. This pulls the file in from the repo. If the repo does not exist it clones it from github.

if [ -f $KEYBOARD_FILE_TYPES  ];then
	echo
	echo "		Glad to see you have the 'Keyboard-File-Types' file."
	echo
		else
	cd Dependencies/Settings/
	git clone https://github.com/HughP/Keyboard-File-Types.git
	echo "      Well it looks like you needed a data file. No worries we cloned it from https://github.com/HughP/Keyboard-File-Types.git and it is parallel to this folder."
	echo
	echo
fi

# Remove Temp directory
rm -rf Temp-Files


################################
#### End of Copy in New Data ###
################################

echo
echo "That's all I know about... the rest is up to you..."
echo

exit 0
