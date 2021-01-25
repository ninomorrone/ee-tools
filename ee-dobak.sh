#!/bin/bash

ee="/opt/easyengine/sites"
backup="/home/backups"
sites=$(ls $ee)

date=`date +%d%m%Y-%H%M%S`

clear
mkdir -p $backup

for i in $sites
do
	ee shell $i --command="wp db export $i.sql"
	cd $ee/$i/app && zip -qr - htdocs | pv -ptrb -s $(du -bs htdocs | awk '{print $1}') > $i.zip
	# cd $ee/$i/app && tar czf - htdocs | (pv -ptrb > $i.tar.gz) -- gz
	rm $ee/$i/app/htdocs/$i.sql
	mkdir -p $backup/$i
	mv $ee/$i/app/$i.zip $backup/$i/$i-$date.zip
	# mv $ee/$i/app/$i.tar.gz $backup/$date -- gz
	cd $backup/$i
	ls -t | tail -n +4 | xargs -I {} rm {} # lascia solo gli ultimi 3
done

#/usr/bin/rsync --progress -e 'ssh -p23 -i /root/.ssh/id_rsa' --recursive --delete /home/backups u253933@u253933.your-storagebox.de:xhst-h1
/usr/bin/rsync --progress -e 'ssh -p23' --recursive --delete /home/backups u253933@u253933.your-storagebox.de:xhst-h1

cd ~
