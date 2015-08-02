#!/bin/bash
#########################
# Script Name: awesome-script.bash
# Authors: Hugh Paterson III <email here>
#          Jonathan Duff <jonathan@dufffamily.org>
# Version: 0.02
# License: GPL
# Dependencies are mentioned in detail with links in the README.md file.

# This script has a collection of sub-scripts. These sub-scripts can be run independently or collectively in series by running the master script which ties together the sub-scripts. In this case the ties are all written in bash while some of the other scripts are written in other languages.


##############################
# Project Wide Variables
##############################

# All variables which are used by multible portions of the script are stated in a script called 'global-vars.bash'. The intent is that each sub-portion can call and include 'global-vars.bash'.

# Grab global variables:
source Dependencies/global-vars.bash

##############################
##############################

##############################
# Project Wide Functions
##############################
### (MSG-001-B) HUGH: We can use global functions like this:
### Hugh is noticing that not a lot of use exists for global-functions.bash  do we really need it?
###


# Grab global functions:
source Dependencies/global-functions.bash

##############################
##############################


# Print Program Authors and Version number
echo
echo
echo "Script Name:" $SCRIPT_NAME #This needs updated so that each portion is represented in the variable.
echo "Authors:" $AUTHORS
echo "Version:" $VERSION
echo "License:" $LICENSE

### (MSG-001-C) HUGH: the function can be called and used just like echo
###                   except the function does all the work. Much cleaner
###                   when reading the script.
###				JONATHAN: I need to orally hear this from you. I am not sure I get it.

PrintInfo
PrintInfo "Your data is being processed in the following folder:\n
            \t $HOME_FOLDER"
PrintInfo


# This section just needs to be moved to 'global-vars.bash'.
# The purpose can be to verify that things actually have been loaded.
echo
echo "INFO: Pre-flighting. Setting some of the variables,"
echo "      looking to see if you have the correct"
echo "      dependencies installed, and looking at the"
echo "      corpus data on hand."
echo

##############################
# Project Wide Dependency Checks
##############################

# Grab all the dependency checks:
source Dependencies/dependency-checks.bash

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

# Files to reset everytime the script runs.

################################
#Reset or Create Standard Files#
################################

# Put standard files in the array to remove them. The variables need to be enclosed in double quotes.

reset_file_array=( "$JAMES_LIST_FILE" "$JAMES_LIST_FILE_FP" "$WIKI_LIST_FILE" "$WIKI_LIST_FILE_FP" "$CORPUS_LIST_FILE" "$KEYBOARD_LIST_FILE" "$KEYBOARD_LIST_FILE_FP" "$LANGUAGE_LIST_FILE" "$CORPORA_LANGUAGES" "$JAMES_LANGUAGES" "$WIKI_LANGUAGES" "$KEYBOARDS_LANGUAGES" )

# Need to create directory structure:
# if directory does not exist then create directory
if [ ! -d "$HOME_FOLDER/Temp-Files" ]; then
  mkdir "$HOME_FOLDER/Temp-Files"
fi
if [ ! -d "$HOME_FOLDER/Temp-Files/Input-Files-Lists" ]; then
  mkdir "$HOME_FOLDER/Temp-Files/Input-Files-Lists"
fi
if [ ! -d "$HOME_FOLDER/Temp-Files/Languages-Used" ]; then
  mkdir "$HOME_FOLDER/Temp-Files/Languages-Used"
fi

RESET_FILE_COUNT=0
for i in ${reset_file_array[@]};do
	if [ -f ${i} ]; then
 	   # Delete the file
 	   rm -f ${i}
 	   (( RESET_FILE_COUNT = RESET_FILE_COUNT +1 ))
 	   echo -e "INFO:\t Reset values in ${i}.\t It was file # $RESET_FILE_COUNT of ${#reset_file_array[@]}."
	else
		# Create an empty file if it is not found.
		touch ${i}
 	fi
done

################################
#### End of Standard Files #####
################################

################################
#Reset or Create Standard Folders#
################################

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
#Others - not yet implemented. See notes for version 0.9.8 in the ReadMe.md
##############################

# This portion of the script moves files which may be dropped in the master folder area and puts them in appropriate folders.
source Dependencies/data-moves.bash

##############################
##############################

# This section does....
source Dependencies/source-data-stats.bash

##############################
#Create Language IDs from James
##############################

# Generate the LANGUAGE_ID Variables.
# This step looks through the James corpus texts and pull out
# the last three characters of the corpus texts.

# It needs to deal with the wikipedia and the keyboard files.


# James_Languages.txt is a file for just recording the languages I have for the corpora of James.
for i in $(cat $JAMES_LIST_FILE); do
    expr "/$i" : '.*\(.\{3\}\)\.' >> $JAMES_LANGUAGES
done

# Take the languages from James and add them to the master language list.
echo $(cat $JAMES_LANGUAGES)
for i in $(cat $JAMES_LANGUAGES);do
	grep -Fxq "$i" $LANGUAGE_LIST_FILE || echo $i >> $LANGUAGE_LIST_FILE
	grep -Fxq "$i" $CORPORA_LANGUAGES || echo $i >> $CORPORA_LANGUAGES
