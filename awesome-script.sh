#########################
#!/bin/bash
# Script Name: awesome-script.bash
# Authors: Hugh Paterson III and Jonathan Duff
# Version: 0.01
# License: GPL
# Dependencies are mentioned and linked in the README.md file.

 
SCRIPT_NAME="awesome-script.bash"
AUTHORS="Hugh Paterson III, Jonathan Duff"
VERSION="0.01"
License="GPL"
 
#Print Program Author and Version number
 
echo "Script Name:" $SCRIPT_NAME
echo "Authors:" $AUTHORS
echo "Version:" $VERSION
echo "License:" $License
 
CMD_UNICODECCOUNT=UnicodeCCount
DIR_INITIAL_STATS_TITLE=Initial-Stats
DIR_SECOND_STATS_TITLE=Second_Stats
INITIAL_STATS_TITLE=Initial-Stats
SECOND_STATS_TITLE=Second_Stats
THIRD_STATS_TITLE=Third_Stats_

CORPUS_TYPE=bla #This needs to be dynamically determined and then added to an array.
LANGUAGE_CODE=blabla #This is same as Language_ID
INTIAL_COUNT=blablabla #Not sure what this is or why it is needed.
 

#Set to root folder of project
#define home_folder as location of project
HOME_FOLDER=`pwd`
 
#Change to working folder
#cd "$HOME_FOLDER"
echo 
echo "Your data is being processed in the following folder:"
echo $HOME_FOLDER
 
 
#Print starting step 1 stage 1 and 2: generating data
echo
echo "Pre-flighting. Setting some of the variables and looking at the corpus data on hand."
echo

##########
#Clean up the working folder. Remove files from a previous run of the script. Data folders are processed before they are created.
##########

if [ -f Wikipedia-list.txt ]; then
    # Delete the file
    rm -R -f Wikipedia-list.txt
else
    # Create the Wikipedia-list.txt
    echo Clean!
fi

if [ -f corpus-list.txt ]; then
    # Delete the file
    rm -R -f corpus-list.txt
else
    # Create the corpus-list.txt
   echo Clean!Clean!
fi

if [ -f Language_ID.txt ]; then
    # Delete the file
    rm -R -f Language_ID.txt
else
    # Create the Language_ID.txt
   echo Clean!Clean!Clean!
fi


##########
#search for compressed wiki dumps
##########

echo
echo
echo "Looking for corpora from Wikipedia data dumps. If we find anything we'll let you know."
echo
echo

#Create list of Wikipedia corpora
touch Wikipedia-list.txt

#Append file names of corpora to wiki list.
#List all Wikipedia dumps and store results into wikipedia-list.txt file
ls -A1r *wiki*.bz2 >> Wikipedia-list.txt

###If we find some Wikipedia data then display message 1 if we don't find anything then message 2.
###If we find some Wikipedia data display count and kind, just like is done for james, else move on.

if [ "$(cat Wikipedia-list.txt | wc -l)" -eq "0" ] ; then
    # No wikipedia dumps were found.
    echo
	echo
	echo "We didn't find any Wikipedia data. We're moving on."
	echo
	echo
else
    # Some uncompressed wikipedia dumps exist. 
	echo
	echo
	echo "It looks like we found some Wikipedia data. We think there are"$(cat wikipedia-list.txt | wc -l)" dumps to be processed."
	echo
	echo
	if [ -d wikipedia-extractor ]; then
    	# Control will enter here if DIRECTORY does NOT exist.
		echo "It looks like you already have wikipedia-extractor in place. Must not be your first time around the block."
		else
		echo "Since we found some Wikipedia data, we now need some tools to handle them. Time to git the python script."
		git clone https://github.com/bwbaugh/wikipedia-extractor.git
	fi	
fi

##########
#I need to add the wikipedia decompression and clean up scripts here. http://stackoverflow.com/questions/4377109/shell-script-execute-a-python-program-from-within-a-shell-script
#I need to determine the language of the wikipedia corpora and convert that to ISO 639-3
##to do this I can look at the first two letters of the wikipedia file name, and then I can match those letters to the ISO 639-3 standard based on the table provided in the file 'iso-639-3_20150505.tab'.
#I need to rename the Wikipedia script sometime so that it matches the other corpora. I still need to determine when this is best to take place.
##########

###
### JD edit
###

