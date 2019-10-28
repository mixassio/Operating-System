#!/bin/bash

VAR_FILE=/tmp/variable.file
if [ -f $VAR_FILE ];
then
  BEGIN_NR=`cat /tmp/variable.file | awk '{print $2}'`;
else
  BEGIN_NR=1;
fi;

END_NR=`awk 'END{print NR}' /vagrant/access.log`
SINCE_TIMESTAMP=`awk -v A="$BEGIN_NR" '(NR == A) { print substr($4,2) }' /vagrant/access.log`
END_TIMESTAMP=`awk -v Z="$END_NR" '(NR == Z) { print substr($4,2) }' /vagrant/access.log`

echo "Status report about requests, responses, errors." > /tmp/output.txt

echo "10 IP max count request" >> /tmp/output.txt
awk -v START="$BEGIN_NR" '(NR > START) {print $1}' /vagrant/access.log | uniq -c | sort -k1nr | head >> /tmp/output.txt

echo "10 max count response address" >> /tmp/output.txt
awk -v START="$BEGIN_NR" -F\" '(NR > START) {print $2}' /vagrant/access.log | awk '{print $2}' | sort | uniq -c | sort -k1nr | head >> /tmp/output.txt

echo "10 max count status-code" >> /tmp/output.txt
awk -v START="$BEGIN_NR" '(NR > START) {print $9}' /vagrant/access.log | sort | uniq -c | sort -k1nr >> /tmp/output.txt
echo "Data was handled sinse ${SINCE_TIMESTAMP} to ${END_TIMESTAMP}" >> /tmp/output.txt

mail -s "Report ${SINCE_TIMESTAMP} - ${END_TIMESTAMP}" vagrant@vagrant.vm < /tmp/output.txt

echo "BEGIN_NR ${END_NR}" | cat > /tmp/variable.file