#########################
#!/bin/bash

#Hugh Paterson III and Jonathan Duff v.01
print Program Author and Version number

define home_folder as location of project

# cd ~/Multi-lingual\ Keyboard\ Assessment/MLKA/
change to working folder 

 # ls *.txt > corpus-list.txt
list all *.txt file and store results into corpus-list.txt file



# STEP 1 STAGE 1 & 2:

print Starting step 1 stage 1 and 2: generating data

for each filename in corpus-list.txt {
change to home_folder
create [corpus_type]-[language_code]-[Intial_count] sub-folder
change to newly created folder

	run UnicodeCCount with “-d” and store into tmp.txt
rename tmp.txt to Corpus-ori-[corpus_type]-[language_code]-text-[flag].txt
	copy above created file to *.md instead of *.txt
open that file and convert all tabspaces U+0009 to pipes
convert all U+0027 ‘ to \’
EX: #Corpus ori james nav text
	prepend newline with hash then file name in sentence case to *.md file

	run UnicodeCCount with “-c” and store into tmp.txt
rename tmp.txt to Corpus-ori-[corpus_type]-[language_code]-text-[flag].txt
	copy above created file to *.md instead of *.txt
open that file and convert all tabspaces U+0009 to pipes
convert all U+0027 ‘ to \’
EX: #Corpus ori james nav text
	prepend newline with hash then file name in sentence case to *.md file

run UnicodeCCount with “-u”  and store into tmp.txt
rename tmp.txt to Corpus-ori-[corpus_type]-[language_code]-text-[flag].txt
copy above created file to *.md instead of *.txt
open that file and convert all tabspaces U+0009 to pipes
convert all U+0027 ‘ to \’
EX: #Corpus ori james nav text
	prepend newline with hash then file name in sentence case to *.md file

run UnicodeCCount with “-d -m”  and store into tmp.txt
rename tmp.txt to Corpus-ori-[corpus_type]-[language_code]-text-[flag].txt
copy above created file to *.md instead of *.txt
open that file and convert all tabspaces U+0009 to pipes
convert all U+0027 ‘ to \’
EX: #Corpus ori james nav text
	prepend newline with hash then file name in sentence case to *.md file

}


# STEP 2 STAGE 1:

#4. Clean texts
#	a. Remove SFM Markers
#		i. Remove Verse #
#		ii. Remove Chapter #
#		iii. Remove Section headings #
#		iv. Create stated copy of text for reference.	
#	b. Remove typesetting characters via TECkit
#		i. List characters to be removed. Example U+00A0 needs to be converted to U+0020.
#		ii. Create .map file
#			(1) Create
#			(2) Compile .tec
#			(3) Apply
#			(4) Save .map and .tec files 
#		iii. Create stated copy of text for reference.	

# Clean the text files
print Starting step 2 stage 1: cleaning the text files

change to home_folder
#generate index folder list
list directories and store into index-folder-list.txt file

for each folder in index-folder-list.txt {
	change to subfolder
	Find .tec file name with matching corpus element in name [language_code].
	run TECkit on *.txt files (but only files without SFM, and only on the corpus) using compiled [typographic].tec 


}

for each .tec file {
}


# STEP 3 STAGE 1:

#5. Get second set of corpus counts
#	a. Run UnicodeCCount on the stated copy of (4.b.iii) with the following flags and output them to a single new folder in the following ways:
#		i. -d
#			(1) as a .txt file (using '> CorpusName_SecondCount-d.txt')
#			(2) as a .md file where 'tab' is replaced with "|" and "'" is escaped with "\"; at the top of the .md file add "## File name" in good typography (use spaces and sentence case).
#		ii. -u
#		iii. -d -m
#		iv. -c
#		v. Create an additional concatenated version of the .md files; to top of concatenation add "#Second Corpus Counts"
#		vi. Create an alined data presentation for -u of (3.a.ii) and (5.a.ii). Print this to .md format (per 3.a.ii).
#	b. List all characters used.
#		i.List all characters used which are not enabled via the keyboard layout for the language of the text. __(check this for what it is being compared to)__
#
#6. Convert texts to NFD
#	a. Convert texts to NFD.
#		i. UinicodeCCount -m and compare, show diffs
#	d. Remove untypeable characters
#		i. UinicodeCCount -m and compare; show diffs





# STEP 4 STAGE 1:

#6. Convert texts to NFD
#	a. Convert texts to NFD.
#		i. UinicodeCCount -m and compare, show diffs
#	d. Remove untypeable characters
#		i. UinicodeCCount -m and compare; show diffs




# STEP 5 STAGE 1:

#7. Count words of text.
#	a. by counting spaces and adding 1.


# STEP 6 STAGE 1:

#8. Convert texts to ASCII
#	a. Use .map file to convert texts to ASCII
#

# STEP 7 STAGE 1:

#9. Use python to count digrams.
#

# STEP 8 STAGE 1:

#10. Use javascript to count distance.	
#			
#



#########################



#This is a bash script to automate the transformation of corpora.

#Requires these dependencies
# 1. UnicodeCCount
# 2. TECKit
# 3. Typing by Michael Dickens
# 4. Stave Python script for Cleaning Wikipedia
# 5. Stave Python script for counting digrams
# 6. JavaScript count


# common commands
#
# echo "changing directories"
# cd ~/Multi-lingual\ Keyboard\ Assessment/MLKA/

