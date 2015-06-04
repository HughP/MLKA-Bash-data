#1/bin/bash

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

INITIAL_STATS_TITLE=First_Stats
SECOND_STATS_TITLE=Second_Stats
THIRD_STATS_TITLE=Third_Stats

INS_TRANSPOSED=First_Stats_Transposed # Used for transposed CSV files

##############################
# Variables for Other Things
##############################

JAMES_LIST_FILE=James-list.txt
WIKI_LIST_FILE=Wikipedia-list.txt
CORPUS_LIST_FILE=Corpus-list.txt #This file is currently only the James corpus, but after the wikidata is available this file should a combined list of all corpora. (I think - hp3)
LANGAUGE_LIST_FILE=Language_ID.txt

CMD_UNICODECCOUNT=UnicodeCCount


##############################
#Create Language IDs
##############################

# Find James corpora in both root and in DIR_JAMES_DATA
#find * -maxdepth 0 -iname '*ori*corpus*.txt' >> $CORPUS_LIST_FILE
#cd $DIR_JAMES_DATA
#find * -maxdepth 0 -iname '*ori*corpus*.txt' >> ../$CORPUS_LIST_FILE
#cd ../

# Generate the LANGUAGE_ID Variables.
# This step looks through the James corpus texts and pull out
# the last three characters of the corpus texts.

######
# Jonathan's Language look-up table needs to go here.
#####

# James-corpus.txt is a temp file.
#for i in $(find * -maxdepth 1 -iname '*ori*corpus*.txt'); do
#    expr "/$i" : '.*\(.\{3\}\)\.' >> James-corpus.txt
#done

#for i in $(cat James-corpus.txt);do
#	grep -Fxq "$i" $LANGAUGE_LIST_FILE || echo $i >> $LANGAUGE_LIST_FILE
#done

# James-corpus.txt is deleted.
#rm James-corpus.txt

# Set the Variables.
#LANGUAGE_IDString=$(cat $LANGAUGE_LIST_FILE | tr "\n" " ")
#LANGUAGE_ID=($LANGUAGE_IDString)

# This section needs to be modified and allow the arangement of info
# to be corpus by type: Wikpedia/James or Language Navajo/ibgo

#echo "INFO: It looks like altogether we found: ${#LANGUAGE_ID[@]} James based corpora."
#echo "      corpora. Including the following: ${LANGUAGE_ID[*]}"
#echo

HEADER_COLUMN1=James
HEADER_COLUMN2=Wikipedia
HEADER_COLUMN3=Keyboards
HEADER_COLUMN4=Languages

printf '\t'
printf "   "
printf $HEADER_COLUMN1
printf '\t'
printf "   "
printf $HEADER_COLUMN2
printf '\t'
printf "   "
printf $HEADER_COLUMN3
printf '\t'
printf "   "
printf $HEADER_COLUMN4
echo

printf '\t'
printf "  "
printf "+"
count=61
while (( count > 0 )); do
    printf "-"
    (( count = count - 1))
done
printf "+"
echo

row=1
for (( ROW_COUNT=100; ROW_COUNT > 0; ROW_COUNT-- )); do
    printf "row $row:"
    if (( row < 100 )); then
        printf '\t'
    fi
    printf "  "
    printf "|"
    for column in one two three four; do
            printf "$column"
            printf '\t'
            printf '\t'
            printf "|"
    done
    echo
    (( row++ ))
done

printf '\t'
printf "  "
printf "+"
count=61
while (( count > 0 )); do
    printf "-"
    (( count = count - 1))
done
printf "+"
echo
