#!/bin/bash

touch /var/log/maillog
touch /var/log/messages
chmod o+r /var/log/*

pushd /etc/postfix/user/
for f in `find -type f`; do
    c=`awk '/^#run:/ {gsub (/^#run:/,""); print $0}' $f`
    [ -z "$c" ] || ( echo + $c $f && eval $c $f )
done
popd

/usr/bin/supervisord


