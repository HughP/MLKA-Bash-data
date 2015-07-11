#!/bin/bash

# Grab global variables:
source ../Dependencies/global-vars.bash

##############################
##############################

##############################
# Project Wide Functions
##############################
### (MSG-001-B) HUGH: We can use global functions like this:
### Hugh is noticing that not a lot of use exists for global-functions.bash  do we really need it?
###


# Grab global functions:
source ../Dependencies/global-functions.bash

##############################
##############################




##############################
# Export the capable characters or each keyboard layout file each to a seperate CSV
##############################
# http://unix.stackexchange.com/questions/12273/in-bash-how-can-i-convert-a-unicode-codepoint-0-9a-f-into-a-printable-charact
# http://stackoverflow.com/questions/602912/how-do-you-echo-a-4-digit-unicode-character-in-bash
##########################
##########################


##########################
# XML Reading .keylayout files
##########################

#We have already found and counted the Keyboard layout files. We have already found which languages they belong to.

#Assuming that we are working with .keylayout files:...
#We need to now copy the file and replace the following characters with new characters Because the XML read function on CSVfix and Starlet both choke on the encoded control characters. Starlet does better and only chokes on U+0008 which is the character for back-space.

The solution I have imagined is that all control characters can be changed to the Unicode character which is a glyph to represent the character. However,to do this I need to be able to read the input text. For example I need to change '&#x0001' to '␁'. 


basically:
find XML file
copy xml file to derived data folder.
in the copy replace character code sequences for control characters with glyphs.
Use XML to pull all characters out of the keyboard layout.
Measure the keyboard characters against characters in the orthography and writing system. Generate Report.
Measure the keyboard characters against characters in James. Generate Report.
Measure the keyboard characters against characters in Wikipeida. Generate Report.

Pull out characters used and their associated key.
Use the associated key in the QWERTY keyboard to create a TECkit mapping pivoting on the keyboard for each language and the QWERTY Mapping.


We need to report what was changed. -- a corespondence table.

Convert texts to quwerty equivelent via TECkit.
Run Keyboard evaluation program against TECKit model.


# In oder to read .keylayout files with CVSfix invalid characters in XML 1.0 can not be included in the file being parsed. These characters need to be removed, or better yet replaced. These characters minimally include: 

