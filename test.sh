#!/bin/bash
#########################
LANGUAGE_LIST_FILE=Temp-Files/Languages-Used/Language_ID.txt # This file is for all languages, not just one of the three arrays.
CORPORA_LANGUAGES=Temp-Files/Languages-Used/Corpora_Languages.txt
JAMES_LANGUAGES=Temp-Files/Languages-Used/James_Languages.txt
WIKI_LANGUAGES=Temp-Files/Languages-Used/Wikipedia_Languages.txt
OTHER_CORPORA_LANGUAGES=
KEYBOARDS_LANGUAGES=Temp-Files/Languages-Used/Keyboard_Languages.txt

# echo 'INFO: It looks like altogether we found: '${#JAMES_LANGUAGES[@]}' James based corpora.'
# echo "      Including the following languages: ${JAMES_LANGUAGES[*]}"
# echo
# 
# cat $JAMES_LANGUAGES | printf 
#  
# printf ${#JAMES_LANGUAGES[@]}
# 
# find $DIR_WIKI_DATA -maxdepth 0 -type d  \( ! -iname ".*" \) >> $WIKI_LANGUAGES


echo $(cat $JAMES_LANGUAGES)
for i in $(cat $JAMES_LANGUAGES);do
	grep -Fxq "$i" $LANGUAGE_LIST_FILE || echo $i >> $LANGUAGE_LIST_FILE
	grep -Fxq "$i" $CORPORA_LANGUAGES || echo $i >> $CORPORA_LANGUAGES
done
