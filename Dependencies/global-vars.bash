##############################
# Variables for Directories
##############################

# http://stackoverflow.com/questions/10823635/how-to-include-file-in-a-bash-shell-script


SCRIPT_NAME="awesome-script.bash"
AUTHORS="Hugh Paterson III, Jonathan Duff"
VERSION="0.02.5"
LICENSE="GPL"

# Set to root folder of project
HOME_FOLDER=`pwd`

##############################
# Variables for directories
##############################

# Variables for Corpora versions and Source Data

DIR_JAMES_DATA=Data-Source/Data-James # This variable needs to be updated in the clean-up script. I wish there was a way to reference these variables from that script.
DIR_WIKI_DATA=Data-Source/Data-Wiki
DIR_KEYBOARD_DATA=Data-Source/Data-Keyboard #This folder is actually a sub-module and is imported by git.

# Variables for UnicodeCCount output

DIR_INITIAL_STATS_TITLE=Data-Derived/Initial-Stats
DIR_SECOND_STATS_TITLE=Data-Derived/Second-Stats
DIR_THIRD_STATS_TITLE=Data-Derived/Third-Stats


DIR_TYPOGRAHICAL_CORRECT_DATA=Data-Derived/Typographically-Clean-Corpora
DIR_CLEAN_AND_POSSIBLE_DATA=Data-Derived/Typo-Clean-And-Possible-To-Type-Corpora
DIR_TEC_FILES=Data-Derived/TECkit-tec-Files

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

# List of the file names of the Data files (corpora and keyboards).

JAMES_LIST_FILE=Temp-Files/Input-Files-Lists/James-list.txt #This is a file list of the James Corpus files.
JAMES_LIST_FILE_FP=Temp-Files/Input-Files-Lists/Full-Path-James-list.txt #This is a file list of the James Corpus files with their full paths relative to the home folder.
WIKI_LIST_FILE=Temp-Files/Input-Files-Lists/Wikipedia-list.txt #This file contains the file names of the Wikipedia data dumps.
WIKI_LIST_FILE_FP=Temp-Files/Input-Files-Lists/Full-Path-Wikipedia-list.txt #This file contains the file names of the Wikipedia data dumps with their full paths relative to the home directory.
# OTHER_LIST_FILE= # This is for other corpora to be added in a later version. (some where around v. 0.9.8)
CORPUS_LIST_FILE=Temp-Files/Input-Files-Lists/Corpus-list.txt #This file is a list of all corpora (James + Wikipedia # + other)
KEYBOARD_LIST_FILE=Temp-Files/Input-Files-Lists/Keyboard-list.txt #This file lists all the keyboard files. Included are .kmx, .keylayout, .kmn, (and perhaps more) other blocks which reference this file need to take into account that there are multiple file types in this file.
KEYBOARD_LIST_FILE_FP=Temp-Files/Input-Files-Lists/Full-Path-Keyboard-list.txt # This file lists all the keyboard files with their full path relative to the home directory. Included are .kmx, .keylayout, .kmn, (and perhaps more) other blocks which reference this file need to take into account that there are multiple file types in this file.

# List of all languages used in the data processing
LANGUAGE_LIST_FILE=Temp-Files/Languages-Used/Language_ID.txt # This file is for all languages, not just one of the three arrays.
CORPORA_LANGUAGES=Temp-Files/Languages-Used/Corpora_Languages.txt
JAMES_LANGUAGES=Temp-Files/Languages-Used/James_Languages.txt
WIKI_LANGUAGES=Temp-Files/Languages-Used/Wikipedia_Languages.txt
OTHER_CORPORA_LANGUAGES=
KEYBOARDS_LANGUAGES=Temp-Files/Languages-Used/Keyboard_Languages.txt

CMD_UNICODECCOUNT=UnicodeCCount

KEYBOARD_FILE_TYPES=Dependencies/Settings/Keyboard-File-Types/Keyboard-File-Types.txt # This file is externally maintained and imported to help this application determine if there are keyboard file types which need to be searched for.

DATA_TYPE= # This should be an array made dynamically from various attributes of the data types. We have Keyboards, and each type of corpora. This array should motivate the tables in the display output.
CORPUS_TYPE= # This needs to be dynamically determined and then added to an array. Should be like Data_type but only an array.

# Used to set Table column headers:
HEADER_COLUMN1=James
HEADER_COLUMN2=Wikipedia
HEADER_COLUMN3=Keyboards
HEADER_COLUMN4=Languages
