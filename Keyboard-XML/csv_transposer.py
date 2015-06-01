#!/usr/bin/python
"""
Source: http://askubuntu.com/questions/74686/is-there-a-utility-to-transpose-a-csv-file
Date accessed: 31 May 2015
Author: xubuntix
Date Authored: Nov 2 '11 at 7:32, updated at Aug 25 '12 at 7:07
License: Creative Commons-With Attribution-Share Alike 3.0.
License info: The CC-BY-SA 3.0 license is required as part of the user agreement for askubuntu.com. Thee script was a user contribution. 
Use: From the command line type: python csv_transposer.py <theinfilename> <theoutfilename>
"""

import csv
import sys
infile = sys.argv[1]
outfile = sys.argv[2]

with open(infile) as f:
    reader = csv.reader(f)
    cols = []
    for row in reader:
        cols.append(row)

with open(outfile, 'wb') as f:
    writer = csv.writer(f)
    for i in range(len(max(cols, key=len))):
        writer.writerow([(c[i] if i<len(c) else '') for c in cols])