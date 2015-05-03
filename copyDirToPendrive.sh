#!/bin/bash
# copyDirToPendrive.sh
#
# mp3 file copier in order to preserve the file order on the pendrive
# It simply creates the directory and copies the fies one by one
# This method prevents mixing of files in the target directory since the shell puts the files onto the media one by one in the order the shell wants
# Usage: copyDirToPendrive.sh <sourceDir> <targetDir>

# Version history
# V1.0 - 09.11.2011 - First trial
# V1.1 - 11.11.2011 - Checking of number of positional parameters and checking of existance of directories
# V1.2 - 20.11.2011 - Source directory basename in order to use with full path
# Further versions in GIT

if [ $# -ne 2 ]
then
  echo "Insufficient number of parameters"
  echo "Usage: `basename $0` <sourceDir> <targetDir>"
  exit 1
fi

echo $1 $2

if [ -d "$1" ] && [ -d "$2" ]
then
  sourceDir=`basename "$1"`
  echo "Copying..."
  mkdir "$2"/"$sourceDir"
  cp -p "$1"/* "$2"/"$sourceDir"/
  echo "Ready."
  echo "The files just copied are (directory order):"
  ls -fl "$2"/"$sourceDir"
else
  echo "$1 or $2 is not a directory"
  echo "Usage: `basename $0` <sourceDir> <targetDir>"
  exit 1
fi
