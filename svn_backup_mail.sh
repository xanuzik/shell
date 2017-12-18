#!/bin/bash

cd /root/svnsync

date=$(date +%Y/%m/%d)
diskusage=$(df /opt/ | awk 'NR=='2 | awk -F " " '{print $5}')
echo "Sync date $date , svnroot takes $diskusage of 500GB harddrive" >> success.txt
echo " " >> success.txt

i=1
for reponame in `ls /opt/svnroot`
do
	newsize=$(du -shm /opt/svnroot/$reponame | awk -F " " '{print $1}')
	echo $newsize >> newsize.txt
	oldsize=$(cat oldsize.txt | awk 'NR=='$i'{print $1}')
	newversion=$(svnlook youngest /opt/svnroot/$reponame)
	echo $newversion >> newversion.txt
	oldversion=$(cat oldversion.txt | awk 'NR=='$i'{print $1}')
	i=$(($i+1))
	echo "Repo $reponame : Version $oldversion >> $newversion Size $oldsize MB  >>  $newsize MB" >> success.txt
	echo " " >> success.txt
done

cat success.txt | mail -s "CCSVNB Backup Succeeded" morty.han@avepoint.com

mv -f newsize.txt oldsize.txt
mv -f newversion.txt oldversion.txt
mv -f success.txt oldsuccess.txt
