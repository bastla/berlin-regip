#!/bin/bash

if [ "$#" -lt "6" ]; then
        echo -e "usage:\t$0 <user>" \
                "<network> <range start> <range end> <plz> <description>" \
                "\n\n" \
                "Example: 104.42.42.1/28\n\n" \
                "$0 foobar 104.42.42 1 15 10997 'foo description'"
        exit 1
fi

# Username von https://ip.berlin.freifunk.net/
usr="$1"

# Range
net=$2
i=$3
end=$4

# Postleitzahl, Beschreibung
plz="$5"
description="$6"

# Passwort von https://ip.berlin.freifunk.net/
read -s -p "Enter Password: " pw

echo -e "\nRegistering your IPs: $2.$i - $2.$end"

# Go
curl -s --insecure -c newcookies.txt -d "usr=$usr&pw=$pw" https://ip.berlin.freifunk.net/ip/ip_neu.html > ip_neu.html

while [ $i -le $end ] ; do
curl -s --insecure -b newcookies.txt -d "ip_type=wish&wishIP=$net.$i&plz=$plz&description=${description}&action=ip_neu_dyn" https://ip.berlin.freifunk.net/ip/ip_neu.html > ip_neu.html
echo -e "\t$2.$i"
#echo "ip_type=wish&wishIP=$net.$i&plz=10437&action=ip_neu_dyn"
i=`expr $i + 1`
done
