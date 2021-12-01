#!/usr/bin/ksh

#export MAILTO="harneesi@in.ibm.com"
#export CONTENT="/soft/weblogic122/scripts/logcheck/fatwirefail.html"
#export SUBJECT="Digital Public Sites FATWIRE EXCEPTIONS"
(
 echo "From: tsb-mail-middleware@mail.com"
 echo "To: tsbopsid@mail.com"        
# echo "To: harneet.singh@mail.com"        
 echo "Cc: tsb-mail-middleware@mail.com"
 echo "Bcc: x4n7x1m0q5n5r4g8@mail.slack.com"
 echo "Subject: $SUBJECT"
 echo "MIME-Version: 1.0"
 echo "Content-Type: text/html"
 echo "Content-Disposition: inline"
 echo $CONTENT
) | /usr/sbin/sendmail -vit 
