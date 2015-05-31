#########################
#!/bin/bash
# Script Name: awesome-script.bash
# Authors: Hugh Paterson III <email here>
#          Jonathan Duff <jonathan@dufffamily.org>
# Version: 0.02
# License: GPL
# Dependencies are mentioned and linked in the README.md file.

 
SCRIPT_NAME="awesome-script.bash"
AUTHORS="Hugh Paterson III, Jonathan Duff"
VERSION="0.02"
License="GPL"
 
# Print Program Authors and Version number
echo
echo
echo "Script Name:" $SCRIPT_NAME
echo "Authors:" $AUTHORS
echo "Version:" $VERSION
echo "License:" $License
 
# Set to root folder of project
HOME_FOLDER=`pwd`
 
echo 
echo "INFO: Your data is being processed in the following folder:"
echo "      $HOME_FOLDER"
echo 
 
# Print starting step 1 stage 1 and 2: generating data
echo
echo "INFO: Pre-flighting. Setting some of the variables,"
echo "      looking to see if you have the correct"
echo "      dependencies installed, and looking at the"
echo "      corpus data on hand."
echo

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



##############################
#Dependencies Checks
##############################

# Check to see if csvfix is installed and in path:
if hash csvfix 2>/dev/null; then
    echo
    echo "INFO: Great you have csvfix installed."
else
    echo
    echo "! ERROR: Shucks! You do not have csvfix."
    echo "       You need to get it."
    echo "       You can use Mercurial and compile it"
    echo "       yourself from:"
    echo
    echo "       https://bitbucket.org/neilb/csvfix"
    echo
    echo "       If you are on OS X you can use Homebrew."
    echo "        'Brew install csvfix'."
    echo
    exit
fi

# Check to see if TECkit is installed and in path:
if hash teckit_compile 2>/dev/null; then
    echo "INFO: Great you have teckit_compile installed."
else
    echo
    echo "! ERROR: Shucks! You do not have teckit_compile."
    echo "       You need to get it.  SIL International is the"
    echo "       distributor. It is part of TECkit."
    echo "       Check here:"
    echo
    echo "       http://scripts.sil.org/TECkitDownloads"
    echo
    exit
fi

# Check to see if txtconv is installed and in path:
if hash txtconv 2>/dev/null; then
#    echo
    echo "INFO: Great you have txtconv installed."
#    echo

else
    echo
    echo "! ERROR: Shucks! You do not have txtconv. You need to"
    echo "       get it.  SIL International is the distributor."
    echo "       It is part of TECkit. Check here:"
    echo
    echo "       http://scripts.sil.org/TECkitDownloads "
    echo
    exit
fi

# Check to see if UnicodeCCount is installed and in path:
if hash UnicodeCCount 2>/dev/null; then
    echo "INFO: Great you have UnicodeCCount installed."
else
    echo
    echo "! ERROR: Shucks! You do not have UnicodeCCount."
    echo "       You need to get it.  SIL International is"
    echo "       the distributor. Check here:"
    echo
    echo "       http://scripts.sil.org/UnicodeCharacterCount"
    echo
    exit
fi

# Fetch wikipedia-extractor
if [ -f wikipedia-extractor/WikiExtractor.py ]; then
    # Control will enter here if DIRECTORY does NOT exist.
    echo "INFO: It looks like you already have wikipedia-extractor in place."
    echo "      Must not be your first time around the block."
    echo
else
    echo
    echo "! ERROR: Since we found some Wikipedia data, we now need some"
    echo "         tools to handle them. Time to 'git' the python script."
    echo
    echo "         You need to install:"
    echo "         git clone https://github.com/bwbaugh/wikipedia-extractor.git"
    echo
    exit
fi

#We need to add the jonathan compile script for renaming.
#We need to add the other python scripts from Matt Stave and any module dependencies they may have : Pandas, Glob, OS
#We might want to consider dependendies for carpalx.
#We might need to add KMFL and the Plaso-Python dependencies.

##############################
##############################

##############################
#Clean the data folders in the event that this is the second time this script has run.
##############################

# Clean up the working folder. Remove files from
# a previous run of the script. Data folders
# are processed before they are created.
# After deletion this section creates all the temp files created in the script.
# If the files are not found then this section creates empty ones.
# In this script standard practice is to create files here.


