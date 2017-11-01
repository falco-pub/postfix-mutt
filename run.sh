#!/bin/bash

touch /var/log/maillog
touch /var/log/messages
chmod o+r /var/log/*

pushd /etc/postfix/
for f in `find -type f`; do
    c=`awk '/^#run:/ {gsub (/^#run:/,""); print $0}' $f`
    [ -z "$c" ] || ( echo + $c $f && eval $c $f )
done
popd

[ -r /etc/postfix/ssl.key ] && [ -r /etc/postfix/ssl.crt ] || openssl req -x509 -newkey rsa:4096 -keyout /etc/postfix/ssl.key -out /etc/postfix/ssl.crt -nodes -days 365 -subj '/CN=mx1.pfix'

pushd /
/usr/bin/supervisord


