#!/bin/bash

today=$(date +%y-%m-%d)
echo $today

#在ftp上以日期创建dump文件夹
#输入FTP的用户名和密码
svn_mkdir() 
{
ftp -n 10.x.x.x << EOF
user svnftp SVwsx@ 
cd svn
mkdir dump-$today
EOF
}

svn_upload()
{
ftp -n 10.x.x.x << EOF
user svnftp SVwsx@
cd svn
cd dump-$today
bin
prompt
mput *.tar.gz
exit
EOF
}


cd /dump

svn_mkdir

reponames=$(ls /opt/svnroot)

for name in $reponames
do
	svnadmin dump /opt/svnroot/$name >> /dump/$name-$today.dump 
	tar -zcvf /dump/$name-$today.tar.gz /dump/$name-$today.dump
	svn_upload 2>>/root/dumpsync/errors.log
	rm -rf /dump/*
done



if [ $? -eq 0 ];
then 
echo "Dump Succeeded" | mail -s "Dump to FTP Succeeded" xxx@xxx.com;
else 
cat /root/dumpsync/errors.log | mail -s " Backup Failed" xxx@xxx.com;
fi

#rm -rf /opt/svndump/*.tar.gz


