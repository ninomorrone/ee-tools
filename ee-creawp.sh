#!/bin/bash

# creawp <dominio> <user opz>
# creawp  sito.com utente
# 

lsep="------------------------"
dominio=$1
if [ -z "$2" ]
then
   dname=d-$1
   duser=u-$1
else
   dname=d-$2
   duser=u-$2
fi


clear
echo "IC NETWORK"
echo "installazione sito $1"

ee site create $dominio \
        --type=wp --php=7.4 --proxy-cache=on \
        --dbname=$dname --dbuser=$duser --dbpass=Db@Icnet_220k \
        --title=$dominio --locale=it_IT --dbprefix=wp_ \
        --admin-email=webmaster@icnet.it --admin-user=icadmin --admin-pass=Tenci_Krow@221k \
        --ssl=le

<< TMP
clear
echo "Dominio $dominio: OK "
echo $lsep
echo "DB ...: $dname"
echo "USER .: $duser"
echo $lsep
TMP
