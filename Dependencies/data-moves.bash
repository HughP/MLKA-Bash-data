#!/bin/bash

echo
echo "INFO: We're looking for data (Corpora, Keyboards and Stats) and moving it to the correct locations."

# Wiki

##############################
#Look for Wikipedia data.
##############################

# Does the Wiki-Data folder exists?
# Yes: print exists; inform the user we did not write over the folder and the data in it. Awesomescript does not set this folder to empty when it runs.
# No: make directory; this is important on the first run of the script.
if [ -d "$DIR_WIKI_DATA" ]; then
    echo "INFO: $DIR_WIKI_DATA folder exists."
    echo "      If we find Wikidumps outside of this folder we will move it to the $DIR_WIKI_DATA folder."
else
    echo "INFO: Creating $DIR_WIKI_DATA folder"
    echo "      If we find Wikidumps we will move it $DIR_WIKI_DATA folder."
    mkdir "$DIR_WIKI_DATA"
fi

# Search for compressed wiki dumps

echo
echo "INFO: Looking for corpora from Wikipedia data dumps."
echo "      If we find anything we'll let you know."
echo

# Find all wikipedia dumps in all folders below the home folder (except the test data folder) and move Wikipedia dumps into wikidata folder for processing.
WIKI_DATA_FILE_COUNT=0
if [ -d "$DIR_WIKI_DATA" ]; then
    printf "STATUS: "
    for i in $(find * -name '*wiki*.bz2' -not -path '*/MLKA-Test-Data/*'); do
        SafeMove "$i" "$DIR_WIKI_DATA/$i"
        # $? is the return value from previous command above
        case "$?" in
            0) printf "+"
                (( WIKI_DATA_FILE_COUNT = WIKI_DATA_FILE_COUNT + 1 ))
                ;;
            1) printf "!"
                ;;
            *) printf "*"
        esac
    done
    echo
    echo "INFO: Moved " $WIKI_DATA_FILE_COUNT " Wikidata dumps into the $DIR_WIKI_DATA folder."
#Is the output on to theterminal on the above line correct? there are two sets of quote marks.
fi


### (MSG-004) HUGH: For more information please see:
###                 https://github.com/HughP/Bash-data-mlka/issues/17
###

# List all Wikipedia dumps and store
# results into the file $WIKI_LIST_FILE (Wikipedia-list.txt)
# We will use the >> rather than the > notation here because the file already exists. When we create new files we should use the > notation. However, in this case the file has aready been created by the `touch` command in the script initialization.

find * -name '*wiki*.bz2' -not -path '*/MLKA-Test-Data/*' >> $WIKI_LIST_FILE

if [ "$(cat $WIKI_LIST_FILE | wc -l)" -eq "0" ]; then
    # No wikipedia dumps were found.
    echo
    echo "INFO:  We didn't find any Wikipedia data. We're moving on."
    echo
else
    # Some uncompressed Wikipedia dumps exist.
    echo
    echo "INFO: We think there are: $(cat $WIKI_LIST_FILE | wc -l) dumps to be processed."
    echo

    #There is a bug here in that the above line has a long space in it when returned to the command prompt.
fi

# James

##############################
#Look for James data.
##############################

# Does the James folder exists?
# Yes: print exists; inform the user we did not write over the folder and the data in it. Awesomescript does not set this folder to empty when it runs.
# No: make directory; this is important on the first run of the script.
if [ -d "$DIR_JAMES_DATA" ]; then
    echo "INFO: $DIR_JAMES_DATA folder exists"
    echo
else
    echo "INFO: Creating $DIR_JAMES_DATA folder"
    echo
    mkdir $DIR_JAMES_DATA
fi

### (MSG-005) HUGH: You had mentioned you would like to have an indicator for each file moved.
###
###

# Does the James folder exist?
# Yes: then move all files in HOME_FOLDER *james*.txt to it.
# NO: nothing.
JAMES_DATA_FILE_COUNT=0
if [ -d "$DIR_JAMES_DATA" ]; then
    for i in $(find * -maxdepth 0 -iname '*ori*james*.txt'); do
	# Added a check so it doesn't clobber files:
        if [ ! -f "$DIR_JAMES_DATA/$i" ]; then
            # safe to move the -ori-corpus-james*.txt files into James-Data:
            mv "$i" "$DIR_JAMES_DATA"
            (( JAMES_DATA_FILE_COUNT = JAMES_DATA_FILE_COUNT + 1 ))
            # http://www.tldp.org/LDP/abs/html/dblparens.html
        fi
    done
