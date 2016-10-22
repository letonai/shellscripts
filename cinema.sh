#!/bin/bash
#echo -e "Cinemark Villa Lobos"
#links -codepage utf-8 -dump 'http://www.cinemark.com.br/programacao/sao-paulo/villa-lobos/1/727' | grep -A1000 "POR" | sed 's/^[ ]*//g' | egrep "^[0-9]*h" -B2

data=`echo $data | egrep  "[0-9\-]" | tr -d " "`
data=`if [ -z $data ] ;then date +%Y-%m-%d;else echo $1;fi`

prog=_`curl -s 'http://www.cinemark.com.br/programacao/sao-paulo/villa-lobos/1/727' | gzip -d | grep xxxx -A1 | grep $data -B1 | sed -e 's/.*">\(.*\)&nbsp;<.*/\1/g' | sed 's/> - </\n/g' | sed 's/.*>\([0-9][0-9]h[0-9][0-9]\)<.*/\1/g' | tr "\n" "_"`

#echo $prog

echo $prog | sed 's/--/\n/g'|sed 's/_/%/2' | while read moviedata
do
	movie=`echo ${moviedata} | cut -d'%' -f1 | sed 's/_//1'`
	trailer=`wget -q "https://www.youtube.com/results?search_query=\"$movie Trailer\"" -O- | grep Trailer | tr ">" "\n" | grep 'v=' | sed 's/"\/watch?v=\(.*\)"\ c.*/\1/g' | sed 's/.*=\(.*\)$/\1/g' | head -1`
	movietimes=`echo ${moviedata} | cut -d'%' -f2 | sed 's/_/ /g'`
	echo -e "$movie \n🎬: https://m.youtube.com/watch?v=$trailer \n⏰: $movietimes\n"
done


