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
mkdir -p ./fail;

# 総件数を取得
TOTAL=$(wc -l < ../url.txt)
COUNT=0

for i in $(cat ../url.txt) ; do
	COUNT=$((COUNT + 1))

	sleep 2;
	curl -A "Mozilla/5.0" -sS --ciphers 'DEFAULT:!DH' -O $(echo $i | tr '\r' ' ') ;

	if [ "$?" = "0" ]; then
		NOW=`/bin/ls -rt1 | grep -v curls.sh | tail -1`
		rec $NOW
		FILENAME=`/bin/ls -rt1 | grep -v curls.sh | tail -1`

		# file 判定（text を含む＝HTML＝失敗）
			if file "$FILENAME" | grep -qi "text"; then
				echo "[${COUNT}/${TOTAL}] FAIL (HTML detected): $FILENAME"
				mv "$FILENAME" ./fail/
				continue
			fi

			# 正常ファイル
			mv "$FILENAME" ./end/
			echo "[${COUNT}/${TOTAL}] OK: $FILENAME"

	else
		echo "[${COUNT}/${TOTAL}] curl failed: $i"
	fi
done

exit 0;

