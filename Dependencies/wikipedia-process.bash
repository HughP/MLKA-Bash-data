#!/bin/bash

#echo
#echo "INFO: Wikipedia data takes a while to clean up."
#echo "      We're working on the corpora now, so that"
#echo "      it can be processed with the other corpora."
#echo


##############################
#Wikipedia Extraction and Renaming
##############################


#		Matches all *wiki*.bz2 files
#		to all iso-639-3*.tab files combined.
#		Then creates corisponding directory
#		in Wiki-Data.

# Let's make sure the python scritp is executable.
chmod +x "$HOME_FOLDER"/Dependencies/Software/wikipedia-extractor/WikiExtractor.py

# I need to change the source to the following: https://github.com/attardi/wikiextractor

# Sweep up
if [ -f iso-639-3.data ]; then
    rm iso-639-3.data
fi

csvfix read_dsv -f 1,4,7 -s '\t' Dependencies/Data/iso-639-3*.tab | csvfix remove -f 2 -l 0 > iso-639-3.data

echo
echo "INFO: We've started extracting the Wikipedia data."
echo "      Note that large files take a long time. In testing 2.5GB files took up to 3 hours."
echo "      Warnings in this section come from the Python script."
echo "      They are due to the extractor script's interactions with the data."
echo "      Explanations for the warning can be found in the in-line comments in the the WikiExtractor.py script."
echo
echo

if [ -f iso-639-3.data ]; then
    pushd "$DIR_WIKI_DATA"
    # For every *wiki*.bz2 file do:
    for FILE in $(find * -iname '*wiki*.bz2'); do
        for DATA in $(cat "$HOME_FOLDER"/iso-639-3.data); do
            if [[ ${FILE:0:2} == ${DATA:7:2} ]]; then
                if [ -d ${DATA:1:3} ]; then
                    echo "INFO: Data-Wiki/${DATA:1:3} exists. We assume that there is already extracted Wikipedia data in that folder."
                else
                    mkdir ${DATA:1:3}
                    echo "INFO: We're extracting the ${DATA:11} [${DATA:1:3}] languge data."
					START_EXTRACT=`date +%s` 
                    python ../Dependencies/Software/wikipedia-extractor/WikiExtractor.py -q -o ${DATA:1:3} $FILE
                    END_EXTRACT=`date +%s` # This line needs testing.
                    RUNTIME=$((END_EXTRACT-START_EXTRACT)) # This could use interpretation. It reports everything in seconds.
                    echo "      We're back from processing the [${DATA:1:3}] languge data. It only took: $RUNTIME seconds." # This line needs testing.
                    # For other methods of finding time for the script running see here: http://unix.stackexchange.com/questions/52313/how-to-get-execution-time-of-a-script-effectively
                    echo
                    echo
                fi
            fi
        done
    done

    popd
fi

exit;0

# Sweep up
if [ -f iso-639-3.data ]; then
    rm iso-639-3.data
fi

# Report the languages found to the wikipedia list and to the master list
pushd $DIR_WIKI_DATA
find * -maxdepth 0 -type d  \( ! -iname ".*" \) >> ../$WIKI_LANGUAGES
popd


# Set the Variables.
WIKI_LANGUAGESString=$(cat $WIKI_LANGUAGES | tr "\n" " ")
WIKI_LANGUAGES=($WIKI_LANGUAGESString) #There is a bug here (or at least a bad programming practice). The file veriable has one name and the same name is used later for a different meaning.

# This section needs to be modified and allow the arangement of info
# to be corpus by type: Wikpedia/James or Language Navajo/ibgo

echo "INFO: It looks like we were able to extract ${#WIKI_LANGUAGES[@]} Wikipedia based corpora."
echo "      Including the following languages: ${WIKI_LANGUAGES[*]}"
echo


# Take the languages from Wikipedia and append them to the master language list; making sure not to add duplicates

# This might be able to be simplified as an array and use just bash....
#   Some_array=(cat $WIKI_LANGUAGES)
#   Some_other_array=(cat $JAMES_LANGUAGES)
#   Some_third_array=("${Some_array[@]}" "${Some_other_array[@]}")
#   Display the compined number of units: ${#Some_third_array[*]}
#   Some_third_array_count=$((${#Some_array[*]} + ${#Some_other_array[*]}))


csvfix unique Wikipedia_Languages.txt $LANGUAGE_LIST_FILE | csvfix write_dsv -s ' ' -o $LANGUAGE_LIST_FILE


# Set the Variables.
LANGUAGE_IDString=$(cat $LANGUAGE_LIST_FILE | tr "\n" " ")
LANGUAGE_ID=($LANGUAGE_IDString)

# This section needs to be modified and allow the arangement of info
# to be corpus by type: Wikpedia/James or Language Navajo/ibgo

##############################
####### Action Point #########
##############################
# Hugh is not sure how to get the sum of all the corpora. (Wiki+James)
# Since each value is on a line, one possible way is to count the lines of the files, http://unix.stackexchange.com/questions/25344/count-number-of-lines-bash-grep

