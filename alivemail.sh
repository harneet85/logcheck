#!/usr/bin/ksh

#export MAILTO="harneesi@in.ibm.com"
export CONTENT="/soft/weblogic122/scripts/logcheck/2.0/alive.html"
export SUBJECT="main script alive"
(
 echo "From: some@some.com"
 echo "To: some@some.com"        
 echo "Subject: $SUBJECT"
 echo "MIME-Version: 1.0"
 echo "Content-Type: text/html"
 echo "Content-Disposition: inline"
 cat $CONTENT
) | /usr/sbin/sendmail -vit 
