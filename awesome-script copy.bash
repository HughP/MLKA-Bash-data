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
    echo "         tools to handle them. Time to `git` the python script."
    echo
    echo "         You need to install:"
    echo "         git clone https://github.com/bwbaugh/wikipedia-extractor.git"
    echo
    exit
fi

#We need to add the jonathan compile script for renaming.
#We need to add the other python scripts from Matt Stave and any module dependencies they may have : Pandas, Glob, OS
#We might want to consider dependendies for carpalx.

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
    echo "INFO: Replacting previously generated files!"
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


# Append file names of corpora to wiki list.
# Then list all Wikipedia dumps and store
# results into the file Wikipedia-list.txt 
find * -maxdepth 1 -iname '*wiki*.bz2' >> $WIKI_LIST_FILE

# Move Wikipedia dumps into wikidata folder for processing.
# Double check Wiki-Data folder is there then run:
if [ -d "$DIR_WIKI_DATA" ]; then
    # So we're are in HOME_FOLDER here:
    for i in $(find * -maxdepth 0 -iname '*wiki*.bz2'); do
        # Now we're reaching into Wiki-Data folder:
        # If the file exists then do NOT copy.
        if [ ! -f $DIR_WIKI_DATA/$i ]; then
	    # print some status of when moving the files:
	    printf "+"
            # safe to move the bz2 file into Wiki-Data:
            mv $i Wiki-Data 
#JONATHAN: Shouldn't this Wiki-Data instance in 267  become $DIR_WIKI_DATA ??? I am not sure what the syntax is saying here.       
	else
	    printf "!"
        fi
    done # end of for loop
fi # end of main if

if [ "$(cat $WIKI_LIST_FILE | wc -l)" -eq "0" ]; then
    # No wikipedia dumps were found.
    echo
    echo "INFO:  We didn't find any Wikipedia data. We're moving on."
    echo
else
    # Some uncompressed Wikipedia dumps exist. 
    echo
    echo "INFO: It looks like we found some Wikipedia data."
    echo "      We think there are:$(cat $WIKI_LIST_FILE | wc -l) dumps to be processed."
    echo #There is a bug here in that the above line has a long space in it when returned to the command prompt.
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
if [ -d "$DIR_JAMES_DATA" ]; then
    for i in $(find * -maxdepth 0 -iname '*james*.txt'); do
	mv "$i" "$DIR_JAMES_DATA"
	echo "INFO: Moved some James texts into the /$DIR_JAMES_DATA folder."
    done
fi

##############################
##############################
#######End of Data Check######
##############################

##############################
#Create Language IDs
##############################

# Find James corpora in both root and in DIR_JAMES_DATA
find * -maxdepth 0 -iname '*ori*corpus*.txt' >> $CORPUS_LIST_FILE
cd $DIR_JAMES_DATA
find * -maxdepth 0 -iname '*ori*corpus*.txt' >> ../$CORPUS_LIST_FILE
cd ../

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

#echo
#echo "INFO: Wikipedia data takes a while to clean up."
#echo "      We're working on the corpora now, so that"
#echo "      it can be processed with the other corpora."
#echo

 
# JD->HP: All the prep stuff is done. Now on to processing the file.
# Pseudocode:
#    1. what are the first two letters of the filename
#
#    2. open: iso-639-3_20150505.tab
#    2. may want to use something like: iso-639-3*.tab
#
#    3. grab columbs:
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

##############################
#Set up the character counts for corpora.
##############################

# STEP 1 STAGE 1 & 2:
 
#Print starting step 1 stage 1 and 2: generating data
echo
echo "INFO: Processing James."
echo "      Doing an initial character count of the book"
echo "      of James before further processing."
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

# The name pattern I want is {Intial-Stats_${flag}_{$LANGAGUE_ID}_File-Name.txt}

#@Jonathan D. or Jon W. Any help here would be a grate asset.
##############################
#Create CSV counts of counted files.
##############################
# Next task: Create CSV of counts
echo
echo "INFO: Creating some CSV files from the intial character counts."
echo

cd "$DIR_INITIAL_STATS_TITLE"

# Origional: ls -A1r *"$INITIAL_STATS_TITLE"*.txt > "$INITIAL_STATS_TITLE"-list.txt

# Using a double quote as it allows the variable to pass
find * -maxdepth 0 -iname "*$INITIAL_STATS_TITLE*.txt" > "$INITIAL_STATS_TITLE"-list.txt


for i in $(cat "$INITIAL_STATS_TITLE"-list.txt); do
    csvfix read_DSV -s '\t' "$i" | csvfix remove -if '$line <2' -o ${i/ /}.csv
done

# Next task2: Create .md of counts.
echo
echo "INFO: Everybody on Github likes to read Markdown."
echo "      So we're making some markdown tables from"
echo "      the CSV files."
echo
 
