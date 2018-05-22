# Regovar server

## Deployment as root on Debian or Ubuntu

```sh
sed -i 's@^#\(precedence ::ffff:0:0/96  10\)@\1@' /etc/gai.conf # to prefer IPv4 to IPv6, necessary in some places
apt install salt-minion git
mkdir -p /srv
git clone https://github.com/REGOVAR/ServerConfiguration.git /srv/salt
git clone https://github.com/REGOVAR/ServerConfigurationBrownie.git /srv/pillar # Use your own repository here
```

Edit /srv/pillar/settings.sls as appropriate (the file is self-documented).

### Apply the SaltStack Configuration

```sh
apt update
salt-call --local state.highstate
```

This step may take some time, mainly depending on your network speed.
If you have an error stating that "pip.installed is not available" when running highstate, then it may be that you are using a buggy version of pip (9.0.1 or 9.0.2). A [fix](https://github.com/pypa/pip/pull/4442/commits/048dacde21679cd43695a55ce3dd243e314fe06e) is shipped with pip 9.0.3 that you can apply manually to `/usr/lib/python3/dist-packages/pip/locations.py`.

```sh
apt upgrade
reboot now
```

## Update the computer and the configuration as root on Debian or Ubuntu

```sh
cd /srv/salt
git pull
cd /srv/pillar
git pull
apt update
salt-call --local state.highstate
apt upgrade
reboot now
```