# Check to see if csvfix is installed and in path:
if hash csvfix 2>/dev/null; then
    echo yes you have csvfix
else
    echo no you do not have csvfix
fi

# Does the Wiki-Data folder exists?
# Yes: print exists
# No: make directory
if [ -d "Wiki-Data" ]; then
    echo Wiki-Data folder exists
else
    mkdir Wiki-Data
fi

# Does the James folder exists?
# Yes: print exists
# No: make directory
if [ -d "James" ]; then
    echo James folder exists
else
    mkdir James
fi

# Does the James folder exist?
# Yes: then move all files in HOME_FOLDER *james*.txt to it.
# NO: nothing.
if [ -d "James" ]; then
    mv *james*.txt James
fi

# Double check then run:
if [ -d "Wiki-Data" ]; then
    # So we're are in HOME_FOLDER here:
    for I in $(ls -A1r *.bz2); do
	# Now we're reaching into Wiki-Data folder:
	# If the file exists then do NOT copy.
	if [ -f Wiki-Data/$I ]; then
	    # There is already a file in the Wiki-Data folder so don't overwrite and notify:
	    echo Duplicate file found in Wiki-Data: $I
	    echo
	else
	    # print some sort of notification to the screen that we're doing something:
	    printf "."

	    # safe to move the bz2 file into Wiki-Data:
	    mv $I Wiki-Data

	    # this will uncompress the file if needed (disabled for now):
#	    bzip2 -d Wiki-Data/$I

	    # does our output directory exist?
	    # Yes: notify
	    # No: notify and create directory
	    if [ -d Wiki-Data/iso-639-1 ]; then
		echo iso-639 folder exists.
	    else
		echo creating iso-639 folder in Wiki-Data.
		mkdir Wiki-Data/iso-639
	    fi

	    #
	    # JD->HP: All the prep stuff is done. Now on to processing the file
	    # Pseudocode:
	    #    1. what are the first two letters of the filename
	    #
	    #    2. open: iso-639-3_20150505.tab 
	    #    2. may want to use something like: iso-639-3*.tab
	    #
	    #    3. grab columbs: 
	    #python wikipedia-extractor/WikiExtractor.py -o Wiki-Data/iso-396 Wiki-Data/$I

	fi
    done # end of for loop

    echo done.
fi # end of main if

###
### JD edit
###


echo
echo
echo "Wikipedia data takes a while to clean up. We're working on the corpora now, so that it can be processed with the other corpora."
echo
echo


#list all original corpus files and store results into corpus-list.txt file
# A: print almost everything... exclude the . and ..
# 1: print one file per line
# r: recursive
# F: append / to directory entries
ls -A1r *ori*corpus*.txt > corpus-list.txt

#Generate the LANGUAGE_ID Variables. This step looks through the corpus texts and pull out the last three characters of the corpus texts.
touch Language_ID.txt

#This puts the languages in the file every time the script runs. They will be in the file twice if run twice. I need to change this to only adding new ones if not already there. Consider: http://stackoverflow.com/questions/3557037/appending-a-line-to-a-file-only-if-it-doesnt-already-exist-using-sed
for i in $(cat corpus-list.txt); do
	expr "/$i" : '.*\(.\{3\}\)\.' >> Language_ID.txt
done

#Set the Variables.
LANGUAGE_IDString=$(cat LANGUAGE_ID.txt |tr "\n" " ")
LANGUAGE_ID=($LANGUAGE_IDString)

#######
#This section needs to be modified and allow the arangement of info to be corpus by type: Wikpedia/James or Language Navajo/ibgo
#######
echo
echo
echo "It looks like altogether we found ${#LANGUAGE_ID[@]} corpora. Including the following: ${LANGUAGE_ID[*]}"
echo
echo

 
## STEP 1 STAGE 1 & 2:
 
#Print starting step 1 stage 1 and 2: generating data
echo
echo "Starting STEP 1 STAGE 1 & 2..."
echo
echo "Doing an initial character count of the book of James before further processing."
echo
 
if [ -d "$DIR_INITIAL_STATS_TITLE" ]; then
    # Control will enter here if DIRECTORY exist.
    rm -R -f "$DIR_INITIAL_STATS_TITLE"
    mkdir $DIR_INITIAL_STATS_TITLE
