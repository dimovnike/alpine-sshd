#!/bin/sh

set -e

#prepare ssh
if [ ! -f "/etc/ssh/ssh_host_rsa_key" ]; then
	# generate fresh rsa key
	ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
fi
if [ ! -f "/etc/ssh/ssh_host_dsa_key" ]; then
	# generate fresh dsa key
	ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
fi

#prepare run dir
if [ ! -d "/var/run/sshd" ]; then
  mkdir -p /var/run/sshd
fi

if which iptables > /dev/null; then
	# in case we have iptables, allow ssh only from inside (in case its used with openvpn layer)
	iptables -A INPUT  -i eth0 -p tcp --dport 22 -j ACCEPT
	iptables -A OUTPUT -o eth0 -p tcp --sport 22 -m state --state ESTABLISHED,RELATED -j ACCEPT
fi

/usr/sbin/sshd -D -e

# take the whole container with us
echo sshd died
kill 1 # kill the supervisor so the container dies
