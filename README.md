# Regovar server

All commands below must be run as root.

The configuration has been tested with:
 - Debian 9 (Stretch)
 - Ubuntu 16.04 LTS (Xenial)
 - Ubuntu 18.04 LTS (Bionic)
 
It does *not* work with Debian 8 (Jessie).

## Deploying

### Getting the configuration

```sh
mkdir -p /srv
apt install git
git clone https://github.com/REGOVAR/ServerConfiguration.git /srv/salt
git clone https://github.com/REGOVAR/ServerConfigurationBrownie.git /srv/pillar # Use your own repository here
```

Note: if you have troubles even getting apt to access the network, it may be because your operating system is configured to prefer IPv6 while your network is IPv4 only.
In this case, you can use the following command to make your operating system prefer IPv4:

```sh
sed -i 's@^#\(precedence ::ffff:0:0/96  10\)@\1@' /etc/gai.conf
```

### Applying the configuration

Edit `/srv/pillar/settings.sls` as appropriate (the file is self-documented).

```sh
apt update
apt install salt-minion
salt-call --local state.highstate
```

This step may take some time, mainly depending on your network speed.

Note: if you have an error stating that "pip.installed is not available" when running highstate, then it may be that you are using a buggy version of pip (9.0.1 or 9.0.2). A [fix](https://github.com/pypa/pip/pull/4442/commits/048dacde21679cd43695a55ce3dd243e314fe06e) is shipped with pip 9.0.3 that you can apply manually to `/usr/lib/python3/dist-packages/pip/locations.py`.

```sh
apt upgrade
reboot now
```

## Updating the computer and the configuration

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