done

# This section needs to be modified and allow the arangement of info
# to be corpus by type: Wikpedia/James or Language Navajo/ibgo

JAMES_LANGUAGESString=$(cat $JAMES_LANGUAGES | tr "\n" " ")
JAMES_LANGUAGES_ARRAY=($JAMES_LANGUAGESString) #There is a bug here (or at least a bad programming practice). The file veriable has one name and the same name is used later for a different meaning. Fixed on 15 July 2015 by adding "_ARRAY at the end of the variable name".

## These are not reading as arrays. Rather they are reading as literals or paths OR they are reading as just the first line of the file.
echo "INFO: It looks like altogether we found: ${#JAMES_LANGUAGESString[@]} James based corpora."
echo "      Including the following languages: ${JAMES_LANGUAGES_ARRAY[*]}"
echo


##############################
##############################

source Dependencies/wikipedia-process.bash


######
# Jonathan\'s Language look-up table needs to go here.
######

exit;1


### (MSG-008) HUGH: The displaying of the table is handed off to a function
###                 called DisplayTable. Does not fully work at the moment.
### row 1:
### $COLUMN_ARRAY_1[1], $COLUMN_ARRAY_2[1], $COLUMN_ARRAY_3[1], $COLUMN_ARRAY_4[1]
### row 2:
### $COLUMN_ARRAY_1[2], $COLUMN_ARRAY_2[2], $COLUMN_ARRAY_3[2], $COLUMN_ARRAY_4[2]
### A simple for loop could list the entire table...
###
###

EXAMPLE_TABLE_ARRAY1=( $(cat ${JAMES_LANGUAGES[*]}) )
EXAMPLE_TABLE_ARRAY2=( BBB BBB BBB BBB BBB BBB )
EXAMPLE_TABLE_ARRAY3=( CCC CCC CCC CCC BBB BBB )
# Problem: the output of the 4th array is only the union of the first and the fouth arrays.
EXAMPLE_TABLE_ARRAY4=( $(cat $LANGUAGE_LIST_FILE) )

DisplayTable EXAMPLE_TABLE_ARRAY1[*] EXAMPLE_TABLE_ARRAY2[*] EXAMPLE_TABLE_ARRAY3[*] EXAMPLE_TABLE_ARRAY4[*]

######
######


##############################
#Create CSV counts of counted files.
##############################
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

# Create a list of just the CSV files.
ls -A1r *${INITIAL_STATS_TITLE}*.csv | sort -t - -k 7 > "$INITIAL_STATS_TITLE"-list-csv.txt

##############################
##############################


##############################
#Create transposed CSV Files
##############################
# It is possible that this whole section might be simplified by using the code mentioned in the forum here: CSV fix here: https://groups.google.com/forum/#!topic/csvfix/2hgr8j9dmbo

# Let's transpose the CSV files so that CSVfix can drop a table so that we can use PYgal to create a chart.

# Embed the python code in the bash script so that it creates a new python script.
# Call the python code from: /Dependencies/Software/CSV-transposer/csv_transposer.py
# Use: From the commandline type: csv_transposer.py <theinfilename> <theoutfilename>
# If I wanted to call the python script directly I could
#./pyscript.py


# For every file in the list of CSV files, we want to know they are being transposed, copy the files with a new name, then do the transpose on the original file name, Rename the transposed ones, then change the copies back to what they were.

echo "Transposing CSV files via Python."
TRANSPOSE_CSV_FILE_COUNT=0
for i in $(cat "$INITIAL_STATS_TITLE"-list-csv.txt);do
	# $? is the return value from previous command above
	case "$?" in
            0) printf "+"
                (( TRANSPOSE_CSV_FILE_COUNT = TRANSPOSE_CSV_FILE_COUNT + 1 ))
                ;;
            1) printf "!"
                ;;
            *) printf "*"
        esac

	cp "$i" ${i/%.csv/-ori.csv}
	python csv_transposer.py "$i" ${i/%.csv/-transpose.csv}
	mv ${i/%.csv/-ori.csv} ${i/%-ori.csv/.csv}
done

# Let's git rid of that python file so it doesn't do anything else.
rm csv_transposer.py

##############################
##############################

##############################
# Create PyGal graphs of character frequencies based on transposed CSV files
##############################

find * -maxdepth 0 -iname "*transpose*.csv" | sort -t - -k 7 > "$INS_TRANSPOSED"-list-csv.txt


for i in $(cat "$INS_TRANSPOSED"-list-csv.txt);do
#  csvfix remove
#  remove some extra line in the file.
#  ingest each line as a seperate array?
#  echo each array in the format in the pyfile template for pygal?
#
#  OR
#
#  Hand craft the first pygal SVG chart and then turn this SVG into a CSV file via csvfix XML command. Then create the SVG template file.
#
#  import pygal                                                       # First import pygal
# from pygal.style import BlueStyle
# chart = pygal.StackedLine(fill=True, interpolate='cubic', style=BlueStyle)
#
# bar_chart = pygal.Bar()                                            # Then create a bar graph object
# bar_chart.add('Fibonacci', [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55])  # Add some values
# bar_chart.add('Fibonacci', [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55])  # Add some values
# bar_chart.render_to_file('bar_chart.svg')                          # Save the svg to a file
#
#
# FIND a SVG to .jpg or .png application. See discussion here: http://superuser.com/questions/134679/command-line-application-for-converting-svg-to-png-on-mac-os-x


