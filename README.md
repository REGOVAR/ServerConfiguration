# Regovar server

## As root on Debian

### Deployment

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

### Upgrade

```sh
cd /srv/salt
git pull
apt update
salt-call --local state.highstate
apt upgrade
reboot now
```

## As root on Ubuntu

### Deployment

```sh
apt install salt-minion git
mkdir -p /srv
git clone https://github.com/REGOVAR/ServerConfiguration.git /srv/salt
apt update
salt-call --local state.highstate
apt upgrade
reboot now
```

### Upgrade

```sh
cd /srv/salt
git pull
apt update
salt-call --local state.highstate
apt upgrade
reboot now
```