else
    # Control will enter here if DIRECTORY does NOT exist.
    mkdir $DIR_INITIAL_STATS_TITLE
fi
 
#for i in $(find . -iname *ori*corpus*.txt -type f)
#@Jon W. Suggested that 'find' is a faster more effiencent option than 'cat' or 'ls' in this process. I have things working for 'cat' so I have not changed them.

for i in $(cat corpus-list.txt); do
    for flag in -c -d -u -m "-d -m"; do
        UnicodeCCount $flag $i > $INITIAL_STATS_TITLE/Initial-Stats_${flag/ /}-${i/ /}
    done
done
 
##The name pattern I want is {Intial-Stats_${flag}_{$LANGAGUE_ID}_File-Name.txt}
##@Jonathan D. or Jon W. Any help here would be a grate asset.
 
#Next task: Create CSV of counts
echo
echo "Creating some CSV files from the intial character counts."
echo
 
cd "$DIR_INITIAL_STATS_TITLE"
 
ls -A1r *"$INITIAL_STATS_TITLE"*.txt > "$INITIAL_STATS_TITLE"-list.txt
 
for i in $(cat "$INITIAL_STATS_TITLE"-list.txt); do
    csvfix read_DSV -s '\t' "$i" | csvfix remove -if '$line <2' -o ${i/ /}.csv
done

#Next task2: Create .md of counts.
echo
echo "Everybody on Github likes to read Markdown. So we're making some markdown tables from the CSV files."
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
Alternate code by Jonathan D.
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
I need to do some addition and subtraction for the .md files and do some sum() on a column and get the sum of characters.

#to find the sum of a culumn I need to use the 'expr'(no spaces) or 'let'(spaces) command '$expr 5 + 10' see: http://faculty.salina.k-state.edu/tim/unix_sg/bash/math.html http://www.bashguru.com/2010/12/math-in-shell-scripts.html 
##############################


##############################
After Math expression is done on the CSV files, I need to: UnicodeCCount the Keyboard files. So that I can compare the CSV of the texts and the CSV files of the keyboards.
##############################


#############################
#The first TECkit conversion
############################