# echo "adding to git"
# git add --all
# git commit -m 'some updates'

# UnicodeCCount -d -m > sometextfile.txt

## Something about variables sourced from: http://linuxconfig.org/bash-scripting-tutorial
## #!/bin/bash
## #Define bash global variable
## #This variable is global and can be used anywhere in this bash script
## VAR="global variable"
## function bash {
## #Define bash local variable
## #This variable is local to bash function only
## local VAR="local variable"
## echo $VAR
## }
## echo $VAR
## bash
## # Note the bash global variable did not change
## # "local" is bash reserved word
## echo $VAR

##Bash for and while loops



#
#1. Collect texts from source.
#	a. Create date, time, source, and permissions metadata.
#	b. Create stated copy of text for reference.
#		i. give each text a consistent first part in the name and a varied middle part and a consistent last part. (i.e. ori-James-NAV-text.txt)
#	
#2. Collect keyboard layout files from source.
#	a. Create date, time, source metadata.
#	b. Create image based on Apple keyboard template.
#	c. Create image based on heatmap template.
#	d. Write keyboard layout description
#		i. List all characters which are enabled by the keyboard layout in Unicode NFD.
#			(1) Create list.
#			(2) Convert list to NFD.

ls *.txt > corpus-list.txt

#
#3. For each corpus get initial corpus counts
#	a. Run UnicodeCCount with the following flags and output them to a single new folder in the following ways:
UnicodeCCount -d > CorpusName_InitialCount-d.txt
#		i. -d
#			(1) as a .txt file (using '> CorpusName_InitialCount-d.txt')
#			(2) as a .md file where 'tab' is replaced with "|" and "'" is escaped with "\"; at the top of the .md file add "## File name" in good typography (use spaces and sentence case).
#		ii. -u
#		iii. -d -m
#		iv. -c
#		v. Create an additional concatenated version of the .md files; to top of concatenation add "#Initial Corpus Counts"
#	b. List all characters used.
#		i.List all characters used which are not enabled via the keyboard layout for the language of the text (compare lists: 2.d.1.(2) with 3.a.iii).	
#
#4. Clean texts
#	a. Remove SFM Markers
#		i. Remove Verse #
#		ii. Remove Chapter #
#		iii. Remove Section headings #
#		iv. Create stated copy of text for reference.	
#	b. Remove typesetting characters via TECkit
#		i. List characters to be removed. Example U+00A0 needs to be converted to U+0020.
#		ii. Create .map file
#			(1) Create
#			(2) Compile .tec
#			(3) Apply
#			(4) Save .map and .tec files 
#		iii. Create stated copy of text for reference.	
#
#5. Get second set of corpus counts
#	a. Run UnicodeCCount on the stated copy of (4.b.iii) with the following flags and output them to a single new folder in the following ways:
#		i. -d
#			(1) as a .txt file (using '> CorpusName_SecondCount-d.txt')
#			(2) as a .md file where 'tab' is replaced with "|" and "'" is escaped with "\"; at the top of the .md file add "## File name" in good typography (use spaces and sentence case).
#		ii. -u
#		iii. -d -m
#		iv. -c
#		v. Create an additional concatenated version of the .md files; to top of concatenation add "#Second Corpus Counts"
#		vi. Create an alined data presentation for -u of (3.a.ii) and (5.a.ii). Print this to .md format (per 3.a.ii).
#	b. List all characters used.
#		i.List all characters used which are not enabled via the keyboard layout for the language of the text. __(check this for what it is being compared to)__
#
#6. Convert texts to NFD
#	a. Convert texts to NFD.
#		i. UinicodeCCount -m and compare, show diffs
#	d. Remove untypeable characters
#		i. UinicodeCCount -m and compare; show diffs
#
#7. Count words of text.
#	a. by counting spaces and adding 1.
#		
#8. Convert texts to ASCII
#	a. Use .map file to convert texts to ASCII
#
#9. Use python to count digrams.
#
#10. Use javascript to count distance.	
#			
#


##############################
List of files for each keyboard and corpus
##############################
###Corpora###
metadata file for corups.
no touch copy of corpus.
working copy of corpus.
global Unicode to nfd mapping .map file.
global unicode to nfd compiled mapping .tec file.

Each working copy of each corpus has initial count: -d, -u, -c, -d -m,-m (6 files)
Each working copy of each corpus has second count: -d, -u, -c, -d -m,-m (6 files) -following the removal of SFM
Each working copy of each corpus has third count: -d, -u, -c, -d -m,-m (6 files) -following the removal of typographical characters.
Each working copy of each corpus has fourth count: -d, -u, -c, -d -m,-m (6 files) -following the removal of SFM

###Keybords###
metadata file for keyboard.
image of keyboard layout for layout.
Base image of keyboard for heatmap.
image of keyboard for heatmap sample text.
image of keyboard for heatmap full text.
list of all characters supported by keyboard.
.kmn file for keyboard
.kmx file for keyboard
.keylayout file for keyboard.
 text description for keyboard (how it works).
list of characters to be removed from text.
.map file to support the removal of typographical characters.
.tec file to implement the conversions the typographical characters.
.map file to support the removal of untypeable characters.
.tec file to implement the removal of untypeable characters.
.map file for each keyboard layout to transform the text to ASCII.
.tec file for each keyboard layout to transform the text to ASCII.