#ls -A1r *Intial_Stats*.csv > Intial_Stats-list-csv.txt
# 
#for i in $(cat Intial_Stats-list-csv.txt); do
##    | csvfix write_DSV "$i" -o ${i/ /}.md
#done
# 
##trying to cat a header to the .md files then do a something to the header.
# 
##"#${i/ /}"

##############################
#Alternate code by Jonathan D.
##############################
#Hugh did not institute this imediatly because he found the CSVfix method of creating the .md files without TECKit. But there are some other interesting things about Jonathan's approach which might be useful. This needs more consideration. Imediate questions are: why capitalize variable "$i"? Second question, what should I be thinking about when to move the working directory?

#
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

# Move to TECkit folder
cd TECkit-Files

# Compile new .tec from latest character cleaner. Apply this .tec file will apply to all texts.
teckit_compile TypographicalCharacterRemoval.map -o TCR.tec

cd "$HOME_FOLDER"

if [ -d "$DIR_TYPOGRAHICAL_CORRECT_DATA" ]; then
    # Control will enter here if DIRECTORY exist.
    rm -R -f "$DIR_TYPOGRAHICAL_CORRECT_DATA"
    mkdir "$DIR_TYPOGRAHICAL_CORRECT_DATA"
else
    # Control will enter here if DIRECTORY does NOT exist.
    mkdir "$DIR_TYPOGRAHICAL_CORRECT_DATA"
fi

# Apply Transformation to corpora
#The /James/"$i" solution was not really  viable for wikipedia data. Corpus_lits_file should have more than just james texts by this point.
for i in $(cat $CORPUS_LIST_FILE); do
   txtconv -t TECkit-Files/TCR.tec -i James/"$i" -o $DIR_TYPOGRAHICAL_CORRECT_DATA/${i/ /}
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
#############################

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
#
#
#
## STEP 2 STAGE 1:
#
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
#
## Clean the text files
#print Starting step 2 stage 1: cleaning the text files
#
#change to home_folder
##generate index folder list
#list directories and store into index-folder-list.txt file
#
#for each folder in index-folder-list.txt {
#	change to subfolder
#	Find .tec file name with matching corpus element in name [language_code].
#	run TECkit on *.txt files (but only files without SFM, and only on the corpus) using compiled [typographic].tec 
#
#
#}
#
#for each .tec file {
#}
#
## STEP 3 STAGE 1:
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
##
##6. Convert texts to NFD
##	a. Convert texts to NFD.
##		i. UinicodeCCount -m and compare, show diffs
##	d. Remove untypeable characters
##		i. UinicodeCCount -m and compare; show diffs
#
#
#
#
## STEP 4 STAGE 1:
#
##6. Convert texts to NFD
##	a. Convert texts to NFD.
##		i. UinicodeCCount -m and compare, show diffs
##	d. Remove untypeable characters
##		i. UinicodeCCount -m and compare; show diffs
#
#
#
## STEP 5 STAGE 1:
#
##7. Count words of text.
##	a. by counting spaces and adding 1.
#
#
## STEP 6 STAGE 1:
#
##8. Convert texts to ASCII
##	a. Use .map file to convert texts to ASCII
##
#
## STEP 7 STAGE 1:
#
##9. Use python to count digrams.
##
#
## STEP 8 STAGE 1:
#
##10. Use javascript to count distance.	
##			
##
#
#
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
#
#
#
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
#
#ls *.txt > corpus-list.txt
#
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
##		i.List all characters used which are not enabled via the keyboard layout for the language of the text (compare lists: 2.d.1.(2) with 3.a.iii).	
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
##			
#
###############################
#List of files for each keyboard and corpus
###############################
####Corpora###
#metadata file for corups.
#no touch copy of corpus.
#working copy of corpus.
#global Unicode to nfd mapping .map file.
#global unicode to nfd compiled mapping .tec file.
#
#Each working copy of each corpus has initial count: -d, -u, -c, -d -m,-m (6 files)
#Each working copy of each corpus has second count: -d, -u, -c, -d -m,-m (6 files) -following the removal of SFM
#Each working copy of each corpus has third count: -d, -u, -c, -d -m,-m (6 files) -following the removal of typographical characters.
#Each working copy of each corpus has fourth count: -d, -u, -c, -d -m,-m (6 files) -following the conversion of Unicode text to ASCII equivelent for keyboard analysis.
#
####Keybords###
#metadata file for keyboard.
#image of keyboard layout for layout.
#Base image of keyboard for heatmap.
#image of keyboard for heatmap sample text.
#image of keyboard for heatmap full text.
#list of all characters supported by keyboard.
#.kmn file for keyboard
#.kmx file for keyboard
#.keylayout file for keyboard.
# text description for keyboard (how it works).
#list of characters to be removed from text.
#.map file to support the removal of typographical characters.
#.tec file to implement the conversions the typographical characters.
#.map file to support the removal of untypeable characters.
#.tec file to implement the removal of untypeable characters.
#.map file for each keyboard layout to transform the text to ASCII.
#.tec file for each keyboard layout to transform the text to ASCII.