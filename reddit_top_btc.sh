#!/bin/bash

wget -q 'https://www.reddit.com/r/Bitcoin/top' -O- | tr '>' '\n' | grep --color -A1 'title may-blank' | head -2 > tmpdata

link=`cat tmpdata | head -1 | sed 's/.*href="\(.*\)" tab.*/\1/g'` 
title=`cat tmpdata | tail -1 | sed 's/.*href="\(.*\)" tab.*/\1/g'| sed 's/&quot;//g;s/<\/a//g;s/[bB]itcoin/#Bitcoin/g'`

if [ `echo $link | cut -c1-4` == "http" ]
then
	echo ""
else
	linkt='http://reddit.com'$link
	link=$linkt
fi


if [ "`cat md5`" == "`echo $title | md5sum`" ]
then
	exit 2
fi

echo $title | md5sum > md5

echo $title
echo $link



