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

if [ -d "${1}" ] && [ -d "${2}" ]
then
  sourceDir=`basename "${1}"`
  if ! [ -d "${2}"/"${sourceDir}" ]
  then
    mkdir "${2}"/"${sourceDir}"
  fi

  echo "Copying directory '${1}' under ${2} ..."
  cp -p "${1}"/* "${2}"/"${sourceDir}"/
  echo "Ready."
else
  printErrorAndUsage "${1} or ${2} is not a directory."
fi
