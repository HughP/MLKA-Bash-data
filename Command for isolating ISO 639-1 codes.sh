#This is read as:
#	Read the tab file, keep columns 1,4,7; then remove rows 2 if the length of the field is 0.

csvfix read_DSV -s '\t' -f 1,4,7 iso-639-3_20150505.tab | csvfix remove -f 2 -l 0 time.csv
