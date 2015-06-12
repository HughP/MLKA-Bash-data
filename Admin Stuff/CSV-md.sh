#!/bin/bash
#########################
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

# Set Home folder to root folder of project
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
DIR_TYPOGRAHICAL_CORRECT_DATA=Typographically-Clean-Corpora
DIR_CLEAN_AND_POSSIBLE_DATA=Typo-Clean-And-Possible-To-Type-Corpora
DIR_TEC_FILES=TECkit-tec-Files

##############################
# Variables for File Names Prefixes
##############################

INITIAL_STATS_TITLE=First_Stats # Prepended to the file names of files produced from the first iteration of corpora.
SECOND_STATS_TITLE=Second_Stats
THIRD_STATS_TITLE=Third_Stats

INS_TRANSPOSED=First_Stats_Transposed # Used for transposed CSV files

##############################
# Variables for Other Things
##############################

# List of the file names of the Data files (corpora and keyboards).
### ACTION NEEDED
JAMES_LIST_FILE=James-list.txt # This is a file list of the James Corpus files.
WIKI_LIST_FILE=Wikipedia-list.txt # This file contains the file names of the Wikipedia data dumps. 
CORPUS_LIST_FILE=Corpus-list.txt #This file is currently unused. It is supposed to be a list of all corproa (James + Wikipedia)
KEYBOARD_LIST_FILE=Keyboard-list.txt #T his file lists all the keyboard files. Included are .kmx, .keylayout, .kmn, (and perahps more) other blocks which reference this file need to take into account that there are multible file types in this file.

# List of all languages used in the data processing
LANGAUGE_LIST_FILE=Language_ID.txt #This file is for all languages, not just one of the three arrays.


CMD_UNICODECCOUNT=UnicodeCCount


CORPUS_TYPE=bla #This needs to be dynamically determined and then added to an array.
LANGUAGE_CODE=blabla #This is same as Language_ID
INTIAL_COUNT=blablabla #Not sure what this is or why it is needed.
 
#Change to working folder
#cd "$HOME_FOLDER"
echo 
echo "Your data is being processed in the following folder:"
echo $HOME_FOLDER

## STEP 1 STAGE 1 & 2:
 
#Print starting step 1 stage 1 and 2: generating data
echo
echo "Starting STEP 1 STAGE 1 & 2..."
echo
echo "Doing an initial character count of the book of James before further processing."
echo


# Check to see if there is a directory for the initial counts, if so then delete it and re-create it empty, otherwise create the folder new. 
if [ -d "$DIR_INITIAL_STATS_TITLE" ]; then
    # Control will enter here if DIRECTORY exist.
    rm -R -f "$DIR_INITIAL_STATS_TITLE"
    mkdir $DIR_INITIAL_STATS_TITLE
else
    # Control will enter here if DIRECTORY does NOT exist.
    mkdir $DIR_INITIAL_STATS_TITLE
fi
 
#TO DO: Check to see if this find statement works. The concern here is that it might not, but we need to check to see where the  files are at this point in the script. We might need to sanitize the paths.
#for i in $(find . -iname *ori*corpus*.txt -type f)


# Create the UnicodeCCounts for each flag opption. Put those into the Initial Stats folder. Note the same name is used as from the corpus list. Only it is prefixed.
for i in $(cat corpus-list.txt); do
    for flag in -c -d -u -m "-d -m"; do
        UnicodeCCount $flag $i > $DIR_INITIAL_STATS_TITLE/Initial-Stats_${flag/ /}-${i/ /}
    done
done

####################### 
##The name pattern needed is {Intial-Stats_${flag}_{$LANGAGUE_ID}_File-Name.txt}
#Could $LANGUAGE_ID be set via substring removal? see: http://wiki.bash-hackers.org/syntax/pe#substring_removal
##@Jonathan D. or Jon W. Any help here would be a grate asset.
#######################
 
# Next task: Create CSV of counts
echo
echo "Creating some CSV files from the intial character counts."
echo

