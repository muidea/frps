#!/bin/sh

if [ $Endpoint ]; then
  /var/app/frpc -c /var/app/config/frpc.ini
else
  /var/app/frps -c /var/app/config/frps.ini
fi