#List of plots to create: differences of total characters in each phase of the text clean up process.
#for each result (flag) of the UnicodeCCount output compare with the previous results, and also for each phase of the procss compare with previous results.

##############################
##############################


##############################
# Create gnuplot graphs of character frequencies based on CSV files
##############################
# http://stackoverflow.com/questions/14871272/plotting-using-a-csv-file
# Look at these other options too: http://www.gnu.org/software/plotutils/
# http://ploticus.sourceforge.net/doc/welcome.html
#ascii_chart: http://biolpc22.york.ac.uk/linux/plotutils/#Sample
#http://linux.byexamples.com/archives/487/plot-your-graphs-with-command-line-gnuplot/
##############################
##############################


#prepending became an issue here: http://unix.stackexchange.com/questions/56975/whats-the-command-to-prepend-a-line-to-a-file

#Create .md of counts.
echo
echo "INFO: Everybody on Github likes to read Markdown."
echo "      So we're making some markdown tables from"
echo "      the CSV files."
echo


#for i in $(cat "$INITIAL_STATS_TITLE"-list-csv.txt); do
##    | csvfix write_DSV "$i" -o ${i/ /}.md
#done

for i in $(cat $LANGUAGE_LIST_FILE);do
	ls -A1r *Intial_Stats*"$i"*.csv > Intial_Stats-"$i"-list-csv.txt
done

##trying to cat a header to the .md files then do a something to the header.
#
##"#${i/ /}"

##############################
##############################


##############################
#Alternate code by Jonathan D.
##############################
#Hugh did not institute this imediatly because he found the CSVfix method of creating the .md files without TECKit. But there are some other interesting things about Jonathan\'s approach which might be useful. This needs more consideration. Imediate questions are: why capitalize variable "$i"? Second question, what should I be thinking about when to move the working directory?
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
#The /James/"$i" solution was not really viable for Wikipedia data. Corpus_lits_file should have more than just james texts by this point. This is partiall dependent on getting the Wiki-data folder connected.
for i in $(cat $JAMES_LIST_FILE); do
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



##############################
#Create digraph count
##############################

############
############

