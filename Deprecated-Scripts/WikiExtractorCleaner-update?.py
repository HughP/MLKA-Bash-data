#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
@author: Matt Stave
Modified by: Hugh Paterson 
Date Authored: Thu Apr 30 23:43:48 2015
Date Modified: Sat Jun 06 22:14:00 2015
License: GPL 3.0
License info: http://www.gnu.org/licenses/gpl-3.0.en.html
Use: From the commandline type: wiki_extractor_cleaner.py <theinfilename> <theoutfilename>
"""
#WikiExtractor.py -cb 250K -o extracted aywiki-latest-pages-articles.xml.bz2
#find extracted -name '*bz2' -exec bzip2 -c {} \; > text.xml

import pandas
import glob
import os

#I tried to add the non-verbose commands with argparse.
# Generally un successful.  More here: https://docs.python.org/2/howto/argparse.html
# The python extractor script has several falgs.

def make_df(articles):
    #make a data frame from the list(s)
    df = pandas.DataFrame(index = range(len(titles)))
#    df['title'] = titles
    df['article'] = articles
    return df

#get all files in directory and put them into a big list
#Adjust path to find containing folder

path = os.getcwd()
filelist = glob.glob(path + '/wiki_*')
content = []
for item in filelist:
    with open(item) as f:
        subcontent = f.readlines()
    content = content + subcontent
#content = content[:2110]


titles = []
articles = []
i = 0
while i < len(content):
    #skip <doc> type lines
    if content[i][0] == '<':
        print('skip', content[i][0], i)
        i += 1
        #keep text lines
    else:
        #first should be the title (then skip two lines to get to article text)
        titles = titles + [content[i]]
        print('title', content[i][0], i)
        i += 2
        art = []
        #go through each line and get the text till you reach a newline
        while '\n' not in content[i][0]:
            art = art + [content[i]]
            print('article', content[i][0], i)
            i += 1
            print i
        if art == []:
            art = ['NOARTICLE']
        if len(art) > 0:
            art = [' '.join(art)]
        articles = articles + art
        i += 1
        
wiki = []
for i in xrange(len(articles)):
    wiki += [titles[i]]
    wiki += [articles[i]]

ISO_639_3code = os.path.split(os.path.dirname(path))[1]
with open("ori-" + "corpus-" + "wikipedia-" + str(ISO_639_3code) + ".txt", 'w') as out_file:
    out_file.write('\n'.join(wiki))