# Report what was found and moved.
    echo "INFO: Moved " $JAMES_DATA_FILE_COUNT " James texts into the $DIR_JAMES_DATA folder."
	echo
fi

### (MSG-010) HUGH: This is a little misleading by putting an append. The file is deleted
###                 above if it exists every time the script runs. We should change >> to >
###                 So it's clear what we're doing at this point in the code.
###
###

# Record to file what was fount and moved.
cd $DIR_JAMES_DATA
find * -maxdepth 0 -iname '*ori*james*.txt' >> ../$JAMES_LIST_FILE
cd ../

# Other

##############################
#Look for Other Corpora data. - Not yet implemented. See notes for version 0.9.8 in the ReadMe.md
##############################

cat $WIKI_LIST_FILE >> $CORPUS_LIST_FILE
cat $JAMES_LIST_FILE >> $CORPUS_LIST_FILE
# cat $OTHER_LIST_FILE >> $CORPUS_LIST_FILE # version 0.9.8
##############################
##############################
###End of Corpora Data Check##
##############################

##############################
##############################
####### Action Point #########
##############################

##############################
#Parse Keyboard File data, this is another form of data so it should be parsed with the data.
##############################
#.keylayout files need to be parsed with XML (DTD here: https://developer.apple.com/library/mac/technotes/tn2056/_index.html ; Example here: https://github.com/palmerc/Ukrainian-Russian/blob/master/Ukrainian%20(Russian).keylayout) for the characters which are contained in them. There might be an XML/bash script processing tool, or there might be a Python XML processing tool for this.
#.kmn files need to be parsed for the characters which they can produced. To do this I should look at the Palaos-python tools.
#Windows keyboards are unacconted for. Adobe did create a script to convert .keylayout files to MSKLC files: https://github.com/adobe-type-tools/keyboard-layouts. Perhaps someone created a script for going the other way? If so, such a script could be investigated with the Me\'phaa keyboard layout. There is a perl script for reading MSKLC here: https://github.com/amire80/msklc_reader. There are also several MSKLC files here: https://github.com/andjc/msklc
#
#All the characters from the keyboard files, need to be compared with the characters which are used in the various corpora in the target languages.
#A report needs to be generated to show the characters used in the corpora, and the characters which are possible via the keyboards.
#Characters which are not in the keyboard layouts, need to be purged from the corpora. The presence of characters in corpora which are not on standard keyboards shows the percentage of extra-keyboard effort in each language. This is a percentage of the writing task which does require a special solution. Special solutions should be expected in all languages. But what is the standard amount by which people should expect to be required to use these special solutions?
#
#The techincal task for keyboard layout file processing, is the following:
#All the possible characters producable by the keyboard layout need to be listed. They should be listed in a CSV file with the format ' U+xxxx, glyph ' for each keyboard file. This CSV represents the capable output of the keyboard file. Then these files can be compared with the CSV output of the Texts which have gone through the UnicodeCCount Process.
##############################
##############################

##########################
# Detect which keyboard layout files exist to be considered
##########################

# Find Keyboard files in both root and in DIR_KEYBOARD_DATA
#Should example keyboards be set in another repo? and then that repo data be imported?

# Discover what kind of file endings constitute a keyboard file.

KBD_FILE_TYP_str=$(csvfix read_dsv -f 1 -s '\t' $KEYBOARD_FILE_TYPES | sed 's/\"//g' | sed 's/\.//g')
KBD_FILE_TYP=${KBD_FILE_TYP_str//'\t'/'\n'}

for i in $KBD_FILE_TYP; do
 	find * -iname \*."${i}" | sort -t. -k 2,2 -k 1,1 >> $KEYBOARD_LIST_FILE_FP
done

# Then make a list of just the file names of the keyboards
cat $KEYBOARD_LIST_FILE_FP | rev |cut -d '/' -f1 | rev >> $KEYBOARD_LIST_FILE

##########################
##########################

##########################
# Count keyboard layout files and list per language

#How to detect the ISO 639-3 code on .kmn files.
#What to do if not set.
#How to detect the ISO 639-3 code on .bundle files.
#What to do if not set.
##########################

##########################
##########################