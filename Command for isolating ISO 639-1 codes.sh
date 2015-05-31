#This is read as:
#	Read the tab file, keep columns 1,4,7; then remove rows 2 if the length of the field is 0.

csvfix read_DSV -s '\t' -f 1,4,7 iso-639-3_20150505.tab | csvfix remove -f 2 -l 0 time.csv


# Read this for getting the first two letters of the file name:
# http://stackoverflow.com/questions/428109/extract-substring-in-bash


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

csvfix from_xml -re 'keyMapSet@keyMap@key' -np -nc Ukrainian\ \(Russian\).keylayout

keyMapSet@keyMap@key
