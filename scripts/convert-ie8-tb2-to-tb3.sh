#!/bin/bash

script=`dirname $0`

convert --version 2>&1|grep ImageMagick > /dev/null
if [ "$?" != "0" ]
then
	echo "You need to have the 'convert' tool from ImageMagick available in PATH"
	exit 1
fi

if [ "$#" = "0" ]
then
	echo "Usage: $0 <images to convert>"
	exit 2
fi


for a in $*
do
	convert $a -crop 1496x846+0+0 png:$script/cropped.png
	convert $script/ie8-topborder-narrow.png -append $script/cropped.png -append $script/ie8-bottomborder-narrow.png -append png:$script/withtopbottom.png
	convert $script/ie8-leftborder.png +append $script/withtopbottom.png +append ie8-rightborder.png +append png:$a
	
done
