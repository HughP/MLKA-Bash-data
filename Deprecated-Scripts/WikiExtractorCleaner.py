# -*- coding: utf-8 -*-
"""
Created on Thu Apr 30 23:43:48 2015

@author: Matt Stave
License: GPL
"""
#WikiExtractor.py -cb 250K -o extracted aywiki-latest-pages-articles.xml.bz2
#find extracted -name '*bz2' -exec bzip2 -c {} \; > text.xml

import pandas
import glob

def make_df(articles):
    #make a data frame from the list(s)
    df = pandas.DataFrame(index = range(len(titles)))
#    df['title'] = titles
    df['article'] = articles
    return df

#get all files in directory and put them into a big list
#Adjust path to find containing folder
'''
path = '/Users/Hugh'
filelist = glob.glob(path + '\*')
content = []
for item in filelist:
    with open(item) as f:
        subcontent = f.readlines()
    content = content + subcontent
    '''
content = open('/Users/Hugh/wiki_00.txt')

''' I need to try and get this to open files at the cross platform level.'''
""" try to set the path variable with the following:
import os 
path = os.getcwd()

"""

titles = []
articles = []
i = 0
while i < len(content):
    #skip <doc> type lines
    if content[i][0] == '<':
#        print('skip', content[i][0], i)
        i += 1
        #keep text lines
    else:
        #first should be the title (then skip two lines to get to article text)
        titles = titles + [content[i]]
#        print('title', content[i][0], i)
        i += 2
        art = []
        #go through each line and get the text till you reach a newline
        while '\n' not in content[i][0]:
            art = art + [content[i]]
#            print('article', content[i][0], i)
            i += 1
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

with open('wiki.txt', 'w') as out_file:
    out_file.write('\n'.join(wiki))

#original file ending.
"""
df = make_df(articles)
df.to_csv('quwiki.txt', index = False)
"""