# Files to clean up
if [ -f $WIKI_LIST_FILE ]; then
    # Delete the file
    rm -f $WIKI_LIST_FILE
    echo "INFO: Replacing previously generated files!"
    touch $WIKI_LIST_FILE
else
    # Create the Wikipedia-list.txt
	touch $WIKI_LIST_FILE 
fi

if [ -f $CORPUS_LIST_FILE ]; then
    # Delete the file
    rm -f $CORPUS_LIST_FILE
    echo "      Clean! Clean!"
    touch $CORPUS_LIST_FILE
else
    # Create the Corpus-list.txt
	touch $CORPUS_LIST_FILE
fi

if [ -f $LANGAUGE_LIST_FILE ]; then
    # Delete the file
    rm -f $LANGAUGE_LIST_FILE
    echo "      Clean! Clean! Clean!"
    touch $LANGAUGE_LIST_FILE
else
    # Create the Language_ID.txt
	touch $LANGAUGE_LIST_FILE
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

##############################
##############################

##############################
#Check for proper data locations
#Wiki 
#James
#-----------------------------
#Others - not yet implemented
##############################

echo
echo "INFO: We're looking for text data and moving it to the correct locations."

# Wiki

##############################
#Look for Wikipedia data.
##############################

# Does the Wiki-Data folder exists?
# Yes: print exists
# No: make directory
if [ -d "$DIR_WIKI_DATA" ]; then
    echo "INFO: $DIR_WIKI_DATA folder exists."
    echo "      If we find Wikidata we will move it to the $DIR_WIKI_DATA folder."
    echo
else
    echo "INFO: Creating $DIR_WIKI_DATA folder"
    echo "      If we find Wikidata we will move it $DIR_WIKI_DATA folder."
    echo
    mkdir "$DIR_WIKI_DATA"
fi

# Search for compressed wiki dumps
#echo
#echo "INFO: Looking for corpora from Wikipedia data dumps."
#echo "      If we find anything we'll let you know."
#echo

# Move Wikipedia dumps into wikidata folder for processing.
# Double check Wiki-Data folder is there then run:
WIKI_DATA_FILE_COUNT=0
if [ -d "$DIR_WIKI_DATA" ]; then
    # So we're are in HOME_FOLDER here:
    for i in $(find * -maxdepth 0 -iname '*wiki*.bz2'); do
        # Now we're reaching into Wiki-Data folder:
        # If the file exists then do NOT copy.
        if [ ! -f "$DIR_WIKI_DATA/$i" ]; then

            # safe to move the bz2 file into Wiki-Data:
            mv "$i" "$DIR_WIKI_DATA"
	    (( WIKI_DATA_FILE_COUNT = WIKI_DATA_FILE_COUNT + 1 ))
	    # http://www.tldp.org/LDP/abs/html/dblparens.html

        fi
    done # end of for loop
    echo
    echo "INFO: Moved " $WIKI_DATA_FILE_COUNT " Wikidata into the $DIR_WIKI_DATA folder."
fi

### HUGH:
### This was moved from above to here because we don't want to index
### something then move it to a different folder.

### JONATHAN:
###I think I moved it to the top so that all indexing was done at the same time. I was not able to do a side by side check. Therefore I would prefere to leave it up where it was. The reason for this was that it worked with both new data and with re-runs where new data was added after the first run.

### HUGH:
### The result of running find with maxdepth 1 may not be ideal.
### Since all *wiki*.bz2 files are in $DIR_WIKI_DATA
### we would want to just have the $WIKI_LIST_FILE
### contain the file_names. Not dir/file_names

###I am not sure that this is an accurate assumption. Before am convenced we sould talk in person so that I can see what you mean. Can you please present future suggestions in code blocks (Three lines of "#" on the top and two lines of "#" on the bottom) in seperate files? like a small .sh file which we can later delete.

### Proposed change:

# List all Wikipedia dumps and store
# results into the file Wikipedia-list.txt
#find * -maxdepth 1 -iname '*wiki*.bz2' >> $WIKI_LIST_FILE
cd "$DIR_WIKI_DATA"
find * -maxdepth 0 -iname '*wiki*.bz2' >> ../$WIKI_LIST_FILE
cd ..

if [ "$(cat $WIKI_LIST_FILE | wc -l)" -eq "0" ]; then
    # No wikipedia dumps were found.
    echo
    echo "INFO:  We didn't find any Wikipedia data. We're moving on."
    echo
