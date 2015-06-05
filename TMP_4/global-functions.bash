#!/bin/bash

source ../global-vars.bash

# http://tldp.org/LDP/abs/html/functions.html

function PrintError ()
{
    if [ -n "$1" ]; then
        echo -e "ERROR:\t" $1
    else
        echo
    fi
}

function PrintInfo ()
{
    if [ -n "$1" ]; then
        echo -e "INFO:\t" $1
    else
        echo
    fi
}