# echo "INFO: It looks like altogether we found: $CORPORA_NUMBER corpora."

##############################
##############################
echo "      These corpora exist across the following ${#LANGUAGE_ID[@]} languages: ${LANGUAGE_ID[*]}"
echo

##############################
##############################


##############################
#RAW Wikipedia Counting
##############################
echo "INFO: Let's do some quick UnicodeCounts on the raw wikidata."

## If I want UnicodeCCounts of the RAW Wikipdedia XML file then I need to do that here.
#For each sub-sub folder in Wiki-Data (Wiki-data/xyx/xy/FILES-TO-BE-CAT) cat the files and give me a count.
#Said another way give me a list of the parent folders of xyz list of files.
#find * -iname 'wiki_*' \-type d -exec basename {} \;
#
#uniq
#
#| rev | cut -d '/' -f2 | rev
#
#for i in $(find * -iname 'wiki_*') ; do
#	LANG_CODE=$(pwd | rev | cut -d '/' -f2 | rev)
#	WIKI_RAW=$(raw-corpus-wikipedia-${LANG_CODE})
#	cat wiki_* > ${WIKI_RAW}.txt
#	UnicodeCCount ${WIKI_RAW}.txt > ${WIKI_RAW}.tab
#
#csvfix read_dsv -s '\t'

##############################
##############################


##############################
#Intergrate Wikipedia cleaing python script
##############################


echo "INFO: For the Wikipdia dumps which have been extracted, we are pulling the article titles and the article contents out."
echo "      This might take some time as we use a small python script tocycle through some of the larger corpora."

# Find all language folders
# into each of the language's sub-folders copy the python code.
#


# The Python code

# Embed the python code in the bash script so that it creates a new python script.


cat << EOF > wiki_extractor_cleaner.py
#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
@author: Matt Stave
Date Authored: Thu Apr 30 23:43:48 2015
Modified by: Hugh Paterson
Date Modified: Sat Jun 06 22:14:00 2015
License: GPL 3.0
License info: http://www.gnu.org/licenses/gpl-3.0.en.html
Use: From the commandline type: wiki_extractor_cleaner.py <theinfilename> <theoutfilename>
"""

import pandas
import glob
import os

#I tried to add the non-verbose commands with argparse.
# Generally un successful.  More here: https://docs.python.org/2/howto/argparse.html
# The python extractor script has several falgs.

def make_df(articles):
    #make a data frame from the list(s)
    df = pandas.DataFrame(index = range(len(titles)))
#    df['title'] = titles
    df['article'] = articles
    return df

#get all files in directory and put them into a big list
#Adjust path to find containing folder

path = os.getcwd()
filelist = glob.glob(path + '/wiki_*')
content = []
for item in filelist:
    with open(item) as f:
        subcontent = f.readlines()
    content = content + subcontent

#content = content[:2110]

titles = []
articles = []
i = 0
while i < len(content):
    #skip <doc> type lines
    if content[i][0] == '<':
        print('skip', content[i][0], i)
        i += 1
        #keep text lines
    else:
        #first should be the title (then skip two lines to get to article text)
        titles = titles + [content[i]]
        print('title', content[i][0], i)
        i += 2
        art = []
        #go through each line and get the text till you reach a newline
        while '\n' not in content[i][0]:
            art = art + [content[i]]
            print('article', content[i][0], i)
            i += 1
            print i
        if art == []:
            art = ['NOARTICLE']
        if len(art) > 0:
            art = [' '.join(art)]
        articles = articles + art
        i += 1

wiki = []
for i in xrange(len(articles)):
    wiki += [titles[i]]
    wiki += [articles[i]]

ISO_639_3code = os.path.split(os.path.dirname(path))[1]
with open("ori-" + "corpus-" + "wikipedia-" + str(ISO_639_3code) + ".txt", 'w') as out_file:
    out_file.write('\n'.join(wiki))
EOF

# Give write permissions to the python script
chmod 755 wiki_extractor_cleaner.py

# If I wanted to call the python script directly I could
#./pyscript.py

# For every file which is extracted by the fist script, this script needs to go behind and make a new output. These new outputs will need to have a new name.
# The following code needs to be modified.
for i in $(cat "$INITIAL_STATS_TITLE"-list-csv.txt);do
	echo "Transposing CSV files via Python."
	cp "$i" ${i/%.csv/-ori.csv}
	python wiki_extractor_cleaner.py "$i" ${i/%.csv/-transpose.csv}
	mv ${i/%.csv/-ori.csv} ${i/%-ori.csv/.csv}
done

# Let's git rid of that python file so it doesn't do anything else.
#THIS needs to be done in every folder.... Better do this with a find+for loop.
rm wiki_extractor_cleaner.py


##############################
##############################

##############################
#Report all the languages used via table
##############################

#Use the Printf command from jonathan


##############################
##############################
