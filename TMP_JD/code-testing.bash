#!/bin/bash

source ../global-vars.bash

THE_COUNT=0
for i in $(find * -maxdepth 0 -iname 'iso-639-3*.tab'); do
    (( THE_COUNT = THE_COUNT + 1 ))
done

case $THE_COUNT in
    0)
        echo "INFO: In order to organize the data we need the proper ISO 639-3 code tables."
        echo "      The 'Complete Code Tables Set' are published as a .zip file here:"
        echo "      http://www-01.sil.org/iso639-3/download.asp"
        echo
        echo "      It looks like you need to get the ISO 639-3 tab file which is included"
        echo "      in UTF-8: iso-639-3_Code_Tables_*.zip file"
        echo
        echo "      The specific file you need is the generic looking one with the format:"
        echo "      iso-639-3_YYYYMMDD.tab"
        echo
        echo "      You should copy this .tab file into the directory:"
        echo "      $HOME_FOLDER"
        exit 1
        ;;
    1)  echo "INFO: Well it looks like you already have the ISO 639-3 Code table available and in the appropriate location."
        ;;
    *)  echo "! ERROR: There appears to be too many files in the $HOME_FOLDER that match:"
        echo "         iso-639-3*.tab"
        echo
        echo "         Please have only one ISO 639-3 file."
        exit 1
esac
