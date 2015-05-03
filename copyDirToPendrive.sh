#!/bin/bash
# copyDirToPendrive.sh
#
# mp3 file copier in order to preserve the file order on the pendrive
# It simply creates the directory and copies the fies one by one
# This method prevents mixing of files in the target directory since the shell puts the files onto the media one by one in the order the shell wants

# Usage: copyDirToPendrive.sh <sourceDir> <targetParentDir>
# The directory <sourceDir> will be copied under <targetParentDir>

# Version history
# V1.0 - 09.11.2011 - First trial
# V1.1 - 11.11.2011 - Checking of number of positional parameters and checking of existance of directories
# V1.2 - 20.11.2011 - Source directory basename in order to use with full path
# Further versions in GIT


# Functions

function printErrorAndUsage {
    echo "${1}"
    echo "Usage: `basename ${0}` <sourceDir> <targetParentDir>"
    exit 1
}


# Main

if [ $# -ne 2 ]
then
    printErrorAndUsage "Insufficient number of parameters."
fi

if ! [ -d "${1}" ] || ! [ -d "${2}" ]
then
    printErrorAndUsage "${1} or ${2} are not directories."
fi

sourceDir=`basename "${1}"`
targetDir="${2}"/"${sourceDir}"

if ! [ -d "${targetDir}" ]
then
    mkdir "${targetDir}"
fi

for actFile in "${1}"/*
do
    if [ -d "${actFile}" ]
    then
        "${0}" "${actFile}" "${targetDir}"
    elif [ -f "${actFile}" ]
    then
        echo "Copying file ${actFile} ${targetDir}/"
        cp -p "${actFile}" "${targetDir}"/
    fi
done
