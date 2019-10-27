#!/bin/bash
echo "status:" > /tmp/file.txt
awk '{print $1}' /vagrant/access.log | uniq -c | sort -k1nr | head >> /tmp/file.txt
echo "\n" >> /tmp/file.txt
awk -F\" '{print $2}' /vagrant/access.log | awk '{print $2}' | sort | uniq -c | sort -k1nr | head >> /tmp/file.txt
echo "\n" >> /tmp/file.txt
awk '{print $9}' /vagrant/access.log | sort | uniq -c | sort -k1nr >> /tmp/file.txt
echo "\n ok)" >> /tmp/file.txt
mail -s "From file" vagrant@vagrant.vm < /tmp/file.txt
