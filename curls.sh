#!/bin/bash

## $1 = NOW
rec()
{
  NOW=$1
  OLD=`echo ./end/$NOW`
  if [ -e $OLD ]; then 
	  mv $NOW _$NOW
	  rec _$NOW
  fi
  return;
}

mkdir -p ./end;
for i in $(cat ../url.txt) ; 
do 
	curl -sS --ciphers 'DEFAULT:!DH' -O $(echo $i | tr '\r' ' ') ; 
	if [ "$?" = "0" ]; then
		NOW=`/bin/ls -rt1 | grep -v curls.sh | tail -1`
		rec $NOW
		FILENAME=`/bin/ls -rt1 | grep -v curls.sh | tail -1`
		mv $FILENAME ./end/
		echo $FILENAME
	else 
		echo "fail to curl: $i"
	fi
done

exit 0;

