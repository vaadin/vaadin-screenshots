#!/bin/bash

if [ "$#" = "0" ]
then
        echo "Usage: $0 <screenshots to add>"
        exit 1
fi


refdir=`dirname $0`/../reference

for filepath in $*
do
        file=`basename $filepath`
        target="$refdir/$file"
        
        alt=0
        
        while [ -e $target ]
        do
                alt=$(($alt+1))
                target="$refdir/"`echo $file|sed "s/.png/_$alt.png/g"`
        done
        
        cp "$filepath" "$target"
done
