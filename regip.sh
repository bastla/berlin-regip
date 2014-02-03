#!/bin/sh

if [ "$#" -lt "7" ]; then
        echo "usage: $0 <user> <password>" \
		"<network 104.13.9> <range start> <range end> <plz> <description>"
        exit 1
fi

# Postleitzahl, Beschreibung
plz="$6"
description="$7"
# Username von https://ip.berlin.freifunk.net/
usr="$1"
# Passwort von https://ip.berlin.freifunk.net/
pw="$2"
# Range
net=$3
i=$4
end=$5

# Go
curl --insecure -c newcookies.txt -d "usr=$usr&pw=$pw" https://ip.berlin.freifunk.net/ip/ip_neu.html > ip_neu.html

while [ $i -le $end ] ; do
curl --insecure -b newcookies.txt -d "ip_type=wish&wishIP=$net.$i&plz=$plz&description=${description}&action=ip_neu_dyn" https://ip.berlin.freifunk.net/ip/ip_neu.html > ip_neu.html
echo $1.$i
#echo "ip_type=wish&wishIP=$net.$i&plz=10437&action=ip_neu_dyn"
i=`expr $i + 1`
done
