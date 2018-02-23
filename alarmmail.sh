#!/bin/bash
startdatesecond=$(more ./datestart)
changedatesecond=$(expr "$startdatesecond" + "345600")
nowdatesecond=$(date +%s)
dvaluesecond=$(expr "$changedatesecond" - "$nowdatesecond")
changedate=$(date -d "1970-01-01 utc $changedatesecond seconds")

if [ $dvaluesecond -lt 259200 -a $dvaluesecond -gt '0' ];then
	echo "Please change root password of CCSVNA before $changedate" | mail -s "[script test]CCSVNA Change Root Password" china_it_tickets@.com
elif [ $dvaluesecond -lt '259200' -a $dvaluesecond -lt '0' ];then
	echo "Please change root password of CCSVNA before $changedate" | mail -s "[script test]CCSVNA Root Password Expired" china_it_tickets@.com
	cat $changedatesecond > ./datestart
fi