else
    # Some uncompressed Wikipedia dumps exist. 
    echo
    echo "INFO: It looks like we found some Wikipedia data."
    echo "      We think there are: $(cat $WIKI_LIST_FILE | wc -l) dumps to be processed."
    echo
#There is a bug here in that the above line has a long space in it when returned to the command prompt.
# JD->HP: It might be able to be solved by just moving the trailing text to the next line.
#Actually I think it needs {} so that the added spaces don't get added in to the output. But I am not sure about the syntax. Syntax for me on all of this is a bit fuzzy. I am mostly copy and pasting from stack exchange.
fi    

# James

##############################
#Look for James data.
##############################

# Does the James folder exists?
# Yes: print exists
# No: make directory
if [ -d "$DIR_JAMES_DATA" ]; then
    echo "INFO: $DIR_JAMES_DATA folder exists"
    echo
else
    echo "INFO: Creating $DIR_JAMES_DATA folder"
    echo
    mkdir $DIR_JAMES_DATA
fi

# Does the James folder exist?
# Yes: then move all files in HOME_FOLDER *james*.txt to it.
# NO: nothing.
JAMES_DATA_FILE_COUNT=0
if [ -d "$DIR_JAMES_DATA" ]; then
    for i in $(find * -maxdepth 0 -iname '*james*.txt'); do
	# Added a check so it doesn't clobber files:
        if [ ! -f "$DIR_JAMES_DATA/$i" ]; then

            # safe to move the bz2 file into Wiki-Data:
	    mv "$i" "$DIR_JAMES_DATA"
	    (( JAMES_DATA_FILE_COUNT = JAMES_DATA_FILE_COUNT + 1 ))
	    # http://www.tldp.org/LDP/abs/html/dblparens.html
        fi
    done
    echo
    echo "INFO: Moved " $JAMES_DATA_FILE_COUNT " James texts into the $DIR_JAMES_DATA folder."
fi

# Other

##############################
#Look for Other Corpora data. - Not yet implemented.
##############################

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
#.keylayout files need to be parsed with XML (DTD here: https://developer.apple.com/library/mac/technotes/tn2056/_index.html ; Example here: https://github.com/palmerc/Ukrainian-Russian/blob/master/Ukrainian%20(Russian).keylayout) for the characters which are contained in them. There might be an XML/bash script processing tool, or there might be a Python XML processsing tool for this.
#.kmn files need to be parsed for the characters which they can produced. To do this I should look at the Palaos-python tools.
#Windows ketboards are unacconted for. Adobe did create a script to convert .keylayout files to MSKLC files: https://github.com/adobe-type-tools/keyboard-layouts. Perhaps someone created a script for going the other way? If so, such a script could be investigated with the Me'phaa keyboard layout. There is a perl script for reading MSKLC here: https://github.com/amire80/msklc_reader. There are also several MSKLC files here: https://github.com/andjc/msklc
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

##########################
##########################

##########################
# Count keyboard layout files and list per language
##########################

##########################
##########################

##########################
# Export the capable characters or each keyboard layout file each to a seperate CSV
##########################
# http://unix.stackexchange.com/questions/12273/in-bash-how-can-i-convert-a-unicode-codepoint-0-9a-f-into-a-printable-charact
# http://stackoverflow.com/questions/602912/how-do-you-echo-a-4-digit-unicode-character-in-bash
##########################
##########################



##############################
#Create Language IDs
##############################

### HUGH:
### Since we have wiki and james files moved into folders
### shouldn't we handle *ori*corpus*.txt files the same way
### and move corpus files into something like Corpus folder?
###
### Also is there suppost to be james and corpus files mixed
### together in the same folder?
### JONATHAN: 
### See my notes below your Breakpoint around line 416.

# Find James corpora in both root and in DIR_JAMES_DATA
find * -maxdepth 0 -iname '*ori*corpus*.txt' >> $CORPUS_LIST_FILE
cd $DIR_JAMES_DATA
find * -maxdepth 0 -iname '*ori*corpus*.txt' >> ../$CORPUS_LIST_FILE
cd ../

###
###
### BREAKPOINT: stopping here and waiting for your approval to continue. @Jonathan - NO. this is not the case. Actually right now these *ori*corpus* files are only James files. So they do not need to be seperate. They do not represent a third category. We need to get the Wikipedia data into the script before we can fix this. Just go with the issue now, and after the wikipedia data comes in then I 'll fix this.
###
###
###