# Move into the folder so that we don't have to create path names.
cd "$DIR_INITIAL_STATS_TITLE"

# Create a list of all the inital count files created across the various corporas
ls -A1r *"$INITIAL_STATS_TITLE"*.txt > "$INITIAL_STATS_TITLE"-list.txt

# Convert those tab seperated files to CSV files. But remove the top two lines of the tab files because those lines contain the name of the file counted. This information is now marked on the CSV file via the file name.

for i in $(cat "$INITIAL_STATS_TITLE"-list.txt); do
    csvfix read_DSV -s '\t' "$i" | csvfix remove -if '$line <2' -o ${i/ /}.csv
done

# Next task2: Create .md of counts.
echo
echo "Everybody on Github likes to read Markdown. So we're making some markdown tables from the CSV files."
echo
###########
#Can we put a variable in a regex? "Initial_Stats" should be set to the same variable as "$INITIAL_STATS_TITLE" Rather than being quoted. Accroding to: http://www.linuxquestions.org/questions/programming-9/bash-search-for-a-pattern-within-a-string-variable-448022/#post2260479 I think the correct syntax is "${INITIAL_STATS_TITLE}"
# Then also the Intial_Stats-list-csv.txt should also have a variable as a name.
###########
# Create a list of the CSV files.

#It seems that this "ls" command should be changed to a "find" command.
#ls -A1r *Intial_Stats*.csv > Intial_Stats-list-csv.txt

#The file in the cat statement should be refrenced via a variable, not a direct quote. Unless we use *list-csv*.txt
#for i in $(cat Intial_Stats-list-csv.txt); do

#For each CSV file the total number of characters should be computed. Then this number should be added at the bottom of the file.

#For each CSV file it should be converted to a .md file , --> |, then a headder consisiting of: the column names, the md table indicator, should be added to the file. Additionally in the first line of the file should be added file name so that we know what was being counted.

#After each .MD file is created, then a concatenated "report file" should be created. This report file should also contain several other important bits of information. as detailed in the tables and lines below.

# Compute and display all components of the following MD table.
# Question|Note|Statistic|
# ---|---|---|---
# How many words are in the text?| _This was determined by counting the number of spaces and adding 1._| 2,047
# How many characters are in the text?| _This was determined by counting using -u. This number includes white spaces and non-displaying characters, but not all characters are fully decomposed._| 16,488
# How many fully decomposed characters are in the text?| _This was determined by counting using -d. This number includes white spaces and non-displaying characters._| 19,931
# How many visible decomposed characters are in the text?| _This was determined by counting using -d and excluding 'U+0020' SPACE and 'U+000A' LINEFEED._ |17,322 
# How many visible orthographic units, counting long vowels as one unit, are in the text?| _This was determined by counting the total number of characters, subtracting invisible characters, subtracting the diacritics, and then also subtracting the number of occurrences of long vowels._| 
# What is the Tonal Marking Density of the text?| _This was determined by counting the total number of potential tone bearing units and dividing that by the total number of high tone marks. Tone bearing units are counted as phonemes. Since long vowels with high tone take two orthographic diacritics to mark tone, two counts are given to long vowels even though they represent a single phoneme. (This is similar to total diacritic marking density, but only looks at tone.)_ | 
# What is the Total Diacritic Density of the text?| _This is the total number of diacritics which are used compared with the total options in the text via the orthography for diacritics._ | 

##    | csvfix write_DSV "$i" -o ${i/ /}.md
#done
# 
##trying to cat a header to the .md files then do a something to the header.
# 
##"#${i/ /}"

#############################
#Langauge based info as Variables and constants
############################

##############################
I need to do some addition and subtraction for the .md files and do some sum() on a column and get the sum of characters.

#to find the sum of a culumn I need to use the 'expr'(no spaces) or 'let'(spaces) command '$expr 5 + 10' see: http://faculty.salina.k-state.edu/tim/unix_sg/bash/math.html http://www.bashguru.com/2010/12/math-in-shell-scripts.html 
##############################


