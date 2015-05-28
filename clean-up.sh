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

CMD_UNICODECCOUNT=UnicodeCCount

DIR_INITIAL_STATS_TITLE=Initial-Stats
DIR_SECOND_STATS_TITLE=Second-Stats
DIR_JAMES_DATA=James
DIR_TYPOGRAHICAL_CORRECT_DATA=Typographically-Clean-Corproa
DIR_WIKI_DATA=Wiki-Data

INITIAL_STATS_TITLE=First_Stats
SECOND_STATS_TITLE=Second_Stats
THIRD_STATS_TITLE=Third_Stats_

WIKI_LIST_FILE=Wikipedia-list.txt
CORPUS_LIST_FILE=Corpus-list.txt
LANGAUGE_LIST_FILE=Language_ID.txt

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

##Need to move some files before deleting the folder

if [ -d $DIR_WIKI_DATA ];then
	mv $DIR_WIKI_DATA/* .
	rm -rf $DIR_WIKI_DATA
fi	

if [ -d $DIR_JAMES_DATA ];then
	mv $DIR_JAMES_DATA/* .
	rm -rf $DIR_JAMES_DATA
fi		

echo "That's all I know about... the rest is up to you..."