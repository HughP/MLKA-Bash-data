#!/bin/bash
# Author: Jonathan Duff <jonathan@dufffamily.org>
# Version: 1.0
# Usage:
#        Matches all *wiki*.bx2 files
#        to all iso-639-3*.tab files combined.
#        Then creates corisponding directory
#        in Wiki-Data.

### FYI: Something not tested is malformed *wiki*.bz2 files
###      like all caps.

function cleanup() {
    # Sweep up after:
    if [ -f tmp_buffer.data ]; then
        rm tmp_buffer.data
    fi

    if [ -f tmp_buffer_csv.data ]; then
        rm tmp_buffer_csv.data
    fi

    if [ -f tmp_buffer_csv_col14.data ]; then
        rm tmp_buffer_csv_col14.data
    fi
}

# Check that cleancsv exists:
if [ ! -f cleancsv/cleancsv ]; then
    echo "ERROR: cleancsv program not found!"
    # Clean up left over files then exit:
    exit
fi

# Clean up before program starts:
cleanup

# Generate a combined and complete master TAB file:
for I in $(find * -maxdepth 0 -iname 'iso-639-3*.tab'); do
    cat $I >> tmp_buffer.data
    echo >> tmp_buffer.data
done

# Create a new TAB with the only needed columbs:
csvfix read_dsv -s '\t' tmp_buffer.data > tmp_buffer_csv.data
csvfix order -f 1,4 tmp_buffer_csv.data > tmp_buffer_csv_col14.data

if [ -f tmp_buffer_csv_col14.data ]; then

    # For every *wiki*.bz2 file do:
    for I in $(find * -maxdepth 0 -iname '*wiki*.bz2'); do
	# This variable contains the first two
	# characters of the *wiki*.bz2 file:
	FIRST_TWO_CHARS=${I:0:2}

	# Verify cleancsv exists before exacution:
	if [ -f cleancsv/cleancsv ]; then
	    ./cleancsv/cleancsv tmp_buffer_csv_col14.data > ready.data
	else
	    echo "ERROR: cleancsv program not found!"
	    # Clean up left over files then exit:
	    cleanup
	    exit
	fi

	# For every entry in the new master TAB do:
	for Z in $(cat ready.data); do
	    # This variable contains the two character
	    # at the position 7 in current row:
	    SECOND_COL=${Z:7:2}

	    if [ "$FIRST_TWO_CHARS" == "$SECOND_COL" ]; then
		# This variable contains the three characters
		# at position 1 in current row:
		FIRST_COL=${Z:1:3}
		if [ -d Wiki-Data/$FIRST_COL ]; then
		    echo "INFO: Wiki-Data/$FIRST_COL exists"
		else
		    mkdir Wiki-Data/$FIRST_COL
	        fi
	    fi
	done
    done
fi

# Clean up left over files:
cleanup
