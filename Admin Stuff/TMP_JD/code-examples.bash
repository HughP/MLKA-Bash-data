#!/bin/bash
# Author: Jonathan Duff <jonathan@dufffamily.org>
# Usage: A collection of bash code examples

printf "Let's begin" # print some texts
printf "!" # print text on the same line.
echo # new line

author="J.D."
echo "The author is:" $author
echo
echo

echo "This is a while loop that prints a line."
echo
count=0
while (( count < 50 )); do
    printf "-"
    (( count = count + 1))
done
echo
echo

echo "Here is a for loop that displays an array variable:"
SIZE_OF_INDEX=5
ARRAY=(zero one two three four)
for (( index=0; index < SIZE_OF_INDEX; index++)); do
    echo "at index $index:" ${ARRAY[$index]}
done
echo
echo

echo "Here are nested for loops printing some numbers:"
for (( x=0; x < 10; x++)); do
    for (( y=0; y < 10; y++ )); do
        printf $x
    done
    echo
done
echo
echo

echo "Here is another variation:"
for (( x=0; x < 10; x++)); do
    for (( y=0; y < 10; y++ )); do
        printf $y
    done
    echo
done
echo
echo

echo "Here is another more complex array:"
ARRAY1=( John Jennifer Jimmy Joe Jones)
ARRAY2=( soup hamburger fries taco candy)
for x in ${ARRAY1[*]}; do
    for y in ${ARRAY2[*]}; do
        printf $x
        printf " likes to eat: "
        printf $y
        echo
    done
done
echo
echo

echo "Let us print some cities:"
ARRAY3=( Portland L.A. Vegas Denver NY)
count=0
while (( count < ${#ARRAY3[*]} )); do # the size of ARRAY3
    echo "The city is: " ${ARRAY3[$count]}
    (( count++ ))
done
echo
echo

echo "And now this monster:"
ARRAY4=( 1 two three 1 )
ONE=1
TWO=two
THREE=three
FOUR=1
# read == as: is equal to
# read != as: not equal to
# read || as: or
# read && as: and
# ${ARRAY4[0]} is ARRAY4 at index location 0
# ${ARRAY4[*]} is the whole array ARRAY4
# ${#ARRAY4[*]} is the length of the whole array ARRAY4
if (( ONE == TWO )) || (( ONE == FOUR )); then
    echo "step one!"
    if (( ONE != THREE )) && (( ONE == FOUR )); then
        echo "step two!"
        if (( ONE == ${ARRAY4[0]} )) && (( TWO == ${ARRAY4[1]} )); then
            echo "step three!"
            if (( ${#ARRAY4[*]} > 3 )); then
                echo ${ARRAY4[*]}
            fi
        fi
    fi
fi
echo
echo
