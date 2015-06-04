#1/bin/bash

HEADER_COLUMN1=James
HEADER_COLUMN2=Wikipedia
HEADER_COLUMN3=Keyboards
HEADER_COLUMN4=Languages

printf '\t'
printf "   "
printf $HEADER_COLUMN1
printf '\t'
printf "   "
printf $HEADER_COLUMN2
printf '\t'
printf "   "
printf $HEADER_COLUMN3
printf '\t'
printf "   "
printf $HEADER_COLUMN4
echo

printf '\t'
printf "  "
printf "+"
count=61
while (( count > 0 )); do
    printf "-"
    (( count = count - 1))
done
printf "+"
echo

row=1
TABLE_ARRAY=(one two three four)
for (( COUNT=100; COUNT > 0; COUNT-- )); do
    printf "row $row:"
    if (( row < 100 )); then
        printf '\t'
    fi
    printf "  "
    printf "|"

    for column_content in ${TABLE_ARRAY[*]}; do
            printf "$column_content"
            printf '\t'
            printf '\t'
            printf "|"
    done

    echo
    (( row++ ))

done

printf '\t'
printf "  "
printf "+"
count=61
while (( count > 0 )); do
    printf "-"
    (( count = count - 1))
done
printf "+"
echo