# &#x0001; - Start of heading - http://graphemica.com/0001 - No glyph Using: ␁
# &#x0002; - Start of Text - http://graphemica.com/0002 - No glyph Using: ␂
# &#x0003; - End of text - http://graphemica.com/0003 - No glyph Using: ␃
# &#x0004; - End of transmission - http://graphemica.com/0004 - No glyph Using: ␄
# &#x0005; - Enquiry - http://graphemica.com/0005 - No glyph Using: ␅
# &#x0006; - Acknowledge - http://graphemica.com/0006 - No glyph Using: ␆
# &#x0007; - Bell - http://graphemica.com/0007 - No glyph Using: ␇
# &#x0008; - Backspace - http://graphemica.com/0008 - No glyph Using: ␈
# &#x000B; - line tabulation - http://graphemica.com/000B - No glyph Using: ␋
# &#x000C; - Form Feed - http://graphemica.com/000C - No glyph Using: ␌
# &#x000E; - Shift Out - http://graphemica.com/000E - No glyph Using: ␎
# &#x000F; - Shift In - http://graphemica.com/000F - No glyph Using: ␏
# &#x0010; - Data Link Escape - http://graphemica.com/001B - No glyph Using: ␐
# &#x0011; - Device control 1 - http://graphemica.com/0011 - No glyph Using: ␑
# &#x0012; - Device control 2 - http://graphemica.com/0012 - No glyph Using: ␒
# &#x0013; - Device control 3 - http://graphemica.com/0013 - No glyph Using: ␓
# &#x0014; - Device control 4 - http://graphemica.com/0014 - No glyph Using: ␔
# &#x0015; - Negative Acknowledge - http://graphemica.com/0015 - No glyph Using: ␕
# &#x0016; - Synchronous Idle - http://graphemica.com/0016 - No glyph Using: ␖
# &#x0017; - End of transmission block - http://graphemica.com/0017 - No glyph Using: ␗
# &#x0018; - Cancel - http://graphemica.com/0018 - No glyph Using: ␘
# &#x0019; - End of Medium - http://graphemica.com/0019 - No glyph Using: ␙
# &#x001A; - Substitute - http://graphemica.com/0007 - No glyph Using: ␚
# &#x001B; - Escape - http://graphemica.com/001B - No glyph Using: ␛
# &#x001C; - File Separator - http://graphemica.com/001C - No glyph Using: ␜
# &#x001D; - Group Separator - http://graphemica.com/001D - No glyph Using: ␝
# &#x001E; - Record Separator - http://graphemica.com/001E - No glyph Using: ␞
# &#x001F; - Unit Separator - http://graphemica.com/001F - No glyph Using: ␟
# 
# There is an additional set of control characters which might be good to remove or replace. These are the control characters which do parse. The following is a list:
# 
# &#x0000; - Null - http://graphemica.com/0000 - ␀
# &#x000A; - Line Feed - http://graphemica.com/000A - No glyph Using: ␊
# &#x000D; - Carriage Return - http://graphemica.com/000D - No glyph Using: ␍
# &#x0009; - Horizontal Return - http://graphemica.com/000A - No glyph Using: ␉
# 
# The list of these characters should be added to a .map file to produce a .tec file. Then .keylayout files should convert old strings to new strings.
# 
# 
# [] - Transform a .keylayout file to an SVG image.
#  [] - Find SVG image.
#  * https://www.google.com/search?q=apple+keyboard+SVG&es_sm=91&tbm=isch&imgil=xxHmlnaGZeIz4M%253A%253BBqzEtPsLabdRpM%253Bhttp%25253A%25252F%25252Fblog.lemmonjuice.com%25252F&source=iu&pf=m&fir=xxHmlnaGZeIz4M%253A%252CBqzEtPsLabdRpM%252C_&usg=__Qp4Nfp9RmTZS2-tN6SbpJfvDjIw%3D&biw=1174&bih=846&dpr=0.9&ved=0CCgQyjc&ei=nJ9qVY61CIWpyQSNu4OQBg#imgrc=xxHmlnaGZeIz4M%253A%3BBqzEtPsLabdRpM%3Bhttp%253A%252F%252Fblog.lemmonjuice.com%252Fwp-content%252Fuploads%252F2011%252F03%252FScreen-shot-2011-03-09-at-4.55.34-PM.png%3Bhttp%253A%252F%252Fblog.lemmonjuice.com%252F%3B600%3B300
#  * http://blog.lemmonjuice.com/2011/03/css-apple-keyboard/
#  * https://creativemarket.com/SimonClavey/8086-Flapples
#  * https://dribbble.com/shots/978890-Apple-Keyboard-Free-PSD
#  [] - Create CSVfix Transform of XML - SVG image
#  [] - Create second transform from .keylayout XML to enriched SVG - XML.
# [] - Take out put of Typing, by dickens, and put it into an XML CSV.
#   * - Or the CSV fix here: https://groups.google.com/forum/#!topic/csvfix/2hgr8j9dmbo
# [] - If I can transpose the CSV file for stats, then I could import it to Pygal and make a chart. Use python command and
# [ - making bar charts
#  * I could try and use D3: http://bost.ocks.org/mike/bar/
#  * I could try and use pygal: http://pygal.org/basic_customizations/#idusing-keyword-args]
#  
#  instead of doing some of the cat to file operations I should try the following:
#  
# http://stackoverflow.com/questions/20688552/assigning-the-output-of-a-command-to-a-variable-in-a-shell-script 
# http://stackoverflow.com/questions/4651437/how-to-set-a-bash-variable-equal-to-the-output-from-a-command
# 
#  OUTPUT="$(ls -1)"
# echo "${OUTPUT}"
#  
# 
# Use color to indicated Dead keys.
# 
# csvfix from_xml -re 'keyMapSet@keyMap@key' -np -nc Ukrainian\ \(Russian\).keylayout
# 
# keyMapSet@keyMap@key
# 
# First_Stats-u-example-ori-corpus-james-nav.csv