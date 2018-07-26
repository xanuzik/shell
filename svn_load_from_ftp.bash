#!/bin/bash

tar_download()
{
ftp -n 10.1.0.10 <<EOF
user ftp 2wsx!@
cd svn
cd dump-18-07-22
bin
get ${rname}-18-07-22.tar.gz
exit
EOF
}

for rname in `more ./revs.txt`
do
	svnadmin create /opt/svnroot/$rname
	tar_download
	tar -xvf ./${rname}-18-07-22.tar.gz
	svnadmin load /opt/svnroot/$rname < /dump/dump/${rname}-18-07-22.dump
	rm -rf dump
	rm -rf *.gz
done
 
