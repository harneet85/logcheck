#!/bin/bash
# creator - harneet.singh@mail.com
# date - 20 Nov 2021
# checks for FATWIRE and Genreic Server Error
#set -x

#### Variables ##################
servers=(server1 server2 server3)
myscripdir="/soft/weblogic122/scripts/logcheck/2.0/"
logfile1="/logs/domains/dompublicp/wcsites_server/wcsites_server_???.log"
logfile2="/logs/domains/dompublicp/wcsites_server/wcsites_server_???.out"
logfile3="/logs/domains/dompublicp/wcsites_server/sites-odl.log"
string1="Could not initialize class oracle.fatwire.security.common.SecureUtility"
string2="GENERIC SERVER ERROR"


#### functions ################

setdate(){
        mydate=`date +%Y%m%d-%H%M`
}


failmail(){
	setdate
	echo "$mydate :$1 :Errors in $2 : $3"
	MSG="$mydate :$1 :Errors in $2 : $3"
	export CONTENT=`cat ${myscripdir}fail.html | sed "s)REPLACEME)${MSG})g"`
	export SUBJECT="Digital Public site : Failures"
	echo $CONTENT
	${myscripdir}failmail.sh
}


alivemail(){
        setdate
	cp ${myscripdir}alive.html.org ${myscripdir}alive.html
        #echo "$mydate : Sending Alive mail"
	MSG2=`tail -n13 ${myscripdir}main.log| sed ':a;N;$!ba;s/\n/<br>/g'`
	export CONTENT=`cat ${myscripdir}alive.html |sed "s)REPLACEME)${MSG2})g"`
        ${myscripdir}alivemail.sh 2>&1 >> ${myscripdir}alivemail.log
}

logrotate(){
	datestamp=`date +%d%m%y`
	fileexists=`ls -lrt ${myscripdir} | grep -i $datestamp | grep -iv grep |wc -l`
	if [[ $fileexists -gt 0 ]]
	then
		echo "File with today timestamp exists , no log rotation"
	else
		cp ${myscripdir}main.log ${myscripdir}main.log.$datestamp
		cat /dev/null > ${myscripdir}main.log
		find ${myscripdir} -iname "main.log.*" -mtime +20 -exec rm -rf {} \;
		touch ${myscripdir}main.log
	fi
}



## usage 
# checklogsfunction $1 $2 $3 $4
# example checklogsfunction $logfile1 $string1 2000 0
# checklogsfunction logfile string lines values
checklogsfunction(){
	setdate
	logout=`ssh $i "tail -n$3 $1" 2>&1 | grep -ic "${2}"|grep -i [0-9]`
        if [[ $logout -gt $4 ]]
        then
                echo "$mydate :$i $1 $2 : count-$logout"
                failmail $i "$1" "$2"
                exit
        fi
        echo "$mydate :$i $1 :count $logout -is ok"

}

#
#main
logrotate
for i in ${servers[@]}
do
	checklogsfunction "$logfile1" "$string1" 2000 0
	checklogsfunction "$logfile2" "$string1" 2000 0
	checklogsfunction "$logfile3" "$string2" +1 1000
done
alivemail
