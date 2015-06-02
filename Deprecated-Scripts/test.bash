#!/bin/bash

for i in $(ls *.txt); do
    if (( $i != $PATTERN)); then
        cp ../$NEW_DATA/* .
    fi
done
