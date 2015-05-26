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
INITIAL_STATS_TITLE=Initial-Stats
SECOND_STATS_TITLE=Second_Stats_
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

#############################
#The first TECkit conversion
############################




teckit_compile ConvertToNFD.map -o NFD.tec
txtconv -t NFD.tec -i combined.txt -o combined-conv-nfd.txt
txtconv -t aff.tec -i combined.txt -o combined-conv4.txt
teckit_compile AfricanKeyboards.map -o aff.tec
teckit_compile Nav-count.map -o aff2.tec



































