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

DISTRO=$(cut -f 1 -d ' ' -s /etc/issue)
INTF=$(ifconfig -a | sed 's/[ \t:].*//;/^\(lo\|\)$/d' | head -n2 | tail -1)

cat >> /etc/network/interfaces <<EOF
auto xenbr0
iface xenbr0 inet dhcp
  bridge_ports $INTF
EOF

# if [ "$DISTRO" = "Debian" ] ; then
# else
# fi

# stop eth1 then activate both interfaces
ifdown $INTF
ifup xenbr0