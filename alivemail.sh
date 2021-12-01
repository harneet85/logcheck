#!/usr/bin/ksh

#export MAILTO="harneesi@in.ibm.com"
#export CONTENT="/soft/weblogic122/scripts/logcheck/2.0/alive.html"
export SUBJECT="main script alive"
(
 echo "From: tsb-mail-middleware@mail.com"
 echo "To: harneet.singh@mail.com"        
 echo "Subject: $SUBJECT"
 echo "MIME-Version: 1.0"
 echo "Content-Type: text/html"
 echo "Content-Disposition: inline"
 echo $CONTENT
) | /usr/sbin/sendmail -vit 
