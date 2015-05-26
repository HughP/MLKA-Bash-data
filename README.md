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
 * `git clone https://bitbucket.org/neilb/csvfix` Or use `hg` instead of `git`. Hugh used homebrew and `brew install csvfix`.
5. [WikiExtractor Script](https://github.com/bwbaugh/wikipedia-extractor) extracts and cleans text from Wikipedia database dump and stores output in a number of files of similar size in a given directory. This is a mirror of the script by [Giuseppe Attardi](https://github.com/attardi/wikiextractor) - Which might actually be the original. http://medialab.di.unipi.it/wiki/Wikipedia_Extractor
 * `git clone https://github.com/bwbaugh/wikipedia-extractor.git`.
6. Stave Python script for Cleaning Wikipedia
7. Stave Python script for counting digrams
8. JavaScript count by jkpat


##Roadmap

* 0.3 Eventually I would like to check for dependencies and install them if needed. This script plus wget(not included on OS X by default) or curl (works on OSX by default) should work: http://stackoverflow.com/questions/592620/check-if-a-program-exists-from-a-bash-script

* 0.4 Consider switching from CSVfix to [CSVkit](https://github.com/onyxfish/csvkit) the commands are not the same. But it seems the power is better with CSVkit. CSVkit is on github but is not in a brew tap. A fuller analysis should be done by looking at the issues and features. Documentation is here: http://csvkit.readthedocs.org/en/0.9.1/


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