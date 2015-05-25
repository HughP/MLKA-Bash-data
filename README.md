#Bash-data-mlka
Bash script for mashing mlka data

This is written to work on OS X and linux.
The purpose is to run data through UnicodeCcount and TECKit enmass.

##Requires these dependencies

1. [UnicodeCCount](http://scripts.sil.org/UnicodeCharacterCount) - version 0.3
2. [TECKit](http://scripts.sil.org/TECkitDownloads) - version 2.5.4 
3. [Typing](https://github.com/michaeldickens/Typing) by Michael Dickens
 * `git clone https://github.com/michaeldickens/Typing.git`
4. Stave Python script for Cleaning Wikipedia
5. Stave Python script for counting digrams
6. JavaScript count by jkpat





##Notes

###Notes for Jonathan about git.

* Here is some thing about fetching from upstream and syncing your repo: https://help.github.com/articles/syncing-a-fork/

###Notes for Hugh

* For reference: http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO.html

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