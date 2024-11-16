#!/bin/bash
echo "Enter the network ID you want to scan (e.g. 192.168.1.0):"
read network
echo "Enter the subnet mask in CIDR notation (e.g. 24):"
read mask
if [[ $mask =~ ^[0-9]+$ ]] && [ $mask -le 32 ]; then
  wildcard=$(( 2**(32-$mask) - 1 ))
  network_address=$(echo $network | awk -F'.' '{print
$1"."$2"."$3"."0}')
  for host in $(seq 1 254); do
    ip=$(echo $network_address | awk -F'.' '{print
$1"."$2"."$3"."'$host'}')
    ping -c1 -W1 $ip > /dev/null
    if [ $? -eq 0 ]; then
      echo "$ip is up"
    fi
  done
else
  echo "Invalid subnet mask"
fi