teckit_compile ConvertToNFD.map -o NFD.tec
txtconv -t NFD.tec -i combined.txt -o combined-conv-nfd.txt




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
##	run UnicodeCCount with “-d” and store into tmp.txt
##rename tmp.txt to Corpus-ori-[corpus_type]-[language_code]-text-[flag].txt
##	copy above created file to *.md instead of *.txt
##open that file and convert all tabspaces U+0009 to pipes
##convert all U+0027 ‘ to \’
##EX: #Corpus ori james nav text
##	prepend newline with hash then file name in sentence case to *.md file
##
##	run UnicodeCCount with “-c” and store into tmp.txt
##rename tmp.txt to Corpus-ori-[corpus_type]-[language_code]-text-[flag].txt
##	copy above created file to *.md instead of *.txt
##open that file and convert all tabspaces U+0009 to pipes
##convert all U+0027 ‘ to \’
##EX: #Corpus ori james nav text
##	prepend newline with hash then file name in sentence case to *.md file
##
##run UnicodeCCount with “-u”  and store into tmp.txt
##rename tmp.txt to Corpus-ori-[corpus_type]-[language_code]-text-[flag].txt
##copy above created file to *.md instead of *.txt
##open that file and convert all tabspaces U+0009 to pipes
##convert all U+0027 ‘ to \’
##EX: #Corpus ori james nav text
##	prepend newline with hash then file name in sentence case to *.md file
##
##run UnicodeCCount with “-d -m”  and store into tmp.txt
##rename tmp.txt to Corpus-ori-[corpus_type]-[language_code]-text-[flag].txt
##copy above created file to *.md instead of *.txt
##open that file and convert all tabspaces U+0009 to pipes
##convert all U+0027 ‘ to \’
##EX: #Corpus ori james nav text
##	prepend newline with hash then file name in sentence case to *.md file
##
##
##
##
### STEP 2 STAGE 1:
##
###4. Clean texts
###	a. Remove SFM Markers
###		i. Remove Verse #
###		ii. Remove Chapter #
###		iii. Remove Section headings #
###		iv. Create stated copy of text for reference.	
###	b. Remove typesetting characters via TECkit
###		i. List characters to be removed. Example U+00A0 needs to be converted to U+0020.
###		ii. Create .map file
###			(1) Create
###			(2) Compile .tec
###			(3) Apply
###			(4) Save .map and .tec files 
###		iii. Create stated copy of text for reference.	
##
### Clean the text files
##print Starting step 2 stage 1: cleaning the text files
##
##change to home_folder
###generate index folder list
##list directories and store into index-folder-list.txt file
##
##for each folder in index-folder-list.txt {
##	change to subfolder
##	Find .tec file name with matching corpus element in name [language_code].
##	run TECkit on *.txt files (but only files without SFM, and only on the corpus) using compiled [typographic].tec 
##
##
##}
##
##for each .tec file {
##}
##
### STEP 3 STAGE 1:
##
###5. Get second set of corpus counts
###	a. Run UnicodeCCount on the stated copy of (4.b.iii) with the following flags and output them to a single new folder in the following ways:
###		i. -d
###			(1) as a .txt file (using '> CorpusName_SecondCount-d.txt')
###			(2) as a .md file where 'tab' is replaced with "|" and "'" is escaped with "\"; at the top of the .md file add "## File name" in good typography (use spaces and sentence case).
###		ii. -u
###		iii. -d -m
###		iv. -c
###		v. Create an additional concatenated version of the .md files; to top of concatenation add "#Second Corpus Counts"
###		vi. Create an alined data presentation for -u of (3.a.ii) and (5.a.ii). Print this to .md format (per 3.a.ii).
###	b. List all characters used.
###		i.List all characters used which are not enabled via the keyboard layout for the language of the text. __(check this for what it is being compared to)__
###
###6. Convert texts to NFD
###	a. Convert texts to NFD.
###		i. UinicodeCCount -m and compare, show diffs
###	d. Remove untypeable characters
###		i. UinicodeCCount -m and compare; show diffs
##
##
##
##
### STEP 4 STAGE 1:
##
###6. Convert texts to NFD
###	a. Convert texts to NFD.
###		i. UinicodeCCount -m and compare, show diffs
###	d. Remove untypeable characters
###		i. UinicodeCCount -m and compare; show diffs
##
##
##
### STEP 5 STAGE 1:
##
###7. Count words of text.
###	a. by counting spaces and adding 1.
##
##
### STEP 6 STAGE 1:
##
###8. Convert texts to ASCII
###	a. Use .map file to convert texts to ASCII
###
##
### STEP 7 STAGE 1:
##
###9. Use python to count digrams.
###
##
### STEP 8 STAGE 1:
##
###10. Use javascript to count distance.	
###			
###
##
##
##
###########################
##
##
##
###This is a bash script to automate the transformation of corpora.
##
###Requires these dependencies
### 1. UnicodeCCount
### 2. TECKit
### 3. Typing by Michael Dickens
### 4. Stave Python script for Cleaning Wikipedia
### 5. Stave Python script for counting digrams
### 6. JavaScript count
##
##
### common commands
###
### echo "changing directories"
### cd ~/Multi-lingual\ Keyboard\ Assessment/MLKA/
##
### echo "adding to git"
### git add --all
### git commit -m 'some updates'
##
### UnicodeCCount -d -m > sometextfile.txt
##
#### Something about variables sourced from: http://linuxconfig.org/bash-scripting-tutorial
#### #!/bin/bash
#### #Define bash global variable
#### #This variable is global and can be used anywhere in this bash script
#### VAR="global variable"
#### function bash {
#### #Define bash local variable
#### #This variable is local to bash function only
#### local VAR="local variable"
#### echo $VAR
#### }
#### echo $VAR
#### bash
#### # Note the bash global variable did not change
#### # "local" is bash reserved word
#### echo $VAR
##
####Bash for and while loops
##
##
##
###
###1. Collect texts from source.
###	a. Create date, time, source, and permissions metadata.
###	b. Create stated copy of text for reference.
###		i. give each text a consistent first part in the name and a varied middle part and a consistent last part. (i.e. ori-James-NAV-text.txt)
###	
###2. Collect keyboard layout files from source.
###	a. Create date, time, source metadata.
###	b. Create image based on Apple keyboard template.
###	c. Create image based on heatmap template.
###	d. Write keyboard layout description
###		i. List all characters which are enabled by the keyboard layout in Unicode NFD.
###			(1) Create list.
###			(2) Convert list to NFD.
##
##ls *.txt > corpus-list.txt
##
###
###3. For each corpus get initial corpus counts
###	a. Run UnicodeCCount with the following flags and output them to a single new folder in the following ways:
##UnicodeCCount -d > CorpusName_InitialCount-d.txt
###		i. -d
###			(1) as a .txt file (using '> CorpusName_InitialCount-d.txt')
###			(2) as a .md file where 'tab' is replaced with "|" and "'" is escaped with "\"; at the top of the .md file add "## File name" in good typography (use spaces and sentence case).
###		ii. -u
###		iii. -d -m
###		iv. -c
###		v. Create an additional concatenated version of the .md files; to top of concatenation add "#Initial Corpus Counts"
###	b. List all characters used.
###		i.List all characters used which are not enabled via the keyboard layout for the language of the text (compare lists: 2.d.1.(2) with 3.a.iii).	
###
###4. Clean texts
###	a. Remove SFM Markers
###		i. Remove Verse #
###		ii. Remove Chapter #
###		iii. Remove Section headings #
###		iv. Create stated copy of text for reference.	
###	b. Remove typesetting characters via TECkit
###		i. List characters to be removed. Example U+00A0 needs to be converted to U+0020.
###		ii. Create .map file
###			(1) Create
###			(2) Compile .tec
###			(3) Apply
###			(4) Save .map and .tec files 
###		iii. Create stated copy of text for reference.	
###
###5. Get second set of corpus counts
###	a. Run UnicodeCCount on the stated copy of (4.b.iii) with the following flags and output them to a single new folder in the following ways:
###		i. -d
###			(1) as a .txt file (using '> CorpusName_SecondCount-d.txt')
###			(2) as a .md file where 'tab' is replaced with "|" and "'" is escaped with "\"; at the top of the .md file add "## File name" in good typography (use spaces and sentence case).
###		ii. -u
###		iii. -d -m
###		iv. -c
###		v. Create an additional concatenated version of the .md files; to top of concatenation add "#Second Corpus Counts"
###		vi. Create an alined data presentation for -u of (3.a.ii) and (5.a.ii). Print this to .md format (per 3.a.ii).
###	b. List all characters used.
###		i.List all characters used which are not enabled via the keyboard layout for the language of the text. __(check this for what it is being compared to)__
###
###6. Convert texts to NFD
###	a. Convert texts to NFD.
###		i. UinicodeCCount -m and compare, show diffs
###	d. Remove untypeable characters
###		i. UinicodeCCount -m and compare; show diffs
###
###7. Count words of text.
###	a. by counting spaces and adding 1.
###		
###8. Convert texts to ASCII
###	a. Use .map file to convert texts to ASCII
###
###9. Use python to count digrams.
###
###10. Use javascript to count distance.	
###			
###
##
##
################################
##List of files for each keyboard and corpus
################################
#####Corpora###
##metadata file for corups.
##no touch copy of corpus.
##working copy of corpus.
##global Unicode to nfd mapping .map file.
##global unicode to nfd compiled mapping .tec file.
##
##Each working copy of each corpus has initial count: -d, -u, -c, -d -m,-m (6 files)
##Each working copy of each corpus has second count: -d, -u, -c, -d -m,-m (6 files) -following the removal of SFM
##Each working copy of each corpus has third count: -d, -u, -c, -d -m,-m (6 files) -following the removal of typographical characters.
##Each working copy of each corpus has fourth count: -d, -u, -c, -d -m,-m (6 files) -following the conversion of Unicode text to ASCII equivelent for keyboard analysis.
##
#####Keybords###
##metadata file for keyboard.
##image of keyboard layout for layout.
##Base image of keyboard for heatmap.
##image of keyboard for heatmap sample text.
##image of keyboard for heatmap full text.
##list of all characters supported by keyboard.
##.kmn file for keyboard
##.kmx file for keyboard
##.keylayout file for keyboard.
## text description for keyboard (how it works).
##list of characters to be removed from text.
##.map file to support the removal of typographical characters.
##.tec file to implement the conversions the typographical characters.
##.map file to support the removal of untypeable characters.
##.tec file to implement the removal of untypeable characters.
##.map file for each keyboard layout to transform the text to ASCII.
##.tec file for each keyboard layout to transform the text to ASCII.