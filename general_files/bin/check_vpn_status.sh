#!/bin/sh

server_vpn_ip="10.8.0.1"
png=$(ping -c1 -W1 $server_vpn_ip | grep ttl)
if [ -z "$png" ]; then
  png=$(ping -c1 -W3 $server_vpn_ip | grep ttl)
    if [ -z "$png" ]; then
      png=$(ping -c1 -W5 $server_vpn_ip | grep ttl)
    fi
fi

if [ -z "$png" ]; then
  echo 0 > /sys/class/leds/dragino2:red:system/brightness
  /etc/init.d/openvpn restart
else
  echo 255 > /sys/class/leds/dragino2:red:system/brightness
fi

