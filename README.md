#Bash-data-mlka
Bash script for mashing mlka data

This is written to work on OS X and linux.
The purpose is to run data through UnicodeCcount and TECKit enmass.

##Requires these dependencies

1. [UnicodeCCount](http://scripts.sil.org/UnicodeCharacterCount) - version 0.3
2. [TECKit](http://scripts.sil.org/TECkitDownloads) - version 2.5.4
3. [Typing](https://github.com/michaeldickens/Typing) by Michael Dickens
 * `git clone https://github.com/michaeldickens/Typing.git`
4. [CSVfix](https://bitbucket.org/neilb/csvfix) version 1.6 [More info](http://neilb.bitbucket.org/csvfix/)
 * `hg clone https://bitbucket.org/neilb/csvfix`. Hugh used homebrew and `brew install csvfix`.
5. [WikiExtractor Script](https://github.com/bwbaugh/wikipedia-extractor) extracts and cleans text from Wikipedia database dump and stores output in a number of files of similar size in a given directory. This is a mirror of the script by [Giuseppe Attardi](https://github.com/attardi/wikiextractor) - Which might actually be the original. http://medialab.di.unipi.it/wiki/Wikipedia_Extractor
 * `git clone https://github.com/bwbaugh/wikipedia-extractor.git`.
6. Python (Preferably 2.7)
7. pip
8. PyGal - for SVG production of graphs.
9. Stave Python script for Cleaning Wikipedia
10. Stave Python script for counting digrams
11. JavaScript count by jkpat
12. Your Perl installation is missing the UCA keys file. Please download
http://www.unicode.org/Public/UCA/latest/allkeys.txt and put a copy into
the '/usr/lib/x86_64-linux-gnu/perl/5.20/Unicode/Collate' folder.

##Roadmap
- [ ] 0.1 Ingest, oganize, and Use UnicodCcount on data from Wikipedia, Keyboard layouts, and James texts.
- [x] 0.2 Check for dependencies exit script if not present.
 - [ ] 0.3.5 Install dependencies if needed.
- [ ] 0.4 Hook up carpalx
- [ ] 0.5 Consider switching from CSVfix to [CSVkit](https://github.com/onyxfish/csvkit) the commands are not the same. But it seems the power is better with CSVkit. CSVkit is on github but is not in a brew tap. A fuller analysis should be done by looking at the issues and features. Documentation is here: http://csvkit.readthedocs.org/en/0.9.1/
- [ ] 0.7 Detect and remove SFM File markers from Scripture corpora.

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

* For reference: http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO.html

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