# Generate the LANGUAGE_ID Variables.
# This step looks through the James corpus texts and pull out
# the last three characters of the corpus texts.

######
# Jonathan's Language look-up table needs to go here.
#####

# James-corpus.txt is a tem file.
for i in $(find * -maxdepth 1 -iname '*ori*corpus*.txt'); do
    expr "/$i" : '.*\(.\{3\}\)\.' >> James-corpus.txt
done

for i in $(cat James-corpus.txt);do
	grep -Fxq "$i" $LANGAUGE_LIST_FILE || echo $i >> $LANGAUGE_LIST_FILE
done

# James-corpus.txt is deleted.
rm James-corpus.txt

# Set the Variables.
LANGUAGE_IDString=$(cat $LANGAUGE_LIST_FILE |tr "\n" " ")
LANGUAGE_ID=($LANGUAGE_IDString)

# This section needs to be modified and allow the arangement of info
# to be corpus by type: Wikpedia/James or Language Navajo/ibgo
echo
echo "INFO: It looks like altogether we found: ${#LANGUAGE_ID[@]} James based corpora."
echo "      corpora. Including the following: ${LANGUAGE_ID[*]}"
echo

##############################
##############################


##############################
#Do SFM Marker checking and if positive then removal
##############################
#
# Differed until version 0.7 of the script.
#
# Clean Biblical texts
#	a. Remove SFM Markers
#		i. Remove Verse #
#		ii. Remove Chapter #
#		iii. Remove Section headings #
#		iv. Create stated copy of text for reference.
##############################
##############################



#echo
#echo "INFO: Wikipedia data takes a while to clean up."
#echo "      We're working on the corpora now, so that"
#echo "      it can be processed with the other corpora."
#echo

##############################
##############################
####### Action Point #########
##############################

##############################
#Intergrate Wikipedia Extraction and Renaming
##############################

 
# JD->HP: All the prep stuff is done. Now on to processing the file.
# Pseudocode:
#    1. what are the first two letters of the filename
#
#    2. open: iso-639-3_20150505.tab, filter down the table for the ISO 639-1 codes:
#		The following command filters the table down.
#		csvfix read_DSV -s '\t' -f 1,4,7 iso-639-3_*.tab | csvfix remove -f 2 -l 0 iso-639-3-1-table.csv
#    3. may want to use something like: iso-639-3*.tab
#
#    4. grab columbs:
#       python wikipedia-extractor/WikiExtractor.py -o Wiki-Data/iso-396 Wiki-Data/$I


# I need to add the wikipedia decompression and clean up scripts here.
# http://stackoverflow.com/questions/4377109/shell-script-execute-a-python-program-from-within-a-shell-script

# I need to determine the language of the wikipedia corpora
# and convert that to ISO 639-3

# To do this I can look at the first two letters of the wikipedia
# file name, and then I can match those letters to the
# ISO 639-3 standard based on the table provided
# in the file 'iso-639-3_20150505.tab'.

# I need to rename the Wikipedia script sometime so that it
# matches the other corpora. I still need to determine
# when this is best to take place.

##############################
##############################

##############################
##############################
####### Action Point #########
##############################
##############################
#Intergrate Wikipedia cleaing python script
##############################



##############################
##############################

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

for i in $(cat $CORPUS_LIST_FILE); do
    for flag in -c -d -u -m "-d -m"; do
        UnicodeCCount $flag $DIR_JAMES_DATA/$i > $DIR_INITIAL_STATS_TITLE/$INITIAL_STATS_TITLE${flag/ /}-${i/ /}
    done
done

##############################
##############################

##############################
#Create CSV counts of counted files.
##############################
# Next task: Create CSV of counts
echo
echo "INFO: Creating some CSV files from the intial character counts."
echo

cd "$DIR_INITIAL_STATS_TITLE"

# Origional: ls -A1r *"$INITIAL_STATS_TITLE"*.txt | sort -t - -k 7 > "$INITIAL_STATS_TITLE"-list.txt

# Using a double quote as it allows the variable to pass
find * -maxdepth 0 -iname "*$INITIAL_STATS_TITLE*.txt" | sort -t - -k 7 > "$INITIAL_STATS_TITLE"-list.txt


