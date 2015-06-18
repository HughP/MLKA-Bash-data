#!/bin/bash
# Dependency check should be moved to its own script and sourced.
# Dependencies (software) and (data) should each be added into their own folder

##############################
# Dependencies Checks
#1. Check for software/scripts
#2. Check for critical data-files
##############################

# Check for software and make sure it it is in path
# Command line dependencies are maintained in a seperate file (dependencies.data). Within that file the following order is used in a pipe seperated format.
#x:: thing to use the 'type' comman on.
#y:: success message
#z:: Failure message

###################
# Commandline tools used as dependencies
###################

IFS=$'\n'
for i in Dependencies/Software/dependencies_commandline.data; do #Can this file name be converted to a variable?
x=($(csvfix read_dsv -csv -smq -s '|' -f 1 Dependencies/Software/dependencies_commandline.data ))
y=($(csvfix read_dsv -csv -smq -s '|' -f 2 Dependencies/Software/dependencies_commandline.data ))
z=($(csvfix read_dsv -csv -smq -s '|' -f 3 Dependencies/Software/dependencies_commandline.data ))

unset $IFS
	for (( i=0; i < ${#x[@]}; i++ )); do
	#The above code lets me put in the sequential number of the dependency check. So if I wanted to give each check an number I could.
	    if type ${x} &>/dev/null; then
	        echo -e $(eval "echo ${y[$i]}")
	    else
	    	echo
	        echo -e $(eval "echo ${z[$i]}")
	        echo
	        exit 1
	    fi
	done
done

###################
# Python modules used as dependencies
###################

IFS=$'\n'
for i in Dependencies/Software/dependencies_commandline_py.data; do
x=($(csvfix read_dsv -csv -smq -s '|' -f 1 Dependencies/Software/dependencies_py.data ))
y=($(csvfix read_dsv -csv -smq -s '|' -f 2 Dependencies/Software/dependencies_py.data ))
z=($(csvfix read_dsv -csv -smq -s '|' -f 3 Dependencies/Software/dependencies_py.data ))

unset $IFS
	for (( i=0; i < ${#x[@]}; i++ )); do
	#The above code lets me put in the sequential number of the dependency check. So if I wanted to give each check an number I could.
	    if python -c ${x} &>/dev/null; then
	        echo -e $(eval "echo ${y[$i]}")
	    else
	    	echo
	        echo -e $(eval "echo ${z[$i]}")
	        echo
	        exit 1
	    fi
	done
done


# External Libraries, setings, and data tables should be souced to other .bash files.

# Fetch wikipedia-extractor
if [ -f Dependencies/Software/wikipedia-extractor/WikiExtractor.py ]; then
    # Control will enter here if FILE does NOT exist.
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
    echo "         You should clone Wikipedia-Extractor into the Dependencies/Software folder."
    echo
    exit 1
fi

# Check for critical data-files

# Check for the ISO 639-3 code set data file; Someday we might prompt the user to update this, or better yet to automatically check.

THE_COUNT=0
for i in $(find * -path \*Dependencies/Data/* -iname 'iso-639-3*.tab'); do
    (( THE_COUNT = THE_COUNT + 1 ))
done

case $THE_COUNT in
    0)
        echo "INFO: In order to organize the data we need the proper ISO 639-3 code tables."
        echo "      The 'Complete Code Tables Set' are published as a .zip file here:"
        echo "      http://www-01.sil.org/iso639-3/download.asp"
        echo
        echo "      It looks like you need to get the ISO 639-3 tab file which is included"
        echo "      in UTF-8: iso-639-3_Code_Tables_*.zip file"
        echo
        echo "      The specific file you need is the generic looking one with the format:"
        echo "      iso-639-3_YYYYMMDD.tab"
        echo
        echo "      You should copy this .tab file into the directory:"
        echo "      $HOME_FOLDER/Dependencies/Data"
        exit 1
        ;;
    1)  echo "INFO: Well it looks like you already have the ISO 639-3 Code table available and it is in the appropriate location."
        ;;
    *)  echo "! ERROR: There appears to be too many files in the $HOME_FOLDER that match:"
        echo "         iso-639-3*.tab"
        echo
        echo "         Please have only one ISO 639-3 file."
        exit 1
esac


# Check for Keyboard File Types list.

if [ -f $KEYBOARD_FILE_TYPES ]; then
    # Control will enter here if FILE does NOT exist.
    echo "INFO: It looks like you already have $KEYBOARD_FILE_TYPES in place."
    echo "      That great news!"
    echo
else
    echo
    echo "! ERROR: We were being diligent. We were looking for some keyboard files."
    echo "         To do that we need the file types of keyboard files. We have a nice list on github. Please install it."
    echo
    echo "         You need to install:"
    echo "         git clone https://github.com/HughP/Keyboard-File-Types.git"
    echo "         You should clone the Keyboard-File-Types repo to the the directory above your current working directory for $SCRIPT_NAME. Our script will look for the file there."
    echo
    exit 1
fi

# Check to see if the keyboard data folder is not empty. This folder is a submodule. But it might not have anything in it if the person did not download things correctly.

if [ "$(ls $DIR_KEYBOARD_DATA )" ]; then
    # Control will enter here if FOLDER does NOT exist.
    echo "INFO: It looks like you already have $DIR_KEYBOARD_DATA in place."
    echo "      That great news!"
    echo
else
    echo
    echo "! ERROR: We were being diligent. We were looking for some keyboard data files."
    echo "         To do that we need the keyboard files. We have a nice set on github. Please install it. Generally it is installed as a submodule."
    echo
    echo "         You just put in the following command and get all the software in one download."
    echo "         git clone --recursive https://github.com/HughP/MLKA-Bash-data"
    echo
    echo "         You could get this as an independent repo (but this is disprefered, see option 1 for the prefered method):"
    echo "         git clone https://github.com/HughP/MLKA-Keyboards.git" 
    echo
    exit 1
fi

##############################
##############################
####### Action Point  ########
##############################
# Need a REPO for phonoloy data
# Need a Repo for Previous stats projects
##############################
##############################


# The following dependencies might be needed. However their integration is not completed until we actually use them.
#We might want to consider dependencies for carpalx.
#We might need to add KMFL and the Plaso-Python dependencies.
##############################
##############################