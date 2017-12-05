# Regovar server

## Deployment as root on Debian

```sh
sed -i 's@^#\(precedence ::ffff:0:0/96  100\)@\1@' /etc/gai.conf
apt install salt-minion git
mkdir -p /srv
git clone https://github.com/REGOVAR/ServerConfiguration.git /srv/salt
apt update
salt-call --local state.highstate
apt upgrade
reboot now
```