for i in $(cat "$INITIAL_STATS_TITLE"-list.txt); do
	csvfix read_DSV -s '\t' "$i" | csvfix remove -if '$line <2' -o ${i/%.txt/.csv}
done

# Next task2: Create .md of counts.
echo
echo "INFO: Everybody on Github likes to read Markdown."
echo "      So we're making some markdown tables from"
echo "      the CSV files."
echo
 
#needs testing 
ls -A1r *${INITIAL_STATS_TITLE}*.csv | sort -t - -k 7 > "$INITIAL_STATS_TITLE"-list-csv.txt
# 
#for i in $(cat "$INITIAL_STATS_TITLE"-list-csv.txt); do
##    | csvfix write_DSV "$i" -o ${i/ /}.md
#done

for i in $(cat $LANGAUGE_LIST_FILE);do
	ls -A1r *Intial_Stats*"$i"*.csv > Intial_Stats-"$i"-list-csv.txt
done

##trying to cat a header to the .md files then do a something to the header.
# 
##"#${i/ /}"

##############################
##############################

##############################
# Create gnuplot graphs of character frequencies based on CSV files
##############################
# http://stackoverflow.com/questions/14871272/plotting-using-a-csv-file



##############################
#Alternate code by Jonathan D.
##############################
#Hugh did not institute this imediatly because he found the CSVfix method of creating the .md files without TECKit. But there are some other interesting things about Jonathan's approach which might be useful. This needs more consideration. Imediate questions are: why capitalize variable "$i"? Second question, what should I be thinking about when to move the working directory?
#
#cd $DIR_INITIAL_STATS_TITLE
#
##for i in $(find . -iname *ori*corups*.txt -type f)
#for I in $(cat ../corpus-list.txt); do
#    for FLAG in -c -d -u -m "-d -m"; do
#	NEW_FILE_NAME=$INITIAL_STATS_TITLE${FLAG/ /}-${I/ /}
#
#        UnicodeCCount $FLAG ../$I > $NEW_FILE_NAME
#
#	#prepend newline with hash then file name in sentence case to *.md file:
#	echo "#"$NEW_FILE_NAME.md > $NEW_FILE_NAME.md
#	#add space:
#	echo >> $NEW_FILE_NAME.md
#	cat $NEW_FILE_NAME >> $NEW_FILE_NAME.md
#
#	#@Hugh here goes the TECkit command:
#	#open *.md file and convert all tabspaces U+0009 to pipes and convert all U+0027 ‘ to \’
#    done
#done
#
#cd $HOME_FOLDER
#rm corpus-list.txt
#
##For reference: http://en.wikipedia.org/wiki/Letter_case
#
##The name pattern I want is {Intial-Stats_${flag}_{$LANGAGUE_ID}_File-Name.txt}


##############################
#I need to do some addition and subtraction for the .md files and do some sum() on a column and get the sum of characters.

#to find the sum of a culumn I need to use the 'expr'(no spaces) or 'let'(spaces) command '$expr 5 + 10' see: http://faculty.salina.k-state.edu/tim/unix_sg/bash/math.html http://www.bashguru.com/2010/12/math-in-shell-scripts.html 
##############################


##############################
#After Math expression is done on the CSV files, I need to: UnicodeCCount the Keyboard files. So that I can compare the CSV of the texts and the CSV files of the keyboards.
##############################


#############################
#The first TECkit conversion
# Applies to all corpora
#############################

cd "$HOME_FOLDER"

# Make directory for complied TECkit files to live in.
mkdir "$DIR_TEC_FILES"


# Compile new .tec from latest character cleaner. Apply this .tec file will apply to all texts.
teckit_compile TECkit-Files/TypographicalCharacterRemoval.map -o "$DIR_TEC_FILES"/TCR.tec

if [ -d "$DIR_TYPOGRAHICAL_CORRECT_DATA" ]; then
    # Control will enter here if DIRECTORY exist.
    rm -R -f "$DIR_TYPOGRAHICAL_CORRECT_DATA"
    mkdir "$DIR_TYPOGRAHICAL_CORRECT_DATA"
else
    # Control will enter here if DIRECTORY does NOT exist.
    mkdir "$DIR_TYPOGRAHICAL_CORRECT_DATA"
fi

