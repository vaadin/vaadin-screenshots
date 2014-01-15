#!/bin/bash

if [ "$#" != "2" ]
then
	echo "Usage: $0 <old name> <new name>"
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
git pull --rebase

fromname=$1
toname=$2
from="$fromname"
to="$toname"

echo "About to rename "$from"* to "$to"*"
echo "Press enter to continue..."
read

for file in $from*.png
do
	tofile=`echo $file|sed "s/^$fromname/$toname/"`
	git mv "$file" "$tofile"
done

#echo "Done. If every thing looks ok, run"
#echo "git commit -m \"Renamed screenshots for $browser $fromversion to $browser $toversion\""