##############################
After Math expression is done on the CSV files, I need to: UnicodeCCount the Keyboard files. So that I can compare the CSV of the texts and the CSV files of the keyboards.
##############################





###Text Counts
The original text capture from the _Navajo Bible_ can be found in the following file: [`/Navajo James Text/Navajo Text.txt`](/Publications/2015%20-%20Thesis/Data%20Used/1.%20USA%20Use%20Case/O.%20Navajo%20Text%20Sample/Navajo%20James%20Text/Navajo%20Text.txt)
As previously indicated, the file was cleaned up for this study. The file used for statistics is the following: [`/Navajo James Text/Navajo Text-no numbers-no headings.txt`](/Publications/2015%20-%20Thesis/Data%20Used/1.%20USA%20Use%20Case/O.%20Navajo%20Text%20Sample/Navajo%20James%20Text/Navajo%20Text-no%20numbers-no%20headings.txt)
When referring to "the James text", it is this second file which will be referenced.

In the James text the following statistics are encountered.

Question|Note|Statistic|
---|---|---|---
How many words are in the text?| _This was determined by counting the number of spaces and adding 1._| 2,047
How many characters are in the text?| _This was determined by counting using -u. This number includes white spaces and non-displaying characters, but not all characters are fully decomposed._| 16,488
How many fully decomposed characters are in the text?| _This was determined by counting using -d. This number includes white spaces and non-displaying characters._| 19,931
How many visible decomposed characters are in the text?| _This was determined by counting using -d and excluding 'U+0020' SPACE and 'U+000A' LINEFEED._ |17,322 
How many visible orthographic units, counting long vowels as one unit, are in the text?| _This was determined by counting the total number of characters, subtracting invisible characters, subtracting the diacritics, and then also subtracting the number of occurrences of long vowels._| 
What is the Tonal Marking Density of the text?| _This was determined by counting the total number of potential tone bearing units and dividing that by the total number of high tone marks. Tone bearing units are counted as phonemes. Since long vowels with high tone take two orthographic diacritics to mark tone, two counts are given to long vowels even though they represent a single phoneme. (This is similar to total diacritic marking density, but only looks at tone.)_ | 
What is the Total Diacritic Density of the text?| _This is the total number of diacritics which are used compared with the total options in the text via the orthography for diacritics._ | 

####Non-visible characters

Character Name|Unicode code point|Symbol|Count
 ---|---|---|---
 Linefeed |U+000A| |23
 Space |U+0020| |2,046

####Punctuation
The following punctuation marks are used in the text.

Character Name|Unicode code point|Symbol|Count
 ---|---|---|---
Comma |U+002C|,|194
Period (Full Stop) |U+002E|.|129
Question Mark |U+003F|?|19
Semi-Colon |U+003B|;|6
Exclamation Point |U+0021|!|6

####Diacritics, Vowels, and Nasals

Character Name|Unicode code point|Symbol|Count
 ---|---|---|---
Tone Marks|U+0301|́|2,670
Nasal Marks|U+0328|̨|443
Total Diacritics|||3,113

Counts via Regression on lower case characters|Glyph|Replacement code
---|---|---
631|a|LA
378|á|HA
23|ą|LNA
19|ą́|HNA
77|e|LE
164|é|HE
0|ę|LNE
0|ę́|HNE
975|i|LI
509|í|HI
28|į|LNI
24|į́|HNI
434|o|LO
188|ó|HO
2|ǫ|LNO
11|ǫ́|HNO
918|n|LN
0|ń|HN
189|aa|LAA
73|áa|HAA
2|aá|LAHA
187|áá|HAHA
36|ąą|LNALNA
17|ą́ą|HNALNA
0|ąą́|LNAHNA
23|ą́ą́|HNAHNA
153|ee|LELE
57|ée|HELE
0|eé|LEHE
46|éé|HEHE
0|ęę|LNELNE
6|ę́ę|HNELNE
0|ęę́|LNEHNE
12|ę́ę́|HNEHNE
311|ii|LILI
100|íi|HILI
1|ií|LIHI
126|íí|HIHI
16|įį|LNILNI
31|į́į|HNILNI
0|įį́|LNIHNI
11|į́į́|HNIHNI
250|oo|LOLO
13|óo|HOLO
5|oó|LOHO
111|óó|HOHO
5|ǫǫ|LNOLNO
8|ǫ́ǫ|HNOLNO
0|ǫǫ́|LNOHNO
1|ǫ́ǫ́|HNOHNO