# Apply Transformation to corpora
#The /James/"$i" solution was not really  viable for wikipedia data. Corpus_lits_file should have more than just james texts by this point. This is partiall dependent on getting the Wiki-data folder connected.
for i in $(cat $CORPUS_LIST_FILE); do
   txtconv -t $DIR_TEC_FILES/TCR.tec -i James/"$i" -o $DIR_TYPOGRAHICAL_CORRECT_DATA/${i/ /}
done

# Go through the created texts and rename them to Match the typographical setting.

cd $DIR_TYPOGRAHICAL_CORRECT_DATA

for i in $(find * -iname *ori*.txt);do
 	mv "$i" Typographical.${i:3} 
done

cd "$HOME_FOLDER"

##########Hugh takes a break here. Needs actual testing#####


if [ -d "$DIR_SECOND_STATS_TITLE" ]; then
    # Control will enter here if DIRECTORY exist.
    rm -R -f "$DIR_SECOND_STATS_TITLE"
    mkdir "$DIR_SECOND_STATS_TITLE"
else
    # Control will enter here if DIRECTORY does NOT exist.
    mkdir "$DIR_SECOND_STATS_TITLE"
fi


ls -A1r "$DIR_TYPOGRAHICAL_CORRECT_DATA"/*.txt > typographically-correct-corpora.txt

for i in $(cat typographically-correct-corpora.txt); do
   for flag in -c -d -u -m "-d -m"; do
       UnicodeCCount "$flag" "$i" > $SECOND_STATS_TITLE${flag/ /}-${i/ /}
   done
done

rm -f typographically-correct-corpora.txt

##############################
##The Second count of the corpus files
##############################

#The .md files should be pushed to the git hub repo sometime. look here for how: http://stackoverflow.com/questions/24677866/git-ignore-all-files-except-one-extension-and-folder-structure

#
#echo
#echo "Starting STEP 2 STAGE 1..."
#echo
#echo "Doing a character count for the Book of James corpora after processing some of the typograhical characters out."
#echo
# 
#if [ -d "$DIR_SECOND_STATS_TITLE" ]; then
#    # Control will enter here if DIRECTORY exist.
#    rm -R -f "$DIR_SECOND_STATS_TITLE"
#    mkdir $SECOND_STATS_TITLE
#else
#    # Control will enter here if DIRECTORY does NOT exist.
#    mkdir $DIR_SECOND_STATS_TITLE
#fi
#
#
##for i in $(find . -iname *ori*corpus*.txt -type f)
##@Jon W. Suggested that 'find' is a faster more effiencent option than 'cat' or 'ls' in this process. I have things working for 'cat' so I have not changed them.
#
#for i in $(cat corpus-list.txt); do
#    for flag in -c -d -u -m "-d -m"; do
#        UnicodeCCount $flag $i > $DIR_SECOND_STATS_TITLE/Second-Stats_${flag/ /}-${i/ /}
#    done
#done




#
##########################
#
#
### Something about variables sourced from: http://linuxconfig.org/bash-scripting-tutorial
### #!/bin/bash
### #Define bash global variable
### #This variable is global and can be used anywhere in this bash script
### VAR="global variable"
### function bash {
### #Define bash local variable
### #This variable is local to bash function only
### local VAR="local variable"
### echo $VAR
### }
### echo $VAR
### bash
### # Note the bash global variable did not change
### # "local" is bash reserved word
### echo $VAR
#
###Bash for and while loops
##########################
#
# 
##COUNTER=0
##while [  $COUNTER -lt 10 ]; do
##    echo The counter is $COUNTER
##    let COUNTER=COUNTER+1 
##done
# 
##change to home_folder
##cd $HOME_FOLDER
# 
##create [corpus_type]-[language_code]-[Intial_count] sub-folder
#CORPUS_TYPE=corpus_type
#LANGUAGE_CODE=language_code
#INTIAL_COUNT=intial_count
#NEW_FOLDER=$CORPUS_TYPE-$LANGUAGE_CODE-$INTIAL_COUNT
# 
#echo
#echo $NEW_FOLDER
#echo
# 
##mkdir $NEW_FOLDER
# 
##change to newly created folder
##cd $NEW_FOLDER
# 
#

##5. Get second set of corpus counts
##	a. Run UnicodeCCount on the stated copy of (4.b.iii) with the following flags and output them to a single new folder in the following ways:
##		i. -d
##			(1) as a .txt file (using '> CorpusName_SecondCount-d.txt')
##			(2) as a .md file where 'tab' is replaced with "|" and "'" is escaped with "\"; at the top of the .md file add "## File name" in good typography (use spaces and sentence case).
##		ii. -u
##		iii. -d -m
##		iv. -c
##		v. Create an additional concatenated version of the .md files; to top of concatenation add "#Second Corpus Counts"
##		vi. Create an alined data presentation for -u of (3.a.ii) and (5.a.ii). Print this to .md format (per 3.a.ii).
##	b. List all characters used.
##		i.List all characters used which are not enabled via the keyboard layout for the language of the text. __(check this for what it is being compared to)__
#
#
## STEP 4 STAGE 1:
#
##6. Convert texts to NFD
##	a. Convert texts to NFD.
##		i. UinicodeCCount -m and compare, show diffs
##	d. Remove untypeable characters
##		i. UinicodeCCount -m and compare; show diffs

##
##1. Collect texts from source.
##	a. Create date, time, source, and permissions metadata.
##	b. Create stated copy of text for reference.
##		i. give each text a consistent first part in the name and a varied middle part and a consistent last part. (i.e. ori-James-NAV-text.txt)
##	
##2. Collect keyboard layout files from source.
##	a. Create date, time, source metadata.
##	b. Create image based on Apple keyboard template.
##	c. Create image based on heatmap template.
##	d. Write keyboard layout description
##		i. List all characters which are enabled by the keyboard layout in Unicode NFD.
##			(1) Create list.
##			(2) Convert list to NFD.
##ls *.txt > corpus-list.txt
##
##3. For each corpus get initial corpus counts
##	a. Run UnicodeCCount with the following flags and output them to a single new folder in the following ways:
#UnicodeCCount -d > CorpusName_InitialCount-d.txt
##		i. -d
##			(1) as a .txt file (using '> CorpusName_InitialCount-d.txt')
##			(2) as a .md file where 'tab' is replaced with "|" and "'" is escaped with "\"; at the top of the .md file add "## File name" in good typography (use spaces and sentence case).
##		ii. -u
##		iii. -d -m
##		iv. -c
##		v. Create an additional concatenated version of the .md files; to top of concatenation add "#Initial Corpus Counts"
##	b. List all characters used.
##		i.List all characters used which are not enabled via the keyboard layout for the language of the text (compare lists: 2.d.1.(2) with 3.a.iii)
##
##4. Clean texts
##	a. Remove SFM Markers
##		i. Remove Verse #
##		ii. Remove Chapter #
##		iii. Remove Section headings #
##		iv. Create stated copy of text for reference.	
##	b. Remove typesetting characters via TECkit
##		i. List characters to be removed. Example U+00A0 needs to be converted to U+0020.
##		ii. Create .map file
##			(1) Create
##			(2) Compile .tec
##			(3) Apply
##			(4) Save .map and .tec files 
##		iii. Create stated copy of text for reference.	
##
##5. Get second set of corpus counts
##	a. Run UnicodeCCount on the stated copy of (4.b.iii) with the following flags and output them to a single new folder in the following ways:
##		i. -d
##			(1) as a .txt file (using '> CorpusName_SecondCount-d.txt')
##			(2) as a .md file where 'tab' is replaced with "|" and "'" is escaped with "\"; at the top of the .md file add "## File name" in good typography (use spaces and sentence case).
##		ii. -u
##		iii. -d -m
##		iv. -c
##		v. Create an additional concatenated version of the .md files; to top of concatenation add "#Second Corpus Counts"
##		vi. Create an alined data presentation for -u of (3.a.ii) and (5.a.ii). Print this to .md format (per 3.a.ii).
##	b. List all characters used.
##		i.List all characters used which are not enabled via the keyboard layout for the language of the text. __(check this for what it is being compared to)__
##
##6. Convert texts to NFD
##	a. Convert texts to NFD.
##		i. UinicodeCCount -m and compare, show diffs
##	d. Remove untypeable characters
##		i. UinicodeCCount -m and compare; show diffs
##
##7. Count words of text.
##	a. by counting spaces and adding 1.
##		
##8. Convert texts to ASCII
##	a. Use .map file to convert texts to ASCII
##
##9. Use python to count digrams.
##
##10. Use javascript to count distance.	
