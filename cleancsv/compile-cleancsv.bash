#!/bin/bash

echo
echo "compiling..."
echo

if [ -f cleancsv ]; then
    rm cleancsv
fi

g++ -o cleancsv cleancsv.cpp

echo
echo "done compiling."
echo
