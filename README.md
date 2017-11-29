# Regovar server

## Deployment as root on Debian

```sh
apt install salt-minion git
mkdir -p /srv
git clone https://github.com/REGOVAR/server_configuration.git /srv/salt
apt update
salt-call --local state.highstate
apt upgrade
reboot now
```
