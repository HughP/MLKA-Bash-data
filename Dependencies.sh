if type csvfix &>/dev/null; then
    echo
    echo "INFO: Great you have csvfix installed."
else
    echo
    echo "! ERROR: Shucks! You do not have csvfix."
    echo "       You need to get it."
    echo "       You can use Mercurial and compile it"
    echo "       yourself from:"
    echo
    echo "       https://bitbucket.org/neilb/csvfix"
    echo
    echo "       If you are on OS X you can use Homebrew."
    echo "        'Brew install csvfix'."
    echo
    exit 1
fi

DEPENDENCIES=Dependencies.txt

#for i in $DEPENDENCIES
#according to the following link the above is disperfered in favor of the latter: http://stackoverflow.com/questions/1521462/looping-through-the-content-of-a-file-in-bash

while read p; do
  echo $p
done <$DEPENDENCIES


if [ -f iso-639-3.data ]; then
    # For every *wiki*.bz2 file do:
    for FILE in $(find * -maxdepth 0 -iname '*wiki*.bz2'); do
        for DATA in $(cat ../iso-639-3.data); do
            if [[ ${FILE:0:2} == ${DATA:7:2} ]]; then
                if [ -d ${DATA:1:3} ]; then
                    echo "INFO: Wiki-Data/${DATA:1:3} exists. We assume that there is already extracted Wikipedia data in that folder."
                else
                    mkdir ${DATA:1:3}
                    echo "INFO: We're extracting the ${DATA:11} [${DATA:1:3}] languge data." #This line needs testing
					START_EXTRACT=`date +%s` # This line needs testing.
                    python ../wikipedia-extractor/WikiExtractor.py -q -o ${DATA:1:3} $FILE
                    END_EXTRACT=`date +%s` # This line needs testing.
                    RUNTIME=$((END_EXTRACT-START_EXTRACT)) # This line needs testing.
                    echo "      We're back from processing the [${DATA:1:3}] languge data. It only took: $RUNTIME seconds." # This line needs testing.
                    # For other methods of finding time for the script running see here: http://unix.stackexchange.com/questions/52313/how-to-get-execution-time-of-a-script-effectively
                    echo
                    echo
                fi
            fi
        done
    done
fi


