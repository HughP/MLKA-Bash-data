#Bash-data-mlka
_The purpose is to run data through UnicodeCcount and TECKit enmass. The script then processes the data counts produced against various keyboard layouts and gives evaluations on what the keyboard layout efficentcy is for the text of a specific language._

This script is written in bash script for processing and computing MLKA data. Some python code is embeded, and some perl dependencies are required. 

There are three related repositories:
* The MLKA project
	* https://github.com/HughP/MLKA
* MLKA-Data which is a set of test data for testing and building this script.
	* https://github.com/HughP/MLKA-data
* Keyboard-File-Types which is simply a data array of various types of keyboard layout file types.
	* https://github.com/HughP/Keyboard-File-Types

This is written to work on OS X and linux.
Tested on: 
* OS X 10.6.8 & 10.9.5
* Ubuntu


##Requires these dependencies

1. [UnicodeCCount](http://scripts.sil.org/UnicodeCharacterCount) - version 0.3
 * A sub-dependency here is Perl - ** We do not check for Perl.** _We do chech for UnicodeCCount._
 * The script will not be successful and will output an error if [allkeys.txt](http://www.unicode.org/Public/UCA/latest/allkeys.txt) is not present in your Perl instance. This is a requirement of UnicodeCcount to operate. The error message will say: `Your Perl installation is missing the UCA keys file. Please download http://www.unicode.org/Public/UCA/latest/allkeys.txt and put a copy into the '/usr/lib/x86_64-linux-gnu/perl/5.20/Unicode/Collate' folder.`
2. [TECKit](http://scripts.sil.org/TECkitDownloads) - version 2.5.4
3. [Typing](https://github.com/michaeldickens/Typing) by Michael Dickens
 * `git clone https://github.com/michaeldickens/Typing.git`
4. [CSVfix](https://bitbucket.org/neilb/csvfix) version 1.6 [More info](http://neilb.bitbucket.org/csvfix/)
 * `hg clone https://bitbucket.org/neilb/csvfix`.
 * OS X users are encouraged to use homebrew via `brew install csvfix`.
5. [WikiExtractor Script](https://github.com/bwbaugh/wikipedia-extractor) extracts and cleans text from Wikipedia database dump and stores output in a number of files of similar size in a given directory. This is a mirror of the script by [Giuseppe Attardi](https://github.com/attardi/wikiextractor) - Which might actually be the original. http://medialab.di.unipi.it/wiki/Wikipedia_Extractor
 * `git clone https://github.com/bwbaugh/wikipedia-extractor.git`.
6. Python (Preferably 2.7)
  * One option among many for OS X Users is `brew install python`.
 * Other Python dependencies:
  * pip
  * PyGal - for SVG production of graphs.
  * Pandas - A python module for data processing
7. Python scripts embeded in the .bash script:
 * WikipediaExtractor Cleaner by Matt Stave (with edits by Hugh Paterson III)
 * Stave + Paterson python script for counting digrams
 * Script for transposing/pivoting data in CSV files
8. JavaScript count by jkpat
9. Palaso-python module


##Roadmap
- [x] 0.0.1 ingest and organize Wikipedia data
- [x] 0.0.2 ingest and organize James data
- [ ] 0.0.3 ingest and organize Keyboard data
- [ ] 0.1 Ingest, and organize data (Wikipedia, James, and Keyboards)
- [ ] 0.1.1 Perform text clean up tasks for corpora.
- [ ] 0.1.2 UnicodeCCount on data from Wikipedia, Keyboard layouts, and James texts.
- [ ] 0.1.4 Graph output from UnicodeCCount
- [ ] 0.1.5 Ingest and compare stats with other comparitive studies.
- [ ] 0.1.6 Ingest Phonology Data and compare with orthography data.
- [x] 0.2 Check for dependencies exit script if not present.
- [ ] 0.3 Make warning items the correct color see: http://misc.flogisoft.com/bash/tip_colors_and_formatting
 - [ ] 0.3.5 Install dependencies if needed.
- [ ] 0.4 Hook up carpalx
- [ ] 0.5 Consider switching from CSVfix to [CSVkit](https://github.com/onyxfish/csvkit) the commands are not the same. But it seems the power is better with CSVkit. CSVkit is on github but is not in a brew tap. A fuller analysis should be done by looking at the issues and features. Documentation is here: http://csvkit.readthedocs.org/en/0.9.1/
- [ ] 0.7 Detect and remove SFM File markers from Scripture corpora.
- [ ] 0.8 Automatically check to see if the version of the ISO 639-3 file is the latest file.
- [ ] 0.9 start to read JSON keyboard files, convert them to CSV See: https://github.com/archan937/jsonv.sh ; https://github.com/jehiah/json2csv
 - [ ] 0.9.2 for going the other way consider http://stackoverflow.com/questions/24300508/csv-to-json-using-bash or [csvkit's tools](http://csvkit.readthedocs.org/en/latest/scripts/in2csv.html).
 - [ ] 0.9.8 Add method for other corproa to exist and to be processed.
- [ ] 1.5 add Swifter layout analysis.

##Corpus clean up process
###Wikipedia
* download wikipedia data
* Extractor script
* Extractor cleaner
* Paterson use of TECKit to clean residue left by Extractor cleaner
* Typography character conversion by TECKit

###James
*

##List of files
_The purpose of this section is to list the kinds of files and the quantity of files which are created and used during the data processing process. There are three kinds of files: those we start off with, temp-files which are created and then deleted by the script, and those which are generated along the way, but represent some type of analysis._

###Files we start off with

####Corpus Data
* metadata file for corpus.
* no touch copy of corpus.
* working copy of corpus.

##### Types of Corpora
* NT James
* Wikipedia

####Stats Counts from other studies
* Some languages have stats for character frequency. Some don't.

####Character Transforms
* global Unicode to nfd mapping .map file.
* global Typographical clean up. .map file to support the removal of typographical characters.
* Corpus based clean up.
* .map file for each keyboard layout to transform the text to ASCII.

####Keyboards
* metadata file for keyboard.
* text description for keyboard (how it works).
* .kmn file for keyboard
* .kmx file for keyboard
* image of keyboard layout for layout.
* Base image of keyboard for heatmap.
* .keylayout file for keyboard.

###Temp Files

* **James-Corpus.txt** - This file is used to create an output of the languages of James corpora. It is different than the file created by `$JAMES_LIST_FILE` which is called _James-list.txt_.

###Files Produced

####Corpus Data

* Each working copy of each corpus has initial count: -d, -u, -c, -d -m,-m (6 files)
* Each working copy of each corpus has second count: -d, -u, -c, -d -m,-m (6 files) -following the removal of SFM
* Each working copy of each corpus has third count: -d, -u, -c, -d -m,-m (6 files) -following the removal of typographical characters.
* Each working copy of each corpus has fourth count: -d, -u, -c, -d -m,-m (6 files) -following the conversion of Unicode text to ASCII equivalent for keyboard analysis.
* list of characters to be removed from text.

####Character Transforms

* .map file to support the removal of untypeable characters.
* global unicode to nfd compiled mapping .tec file.
* list of characters to be removed from text.
* .tec file for each keyboard layout to transform the text to ASCII.
* .tec file to implement the removal of untypeable characters.
* .tec file to implement the conversions the typographical characters.


####Keyboards

* image of keyboard for heatmap sample text.
* image of keyboard for heatmap full text.
* list of all characters supported by keyboard.


##Notes

###Notes for Jonathan about git.

* Here is some thing about fetching from upstream and syncing your repo: https://help.github.com/articles/syncing-a-fork/

```
git remote -v
git remote add upstream https://   <<--put link here
git remote -v
git fetch upstream
git merge upstream/master

>>> Check and fix merged files <<<

git add --all
git push
```

###Notes for Hugh

####Bash
* For reference: http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO.html
* Arrays: http://mywiki.wooledge.org/BashGuide/Arrays ; http://tldp.org/LDP/abs/html/arrays.html
* Nested Loops: http://www.tldp.org/LDP/abs/html/nestedloops.html

####Git
* Cherry picking with git: https://www.kernel.org/pub/software/scm/git/docs/git-cherry-pick.html


####Notes by Hugh for where he got what.

@Jonathan to find this I was looking here: http://unix.stackexchange.com/questions/138634/shortest-way-to-extract-last-3-characters-of-base-minus-suffix-filename I am not sure how to implement this in this code base right now.


####From Martin

>I have no such tool to hand, but using the palaso-python library, we could write one. The first thing is to work out exactly what you want. Do you simply want a list of every possible unicode character that a keyboard could produce or do you want a list of possible minimal strings that a keyboard could produce or a simple key-mapping (for which I already have a tool)?
>
>Basically you will want something along the lines of:

```
import palaso.kmfl as kmfl
from palaso import kmn

kbd = kmfl(sys.argv[1])
allchars = set()
for i in range(kbd.numrules) :
        for s in map(kmn.item_to_char, kbd.flatten_context(i, side = 'r')) :
                allchars.add(s)
print allchars
```
>beware this code is completely untested and therefore is highly unlikely not to have bugs in it. You'll want to write some code to prettify the output to what you want.

>GB,
>Martin

#### Second Reply from Martin

>> So, I am talking about single "functional units". There may be multi-key
>> processes to achieve production, and they may be encoded in multiple
>> Unicode code points, but at some level they are a single production target
>> in the text production process.
>>
>> Does this help?
>
>Indeed. It's all in the requirements. OK so the fragment changes slightly to:
>```
>import palaso.kmfl as kmfl
>from palaso import kmn
>
>kbd = kmfl(sys.argv[1])
>allchars = set()
>for i in range(kbd.numrules) :
>        print map(kmn.item_to_char, kbd.flatten_context(i, side = 'r'))
>```
>OK. So you may want to take each of the outputs of the map and prettify it somewhat, but you get the idea? If you are still stuck, I can put together an ipython notebook for you on the topic :)



####From Marc
>
>Hi Hugh,
>
>I don’t have an immediate solution to your question – the Keyman source language is non-trivial to parse, although some for your requirements you may be able to get away with a lot less processing. We have Windows-based tools for analysis of a keyboard layout, but this may not be all that helpful to you.
>
>I am not sure if you are up for writing your own script to parse the source files or not. If you are, then I would advise the following process:
>
>*       The file format can be ANSI, UTF-8, or UTF-16. Convert the file to your preferred format before parsing.
>
>*       Comments: For each line, strip any text following “c “ or “C “ – but only outside quotation marks
>
>*       Line concatenation: Then, if a line ends in a “\” (ignore whitespace), delete the backslash and concatenate with the next line
>
>*       Then there are only two types of lines to analyse, pseudo tokenized:
>
>  *   “store” “(“ store_name “)”  value
>
>  *   context [“+” key] “>” value
>
>*       Ignore all other lines
>
>*       If the store_name token starts with “&” ignore the line.
>
>*       You will be interested only in the value and output tokens.  These are delimited by the close paren “)” token in the store lines and the greater than “>” token in the rule lines and finish at end of line in each case.
>
>*       Parse the value and output tokens:
>
> *   Any “U+xxxx” is a Unicode character.
>
> *   Any string of Unicode characters starts with a single quote (') or a double quote (") and finishes with the same quote.
>
> *   Ignore any tokens between an open and a close paren.
>
> *   Ignore any other tokens
>
>
>I hope this helps and that I haven’t forgotten anything.
>
>Cheers,
>
>Marc

###Notes for all

* Git PRO book For reference: https://git-scm.com/book/en/v2

```
Something about variables sourced from: http://linuxconfig.org/bash-scripting-tutorial
#!/bin/bash
#Define bash global variable
#This variable is global and can be used anywhere in this bash script
VAR="global variable"
function bash {
#Define bash local variable
#This variable is local to bash function only
local VAR="local variable"
echo $VAR
}
echo $VAR
bash
# Note the bash global variable did not change
# "local" is bash reserved word
echo $VAR

ash for and while loops
```
