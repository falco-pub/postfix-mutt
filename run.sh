#!/bin/bash

touch /var/log/maillog
touch /var/log/messages
chmod o+r /var/log/*

postmap /etc/postfix/user/saslpass

/usr/bin/supervisord


