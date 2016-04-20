#!/bin/sh

set -ex

apt-get install -y dnsmasq avahi-daemon # networking

cat  >> /etc/dnsmasq.conf <<EOF
interface=br0
dhcp-range=192.168.77.3,192.168.77.200,1h
EOF

# activate IP forwarding
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sysctl -p /etc/sysctl.conf

# set eth1 in manual mode
cat  > /tmp/update-eth1 <<EOF
s/iface eth1 inet static/iface eth1 inet manual/
/address 192.168.77.2/d
/netmask 255.255.255.0/d
EOF

sed -i"" -f /tmp/update-eth1 /etc/network/interfaces

# setup bridge br0 interface 
cat  >> /etc/network/interfaces <<EOF
auto br0
iface br0 inet static
    bridge_ports eth1
    address 192.168.77.2
    broadcast 192.168.77.255
    netmask 255.255.255.0
EOF

# stop eth1 then activate both interfaces
ifdown eth1
ifup br0