###File Output

####Counts with -u (pre-composed characters)
Character count for 'O. Navajo Text Sample/Navajo Text-no numbers-no headings.txt':

Character Name|Unicode code point|Symbol|Count
 ---|---|---|---
 |U+000A| |23
 |U+0020| |2046
 |U+002C|,|194
 |U+003B|;|6
 |U+0021|!|6
 |U+003F|?|19
 |U+002E|.|129
 |U+0027|'|955
 |U+0301|́|210
 |U+0061|a|1084
 |U+0041|A|8
 |U+00E1|á|827
 |U+00C1|Á|14
 |U+0105|ą|198
 |U+0062|b|277
 |U+0042|B|21
 |U+0063|c|61
 |U+0043|C|3
 |U+0064|d|964
 |U+0044|D|67
 |U+0065|e|440
 |U+00E9|é|313
 |U+00C9|É|14
 |U+0119|ę|36
 |U+0066|f|2
 |U+0067|g|336
 |U+0047|G|44
 |U+0068|h|972
 |U+0048|H|15
 |U+0069|i|1698
 |U+0049|I|1
 |U+00ED|í|862
 |U+00CD|Í|2
 |U+012F|į|168
 |U+006A|j|95
 |U+004A|J|20
 |U+006B|k|192
 |U+004B|K|3
 |U+006C|l|282
 |U+004C|L|1
 |U+0142|ł|307
 |U+0141|Ł|2
 |U+006D|m|4
 |U+006E|n|919
 |U+004E|N|28
 |U+006F|o|952
 |U+004F|O|2
 |U+00F3|ó|428
 |U+01EB|ǫ|41
 |U+0072|r|7
 |U+0052|R|1
 |U+0073|s|297
 |U+0053|S|13
 |U+0074|t|402
 |U+0054|T|19
 |U+0075|u|2
 |U+0076|v|1
 |U+0077|w|30
 |U+0078|x|10
 |U+0079|y|228
 |U+0059|Y|2
 |U+007A|z|185


####Counts with -d (decomposed characters)
Character count for 'O. Navajo Text Sample/Navajo Text-no numbers-no headings.txt':

Character Name|Unicode code point|Symbol|Count
 ---|---|---|---
|U+000A| |23
|U+0020| |2046
|U+002C|,|194
|U+003B|;|6
|U+0021|!|6
|U+003F|?|19
|U+002E|.|129
|U+0027|'|955
|U+0301|́|2670
|U+0328|̨|443
|U+0061|a|2109
|U+0041|A|22
|U+0062|b|277
|U+0042|B|21
|U+0063|c|61
|U+0043|C|3
|U+0064|d|964
|U+0044|D|67
|U+0065|e|789
|U+0045|E|14
|U+0066|f|2
|U+0067|g|336
|U+0047|G|44
|U+0068|h|972
|U+0048|H|15
|U+0069|i|2728
|U+0049|I|3
|U+006A|j|95
|U+004A|J|20
|U+006B|k|192
|U+004B|K|3
|U+006C|l|282
|U+004C|L|1
|U+0142|ł|307
|U+0141|Ł|2
|U+006D|m|4
|U+006E|n|919
|U+004E|N|28
|U+006F|o|1421
|U+004F|O|2
|U+0072|r|7
|U+0052|R|1
|U+0073|s|297
|U+0053|S|13
|U+0074|t|402
|U+0054|T|19
|U+0075|u|2
|U+0076|v|1
|U+0077|w|30
|U+0078|x|10
|U+0079|y|228
|U+0059|Y|2
|U+007A|z|185


























