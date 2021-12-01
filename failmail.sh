#!/usr/bin/ksh

#export MAILTO="harneesi@in.ibm.com"
#export CONTENT="/soft/weblogic122/scripts/logcheck/fatwirefail.html"
#export SUBJECT="Digital Public Sites FATWIRE EXCEPTIONS"
(
 echo "From: some@some.com"
 echo "To: some@some.com"        
 echo "Subject: $SUBJECT"
 echo "MIME-Version: 1.0"
 echo "Content-Type: text/html"
 echo "Content-Disposition: inline"
 echo $CONTENT
) | /usr/sbin/sendmail -vit 