cat << EOF > digraph_counter.py
#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
@author: Hugh Paterson III, Matt Stave
Date Authored: Thu Mar 26 09:31:44 2015
License: GPL 3.0
License info: http://www.gnu.org/licenses/gpl-3.0.en.html
Use: From the commandline type: digraph_counter.py <theinfilename> <theoutfilename>
"""

""" I need to set this text to open a file and read it, or recive from bash "cat" command """
text = """Mh;emh;e iJemhisi ni mhi khi ;oni ;o;o ga ;oyi ;Eshin;egba ali ;oyi iJesu iKirisiti ;On;omhu;e mhia k;ek;e ebe ona ghi ;egb;o eni e miesu;o, ni ;e la ;ed;eli igb;eva eyi ;egb;o iZir;eni, ni e gbhiaku elemhi ek;e agb;o nya. Mhi ts;e ;e. Iny;oghuo--mh;e, leli ;oli shi emhi ogh;el;e ini imuf;e ;od;oda e bhale deb;e. Irari khi u l;es;e khi ini a da mu irudunga oy;e f;e bino ne, iregbemie oy;e o ya m;e asha fu--a shi ;o. Zob;e ni iregbemie oy;e;e o gbe akanya oy;oli pfo, ni a mh;oli iwomh;eloe, ni o gba pfo, ni a khi eni ingeli enete ;ea baku. Ama ini ;ong;e;e ;o;o nono ;egbhali, ;o mhila ;Eshin;egba ni ;o pfo elemhi r;o ;o na ;ogb;okpa, ni ;oa ya m;e umha--gu;ekia oyi ;ogb;o. ;O ya r;oli na li. Ama ini ;o;o mhila, ;o mh;oli irudunga ni ;oa mhu;e akh;okh;omh;e, irari khi ;oni mh;oli akh;okh;omh;e, eri ;o li abi izughuse oyi ok;e oni;emhi ni akpekpeli o pfi ;e kia. ;Ogb;o ;ogh;ogh;o ;o khi sa khi l;oli m;e emhikh;oghuo ya mie ob;o oyi ;On;omhu;e. ;Ogb;o ;ozidu eva ;o khi, ;oa ya ri;el;e emini o mu am;e. Eni e mie iJesu iKirisiti su;o ena umham;e e ke gh;el;e irari khi e ma ghal;e ukp;eloe oyi ;Eshin;egba. Igbaa oyi eni e mie iJesu iKirisiti su;o ni e pfue, e ke gh;el;e ini agb;o o ke ti w;e tiemhile. Irari khi eri ;epfue e ta a kua abi udodo. Irari khi ini ov;o o ngale khi ;o;o to, eri ;o;o tos;e ebuli a, e khakha--a, idodo ey;ew;e e de kua, isomhotse ey;ew;e o yese a. Igh;o, ;oni ;o pfue ;o li ya ta kua, abi ;o li na ya nga na ya tiemhi shi akanya oy;oli. Ikhiv;os;e o khi na ;ogb;o ni ;o kie migha ini ;o mh;oli imuf;e, irari khi ini ;o dob;e ri egbe mie, ;o ya mie arula oghie oyi agb;o na agb;oagb;o, ni ;Eshin;egba ;o she shob;o khi l;oli ya r;o na eni e nono ingme oy;elu;e. Ini a mu ;ogb;o ligh;o f;e bino, ;o khi li;e khi, ";Eshin;egba ;o mu mh;e ;e f;e." Irari khi ;ogb;o ;oa ri onobe ya dob;e mu ;Eshin;egba f;e, w;ekhi eri l;oli ;o mu ;ogb;okh;oghuo ;e f;e bino. Ama ;oghu;emh;e eyawa ni e di awa mu, e ri awa mh;oli imuf;e. ;Egh;egh;e agh;o oni ;oghu;emh;e o kha m;e, o bia olamh;e, ini olamh;e o fu, khi o t;e, o bia eghuli. Iny;oghuo--mh;e a khi z;e ni a di ;e. Isomhi--opfa onete kpa ni o gba pfo, idane o te bhale, obini oyi Ita ni ;o ma ikpa na idane, o r;ote ;e tiemhile. ;Oni ;oa ya mu pfi abi aroro ni ;o;o je oola je oob;o. ;Oghu;emh;e oy;oli ;o r;o ri ungmemhi ig;esikia oy;oli ri awa bhale agb;o, ini ;o m;e asha ri awa khi im;omhi eni odod;e elemhi emini o ma nya. A sato ona iny;oghuo--mh;e, ;ogb;okpa ;o k;el;e ke su;o ungmemhi, ama ;o khi k;el;e ke ngme unu, ;o khi gbo k;el;e ke mhu;e elemhi ibibi. Irari khi elemhi ibibi oyi ;ogb;o ;oa ri ;ogb;o ;o mh;oli igu;e--ngeli oyi ;Eshin;egba Irarigh;o, a ti egbe ingeli ichimhi--a ali ingeli ingmobe ni e sha ;e ma--a. A ri egbe ;e tiemhile na ;Eshin;egba, a ri ;eloe shi ungmemhi oy;oli, ikhi oni a r;o k;o ;e udu, ni o dob;e ya mie ;e pfuese. A khi khi eni e l;es;e ri es;o su;o ts;e ni ;e;e di egbe w;e, a ri ochogh;o ke ri emini a su;o gbe akanya. ;Oni ;o ri es;o su;o oni ungmemhi ni ;oa ri;el;e emini o ngme, eri ;o li abi ;oni ;o l;e ya bino egb;oli ughegbe abi l;oli li. ;O kha bino egb;oli se, ;o vu agh;o le, agh;oagh;o ;o yele abi ;o li--a. Ama ;ogb;o ni ;o bino elemhi ushi ni o gba pfo ni ;o;o rue ;ogb;o ;o le, ni ;o kiele ;e ri;el;e emini o ngme, ni ;oa yele--a abi oni ushi o ngme, a ya khiv;os;e na li emiemini ;o;o ri;el;e kpa. Ini ;ong;e ;e ;o rue egb;oli khi ;ona ugamhi l;oli khi, ni ;oa r;o lolo mu ;el;emhi oy;oli mhu;e kp;è, egb;oli ;o;o di. Ugamhi afu;e ;o;o ga. Ugamhi ni o pfuas;e ni ;oa mh;oli ifue ni ;Eshin;egba Ita awa ;o;o mie l;oli o khi, ni u r;o ri ukp;eloe khu imi--olimhi ali esamhi--olimhi ini ;e;e m;e osoli. Ali ni ;ogb;o ;o mu egb;oli ini agb;o o khi ri ichimhi mu ;oli. Iny;oghuo--mh;e, ini u mie iJesu iKirisiti ;On;omhu;e ;oyawa ni ;o mh;oli ufumhi oni;emhi su;o, a khi ri;el;e khi ;onana ;o kpe mh;e n;e. Ini a f;e bhale ya ;e khi ;ogb;o ni ;o pfue ni ;o s;o ukp;ekhuli oyi igolu ali ide eni e somhotse, ;o lo ilegba oy;e;e le, ali ni a r;o gbo m;e khi ;ona umham;e ;o s;o ij;ej;e ide li lole. Ini u ri ekp;e na ;oni ;o s;o itsua ni e somhotse n;e, ni u r;o li;e ;oli, "Bhale ya shit;o ashini o ti n;e," ni u r;o li;e ;ona umham;e, "Migha oob;o," okekhia khi eri u w;e ;oli, "Shit;o ek;ekh;e epf;e aw;e ey;emh;e." O f;e ti gh;o? Aa she ri;el;e az;ol;omh;e deba egbe ;e egh;o? Aa gbolo ri isamhi ebe ;e gue egbe ;e ;ez;o egh;o? A ri es;o shi mh;e ek;e iny;oghuo--mh;e, ;oa khi eri ;Eshin;egba ;o she z;e ena umham;e ukp;eloe agb;o, ni e mh;oli ;epfue oyi irudunga, ali ni e mh;oli okemhi shi ugu eghiele ni ;o r;o shob;o na eni e nono ingme oy;oli? Ama u she m;e ena umham;e bie. ;Oa khi eri eni ;epfue e li ;e le? ;Oa khi w;ew;e e r;e ;e ye ik;otu? ;Oa khi w;ew;e ;e ri unu ;e yese eva onete oyi iJesu iKirisiti--a ;oni a kugbe ;o? Onete wa ri;el;e ini u ri ushi ni o mu egbe n;e nya, ni o la Ebe--no--pfuas;e gbe akanya, ni ;o;o, "Nono ingme oyi ;onuzava oy;e abi u li nono ingme egbe ;e." Ama ini u ri;el;e az;ol;omh;e, u she lamh;e, ushi o gbo pfa ;ez;o mu ;e khi ;oni ;o gbe ushi--a u khi. Irari khi ;onini ;o da ri ishi nya ghu;e ni ;o pfi d;o elemhi ushi oghuo ts;e, ishi enekp;ole nya ;o gbe--a. Irari khi ;oni ;o;o, "Khi kia okia." L;oli ;o gbolo ;e, "Khi gbe ugbeli." Ini u wa riri;e kia okia, ni u r;o da gbe ugbeli ne, ;ogbushia u khi. A ke ngme ungmemhi, `a'a ngeli abi ;egb;o eni a ri ushi inono ya gue w;e ;ez;o, ikhi ushi oni o ri ;epfua a na ;ogb;o. Irari khi ;Eshin;egba ;oa ya mh;oli il;elemhi na ;ogb;o ni ;oa ya mh;oli il;elemhi, ;el;e ni ;Eshin;egba ;o r;oli ya gue ;ez;o. Irari khi ini u mh;oli il;elemhi, eri u ya ke gh;el;e ini a r;e ;e gue ;ez;o. Iny;oghuo--mh;e ini ;ogb;o guele khi l;oli mh;oli irudunga, ni ;oa r;o mh;oli ir;o--gbe akanya, onete onoghuo o ya li nali? Imiesu;o ogh;ogh;o ;oa ya dob;e tsumhi ;oli? Ini a f;e bhale ya ;e khi iny;oghuo awa ;oni ;om;ose okekhi ;okpotso ;oa mh;oli itsua ni a s;o ali eminale ni ;o ya le ogb;el;e. Ni ;ong;e ;o r;o guey;e ;oli, "Ke vu, o ya ti n;e, ;Eshin;egba ;o khi z;e ni ulili ali okiamhi o n;e osoli", ni ;oa r;o mh;oli emhi kh;oghuo ni ;o ri;el;e na, ighe onete ni o ri;el;e? Eri o li abin;e khi ;ogb;o mh;oli irudunga ni ;oa r;oli gbe akanya. Irudunga lu;eghuo ts;e ni a ri akanya ma, irudunga oni o ghu--a o khi. Ama a dob;e ya m;e khi ;ogb;o ;o;o li, "U mh;oli irudunga, mh;emh;e mhi guey;e ;oli khi ir;ogbe--akanya mhi mh;oli." Ri irudunga oy;e khas;e mh;e ni ;oa mh;oli akanya igbegbe, mh;emh;e mhi ya ri emini mhi ri;el;e r;o ri irudunga oy;emh;e khas;e ;e. U miesu;o khi ;Eshin;egba ;oghuo ;o khi, oo ti gba. Egbegbi ay;emh;e eyi ;okphaghi;e e mie ona su;o, ;e;e na ulishi, ;e;e gu;o. Y;ey;e ;om;ose ;o;oy;egh;e, eri u wa nono ni a gbo gue ;oli ke y;e, khi irudunga ni ;oa mh;oli akanya igbegbe, khi afu;e o khi? ;Oa khi emini ititawa Aburaamu ;o ri;el;e a r;o r;oli li;e khi ;oni ;o pfuas;e ;o khi, abi ;o r;o ri omi ;oli Aziki luas;e obo ukhomhi at;et;e? U m;e ;oli khi irudunga ali ir;ogbe--akanya oy;oli e ga gbe akanya kugbe, emini ;o ri;el;e o ri irudunga oy;oli gba pfo. L;oli o z;e khi emini Ebe--no--pfuas;e o ngme o r;o bhale ya tse ni ;o;o, "Aburaamu ;o mie ;Eshin;egba su;o, a leli ;oli nali shi ipfuas;e", A lu ;oli ;om;ole ;Eshin;egba. U m;e ;oli egh;o khi emhi ni ;ogb;o ;o ri;el;e a r;o li;e khi ;ogb;o ;ona ipfuas;e ;o khi, ;oa khi irudunga tse ;ogb;o ;o r;o khu;e pfuas;e. Igh;o o gbo li egbe oyi iR'e--`abu ni ;o khi adegbe. Emini ;o ri;el;e o r;oli khu;e pfuas;e odalo oyi ;Eshin;egba. Abi ;o li mu ;egb;o iZir;eni ni e bhale ya t;okp;e ek;e bino epf;ese. Ni ;o gbo kpaghi;e w;e ob;o ni e r;o m;e asha na r;ote od;e oboese vu. Irarigh;o, abi idiegbe ni ;oa mh;oli ay;emh;e o li khi oni ghua, igh;o irudunga ni ;oa mh;oli akanya o li khi oni ghua. Em;ole mh;e, ;e;e nya a khi ya khi eni ;e;e s;es;e, irari khi a l;es;e khi anye ni anye khi eni ;e;e s;es;e ;egb;o, a ri ;ez;o oni o ze n;e nya na ya gue. Awa nya awa mh;oli ashini awa te pfi d;o. Ama ini ;ogb;o ;oa pfi d;o elemhi ungmemhi oy;oli ghu;e, ;ogb;o ;oni ;o gba pfo ;o khi, ni ;o dob;e ;e mh;es;e ni idiegbe oy;oli nya. Eri a s;o achi agh;ekp;e unu ni ;o ke su;o es;o na awa, l;oli o z;e khi awa dob;e nga li ;e je obini o gh;ole awa. Gbo li sa ingme ;ok;o ok;e oni;emhi bino, ashini o gb;edi ramhi egh;o, ni o khia khi akpekpeli oni;emhi o kha ri;e ;e li, ukuku akhuli, ;oni ;o;o gua li ;o r;o mu ;oli ukhomhi ;e pfi je obiobini o gh;ole ;oli. Igh;o ;el;emhi o li li. Ashini o sh;e ramhi elemhi idiegbe oyi ;ogb;o, o ma pfi okhorobo. Sa ;o ghue, abi ukuku akhuer;e o li;e ma er;e osha. Eri ;el;emhi o li abi erali. Emhi obe o khi ni o la elemhi idiegbe ;ogb;o. Eri ;o;o yese ;ogb;o--a nya od;e khi od;e. Ilimhi iri;eri;e oni erali ogh;o o te bhale ;el;emhi. Elamhak;o nya e z;e ;e mu ab;o, ghe ipfeli o, ghe eni ;e tial;o akpidi ek;e o, ghe elamhak;o ena ok;e o, ;ogb;o ;o dob;e ;e mu w;e ab;o. Ama ;ogb;o kh;oghuo ;oa dob;e ya mu ;el;emhi ab;o. Eri o li abi osu;e ;eny;e ;obe ni ;o;o gbe. Oni ;el;emhi awa r;o ;o ku;eghi;e Ita awa ;On;omhu;e. L;oli awa gbo r;o ;o ku its;e na ;egb;o ni a r;o kh;okh;o ;Eshin;egba ma. Iku;eghi;e ali its;e ikuku e r;ote unu oghuo ;e lasele. ;Oa kha khi igh;o iny;oghuo--mh;e. Am;e eni e ti unu ali am;e ni ;ea ti unu ;ea dob;e ya r;ote unupfie oyi ok;e oghuo ke ch;och;o lasele. Iny;oghuo--mh;e, ;okhua--eni o f;e dob;e ya m;o udumhi olivu? W;ekhi eri olomu iba o dob;e ya m;o udumhi ;okhua--eni? Igh;o ok;e oni ;o;o ch;och;o am;e ugbheli, ;oa dob;e ri am;e eni e ti unu ya lasele. ;Oghuo ;o elemhi ;e ;o khi ;ots;egbh;e ni ;o mh;oli il;es;e? ;Oni ;ogb;o ;o ri angeli onete oy;oli r;oli khas;e, ikhi onete ni ;o ri iregbe--tiemhile ni o r;ote il;esingme bhale ri;el;e. Ama ini u mh;oli ay;emh;e ub;ogb;o ali emhi--itoegbe shi udu oy;e, khi vuse ipfua shi ;o, ni u r;oli kie oni ig;esikia. Il;esingme ogh;ogh;o ;oa khi iloghie o te bhale, ama onayi agb;o ona o khi, ni ;oa r;ote Ay;emh;e--n;o--pfuas;e bhale, elemhi ay;emh;e oyi ;okphaghi;e o te lasele. Ashini ub;ogb;o ali emhi ituegbe o da la ne, ozughu ali emhi ebe ;od;oda, e ma la akagh;o. Ama ;egbh;e ali il;es;e ni o te idane bhale, eri o kp;e te ek;e pfuas;e, o nono opf;omh;e. Eri ;o;o kuegbe--a, o ri egbe ;oli ;e tiemhile na ;ogb;okpa pfo, o mh;oli elemhi--iamh;e, o ri um;omhi angeli onete ;e khas;e. ;Oa ya gbe az;eba, o mh;oli ig;esikia. Eni ;e nono opf;omh;e ni e ri ay;emh;e opf;omh;e ri onete k;o, ikhi;es;e oyi ipfuas;e ;e;e m;e. El;o ;o;o pfi okh;oli ali uwola a na ;e? ;Oa khi itob;o ;oghu;emh;e, ni e la ;e udu nu ;e a kh;oli o z;e ni a r;o nu egbe ;e kh;oli? Emhi ;o;o gh;ole ;e, ama aa mh;oli ;oli. A gbe ugbeli, a mh;oli ;eloe--iamh;e ama a dob;e mh;oli emini ;e;e gh;ole ;e. A kha wola, a kh;oli. Aa ya mh;oli emini a nono, irari khi aa mhila ;Eshin;egba. A kha mhila, aa ya m;e mie, irari khi usamhi obe a r;o shi udu ke mhila, ini a ba m;e asha ri emini a mhila r;o li agb;o shi egbe. ;E;e ni a khi ;egb;o ni e li abi ;okpotso ni ;o;o kia okia, eri aa l;es;e khi ini emhi agb;o o gh;ole ;e d;os;e, khi ;obe ;Eshin;egba a khi? ;Onini ;o da z;e agb;o ona ;om;ole ne, ;obe ;Eshin;egba ;o khi. Eri u dabi khi afu;e Ebe--no--pfuas;e o ngme ;oli khi, eri ay;emh;e ni ;Eshin;egba ;o r;o shi awa egbe ;o;o kpe ofuma egbegb;o, ni o khia khi eri ;o;o nono ni awa khi ;oyi ;Eshin;egba pfo nya. Ama eri ;Eshin;egba ;o khi ma okhale na awa. Onana o z;e ni Ebe--no--pfuas;e o r;o li;e, "Eri ;Eshin;egba ;o mu okh;oli ;e vule shi ;oni ;o ti egbe ;oli ;e nga ;o. ;O;o somhi elemhi ;oni ;o ti egb;oli ;e tiemhile." Ri egbe ;e tiemhile na ;Eshin;egba pfo nya. Ts;es;e ku ;okphaghi;e ;o ti kia n;e, khi ;o ya na n;e. Ti bhale deba ;Eshin;egba, khi ;o ya ti bhale deb;e. A kpe ab;o ey;e ;e--a, ;e;e ena olamh;e, a ri udu oy;e ;e shi eni e pfuas;e, ;e;e ezidu--eva. Vi;e osoli, vi;e oya, mu egia oy;e mele evi;e--a, u gbo mu ogh;el;e oy;e pfi bhale iyese udu--a. Ti egbe ;e tiemhile odalo oyi ;On;omhu;e, khi ;o ya ti ;e nga. A khi ke yese egbe eva iny;oghuo--mh;e. Ini u da yese ;onuzava oy;e ni a ga mie iKirisiti su;o eva--a ne, ni u r;o da gue ;oli ;ez;o, ushi wa z;e ifue, ni u wa gue ;ez;o. Ini u gue ushi ;ez;o, wa ke khi ;oni ;o ri ushi ;e gbe akanya!! Ama ;oni ;o gue ;oli ;ez;o u ke khi. ;Eshin;egba l;olighuo ts;e ;o khi ;oni ;o rue ushi na agb;o ni ;o;o gue ;ogb;o ;ez;o egbe--a. L;olighuo ts;e ;o dob;e a tsumhi, ni ;o dob;e a gbe--a. ;Oghuo u sa khi u khi ni u wa gue ;ogb;o;ese ;ez;o? A su;o mh;e, y;ey;e ni u w;e, "Amo okekhi ak;o awa ya ye ;eoli ona okekhi ogh;o, awa ya la oob;o elemhi ukpe oghuo, awa la oob;o gbe akanya ona ali ogh;o, awa gbe ukpagh;o tima." Waa l;es;e emini ogbe na ak;o o ngme ne, w;ekhi emini a ya m;e ak;o. S;e u l;es;e abi agb;o oy;e o ya li? Eri u li abi otughunu ;el;e uzogbe ni ;o;o lasele ukuku ;egh;egh;e, o gbo kala--a. Eri u kha ri ochogh;o li;e, "Ini o gh;ole ;On;omhu;e, awa ya la agb;o, awa li ona ali ogh;o." Mena eri u wa tono ob;o udu, waa ti ipfuab;o nga. Itonob;o--udu egh;ogh;o nya ;ea gbe akanya. Irarigh;o, ;onini ;o da l;es;e onete ni ;o kha ri;el;e ni ;oa r;o da ri;el;e ;oli ne, olamh;e o khi na li. Ghe ii, ;e;e eni a pfue, a vi;e, a vi;e oya irari osoli ni ;o;o bhale na ;e. ;Epfue ey;e ;e, e she k;e a, ali khi esele e she r;e ;e ide le. Igolu ali ;elomho ey;e ;e, e she mu ;oghu;oghu;o--a. ;Oghu;oghu;o ni e mu, e ya pfi ;ots;el;e mu ;e, a ya na ;e osoli to ;o irari khi u ti ikpagh;o ma leghe na egbe ;e ya ramhi memena. Waa fali ;egb;o eni e gbe ikanya ishemhi oy;e n;e ifata ne. ;E;e vi;e, ;e;e w;ol;o. Evi;e oyi eni e nu ;e khi;es;e itsua ishemhi, o she ramhi es;o eyi ;Eshin;egba ni ;o fun;e nya ni ;o mhu;e ekh;oli--okhu;e na iloghie.l Eri u la agb;o ;e li agb;o nyafunyafu, u li agb;o ;o tsua kua. Wa le ;okp;o, ali ;of;ol;o, u gb;edi--a l;o;ogh;o abi ;elamhi ni a mu ya gbe--a. U she pfa ;ez;o ugbeli mu ;egb;o eni ;ea mhu;e abi e li, u gbolo w;e--a. W;ew;e na, ;ea dob;e li;e khi w;ew;e a lama shi ;e ;o. Irarigh;o, iny;oghuo, ri ab;o mudu ramhi ibhale oyi ;On;omhu;e. Bino ghue abi ;oghiale ;o li;e migha kh;e ;egh;egh;e ni ishemhi e la bie. Abi ;o li ri ab;o mudu ni otsukpe o de, ni oruam;e o r;o le. Y;ey;e li ligh;o ri ab;o mu udu abi ;oghiale. Lolo ri ukp;eloe shi ek;e, u migha gbagbagba irari khi ibhale oyi ;On;omhu;e o ti bhale. A khi ke m;e umha--gu;eli oyegbe iny;oghuo--mh;e, ini a khi gue ;e ;ez;o. ;Os;o;ez;o ;o ga ti mama awa memena. Iny;oghuo--mh;e, a ke kh;onya emek;eguele ni ;e;e ngme na ;On;omhu;e. Eri e ri ab;o mudu ini o ri;e khi e ya m;e osoli. A she kp;e l;es;e khi eni a khiv;os;e na, anye ;e lu ;egb;o eni e ri egbe ;e mie. A she kpe su;o eko iJobu abi ;o;o ri egbe mie t;es;e. A m;e emini ;Eshin;egba ;o ri;el;e na li ikpukhokho. ;On;omhu;e, ona il;elemhi ;o khi. Iny;oghuo--mh;e, oni o mu egbe n;e nya khi, khi romhi iloghie ali ek;e agb;o ali emhese. Z;e ni, "Ii oy;e o khi ii, u z;e ni iiye oy;e, o khi iiye." Ini a khi m;e asha pfa ;ez;o mu ;e. Ini ;ong;e;e ;o la elemhi ;omunu, ;o lema ;Eshin;egba. Ini ;ong;e;e ;o;o gh;el;e, ;o to uwolo iku;eghi;e. Ini ;ong;e;e ;o;o ghua, ;o ka lu egbhali ni e la igbaa oyi eni e mie iJesu iKirisiti su;o, ni e s;o iromhi na li, e ri eva ;oyi ;On;omhu;e ri oili to ;oli egbe. ;Egh;egh;e agh;o, ni iromhi ni e ri irudunga s;o, ni o ri ;oli z;e. Ni ;On;omhu;e ;o r;ote ughuamhi mu ;oli vule. Ini ;o lamh;e olamh;e, ;On;omhu;e ;o ya r;o topfa li. Irarigh;o, a z;on;o olamh;e ey;e;e ye egbe ;e, a lema na egbe, ni a r;e ;e ze. Eri iromhi oyi ;ogb;o ni ;o la ipfuas;e o migha a gbe akanya egbegb;o. ;Ogb;o onabi awa, Elaja ;o khi. Eri ;o te ekelemhi udu lema egbegb;o. ;O;o am;e o khi ru;e, am;e o mu oni ek;e elemhi ikpe es;e ali ukhukhui. ;O gbo lema, ;o;o am;e o ru;e, am;e o ru;e, ek;e o ri emhi ;ek;omhi z;e lasele. Ini ;ong;e ;e ;o pfi egbegbi od;e oyi ;Eshin;egba shi ek;e, no ;ogb;o;ese ;o r;o mu ;oli nyen;e bhale ukhokho, sato ;o khi, ;onini ;o mu ;ona olamh;e r;ote od;e ;egbh;oli oy;oli pfi, ;o ya tsumhi ay;emh;e oy;oli ob;o eghuli, ;o guese olamh;e ebubu na li.
"""

x = 0

digrams = []

for i in range(len(text)-1):
    digrams = digrams + [text[i]+text[i+1]]

import pandas as pd

digrams = pd.Series(digrams)

s = digrams.value_counts()

#s = str(s)
#This should spit out the kinds of combintations with whatever is in ''.
#[x for x in s.keys() if x[0] == ';']

columns = ['key', 'value']
data = [list(s.keys()), list(s.values)]

d = {'Values':s}

df = pd.DataFrame(d)

print(df)

df.to_csv('digram_list_atg_replacedText2_.txt', sep = '\t')
'''
file = open("digram_list__.txt", "w")
file.write(df)
#file.write(digrams.value_counts())
file.write(len(df))



#file.write(s)

#print (digrams.value_counts(), len(text))
file.close()
'''

EOF

# Give write permissions to the python script
chmod 755 digraph_counter.py

# If I wanted to call the python script directly I could
#./pyscript.py


#######
#End of Digraph count
#######

##create [corpus_type]-[language_code]-[Intial_count] sub-folder
#CORPUS_TYPE=corpus_type
#LANGUAGE_CODE=language_code
#INTIAL_COUNT=intial_count
#NEW_FOLDER=$CORPUS_TYPE-$LANGUAGE_CODE-$INTIAL_COUNT

#####--------------------------------------------------
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
#####--------------------------------------------------
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
