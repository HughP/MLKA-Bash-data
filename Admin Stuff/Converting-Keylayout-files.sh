##########################
# XML Reading .keylayout files
##########################


# In oder to read .keylayout files with CVSfix invalid characters in XML 1.0 can not be included in the file being parsed. These characters need to be removed, or better yet replaced. These characters minimally include: 

&#x0001; - Start of heading - http://graphemica.com/0001 - ␁
&#x0002; - Start of Text - http://graphemica.com/0002 - No glyph Using: ␂
&#x0003; - End of text - http://graphemica.com/0003 - ␃
&#x0004; - End of transmission - http://graphemica.com/0004 - ␄
&#x0005; - Enquiry - http://graphemica.com/0005 - ␅
&#x0006; - Acknowledge - http://graphemica.com/0006 - No glyph Using: ␆
&#x0007; - Bell - http://graphemica.com/0007 - No glyph Using: ␇
&#x0008; - Backspace - http://graphemica.com/0008 - ␈
&#x000B; - line tabulation - http://graphemica.com/000B - ␋
&#x000C; - Form Feed - http://graphemica.com/000C - No glyph Using: ␌
&#x000E; - Shift Out - http://graphemica.com/000E - No glyph Using: ␎
&#x000F; - Shift In - http://graphemica.com/000F - No glyph Using: ␏
&#x0010; - Data Link Escape - http://graphemica.com/001B - ␐
&#x0011; - Device control 1 - http://graphemica.com/0011 - No glyph Using: ␑
&#x0012; - Device control 2 - http://graphemica.com/0012 - No glyph Using: ␒
&#x0013; - Device control 3 - http://graphemica.com/0013 - No glyph Using: ␓
&#x0014; - Device control 4 - http://graphemica.com/0014 - No glyph Using: ␔
&#x0015; - Negative Acknowledge - http://graphemica.com/0015 - No glyph Using: ␕
&#x0016; - Synchronous Idle - http://graphemica.com/0016 - No glyph Using: ␖
&#x0017; - End of transmission block - http://graphemica.com/0017 - No glyph Using: ␗
&#x0018; - Cancel - http://graphemica.com/0018 - No glyph Using: ␘
&#x0019; - End of Medium - http://graphemica.com/0019 - No glyph Using: ␙
&#x001A; - Substitute - http://graphemica.com/0007 - No glyph Using: ␚
&#x001B; - Escape - http://graphemica.com/001B - ␛
&#x001C; - File Separator - http://graphemica.com/001C - No glyph Using: ␜
&#x001D; - Group Separator - http://graphemica.com/001D - No glyph Using: ␝
&#x001E; - Record Separator - http://graphemica.com/001E - No glyph Using: ␞
&#x001F; - Unit Separator - http://graphemica.com/001F - No glyph Using: ␟

There is an additional set of control characters which might be good to remove or replace. These are the control characters which do parse. The following is a list:

&#x0000; - Null - http://graphemica.com/0000 - ␀
&#x000A; - Line Feed - http://graphemica.com/000A - No glyph Using: ␊
&#x000D; - Carriage Return - http://graphemica.com/000D - No glyph Using: ␍
&#x0009; - Horizontal Return - http://graphemica.com/000A - No glyph Using: ␉

The list of these characters should be added to a .map file to produce a .tec file. Then .keylayout files should convert old strings to new strings.


[] - Transform a .keylayout file to an SVG image.
 [] - Find SVG image.
 * https://www.google.com/search?q=apple+keyboard+SVG&es_sm=91&tbm=isch&imgil=xxHmlnaGZeIz4M%253A%253BBqzEtPsLabdRpM%253Bhttp%25253A%25252F%25252Fblog.lemmonjuice.com%25252F&source=iu&pf=m&fir=xxHmlnaGZeIz4M%253A%252CBqzEtPsLabdRpM%252C_&usg=__Qp4Nfp9RmTZS2-tN6SbpJfvDjIw%3D&biw=1174&bih=846&dpr=0.9&ved=0CCgQyjc&ei=nJ9qVY61CIWpyQSNu4OQBg#imgrc=xxHmlnaGZeIz4M%253A%3BBqzEtPsLabdRpM%3Bhttp%253A%252F%252Fblog.lemmonjuice.com%252Fwp-content%252Fuploads%252F2011%252F03%252FScreen-shot-2011-03-09-at-4.55.34-PM.png%3Bhttp%253A%252F%252Fblog.lemmonjuice.com%252F%3B600%3B300
 * http://blog.lemmonjuice.com/2011/03/css-apple-keyboard/
 * https://creativemarket.com/SimonClavey/8086-Flapples
 * https://dribbble.com/shots/978890-Apple-Keyboard-Free-PSD
 [] - Create CSVfix Transform of XML - SVG image
 [] - Create second transform from .keylayout XML to enriched SVG - XML.
[] - Take out put of Typing, by dickens, and put it into an XML CSV.
  * - Or the CSV fix here: https://groups.google.com/forum/#!topic/csvfix/2hgr8j9dmbo
[] - If I can transpose the CSV file for stats, then I could import it to Pygal and make a chart. Use python command and
[ - making bar charts
 * I could try and use D3: http://bost.ocks.org/mike/bar/
 * I could try and use pygal: http://pygal.org/basic_customizations/#idusing-keyword-args]
 
 instead of doing some of the cat to file operations I should try the following:
 
http://stackoverflow.com/questions/20688552/assigning-the-output-of-a-command-to-a-variable-in-a-shell-script 
http://stackoverflow.com/questions/4651437/how-to-set-a-bash-variable-equal-to-the-output-from-a-command

 OUTPUT="$(ls -1)"
echo "${OUTPUT}"
 

Use color to indicated Dead keys.

csvfix from_xml -re 'keyMapSet@keyMap@key' -np -nc Ukrainian\ \(Russian\).keylayout

keyMapSet@keyMap@key

First_Stats-u-example-ori-corpus-james-nav.csv
