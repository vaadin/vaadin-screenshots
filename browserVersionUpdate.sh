#!/bin/bash

if [ "$#" != "3" ]
then
	echo "Usage: $0 <Browser identifier> <old version> <new version>"
	echo "e.g. \"$0 Chrome 14 15\" to update from Chrome 14 to Chrome 15"
	exit
fi

git status|grep  "nothing to commit (working directory clean)" > /dev/null
if [ "$?" != "0" ] 
then
	git status
	echo "You need to have a clean working directory when running this script"
	exit
fi

echo "Ensuring we are up-to-date so we won't miss any screenshots"
git pull

browser=$1
fromversion=$2
toversion=$3
from=$browser"_"$fromversion
to=$browser"_"$toversion


echo "About to rename *_"$from"_* to *_"$to"_*"
echo "Press enter to continue..."
read

for file in *_"$from"_*.png
do
	tofile=`echo $file|sed "s/$from/$to/"`
	git mv "$file" "$tofile"
done

echo "Done. If every thing looks ok, run"
echo "git commit -m \"Renamed screenshots for $browser $fromversion to $browser $toversion\""
