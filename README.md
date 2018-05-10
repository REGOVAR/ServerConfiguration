# Regovar server

## Deployment as root on Debian or Ubuntu

```sh
sed -i 's@^#\(precedence ::ffff:0:0/96  10\)@\1@' /etc/gai.conf # to prefer IPv4 to IPv6, necessary in some places
apt install salt-minion git
mkdir -p /srv
git clone https://github.com/REGOVAR/ServerConfiguration.git /srv/salt

```

In the lines below, replace $HOSTNAME with the name you want to give to your computer.
```sh
sed -i 's/HOSTNAME_PLACEHOLDER/$HOSTNAME/' /srv/salt/hostname
sed -i 's/HOSTNAME_PLACEHOLDER/$HOSTNAME/' /srv/salt/hosts
```

In the lines below, replace:
- $EMAIL with the email address of the computer administrator,
- $SMTP_HOSTNAME with the hostname of the SMTP server (eg. smtp.gmail.com if your email is on Gmail),
- $SMTP_PORT with the port of the SMTP server (eg. 465 if your email is on Gmail),
- $SMTP_PASSWORD with the email password of the computer administrator,
- $DOMAIN with the email domain (eg. gmail.com if your email is on Gmail),
- $HOSTNAME with the name of your computer.
We recommend to use a email account dedicated to this machine and not your personal mail account. This email account will be used to send all the automatic emails from this machine.

```sh
sed -i 's/EMAIL_PLACEHOLDER/$EMAIL/' /srv/salt/mail/revaliases
sed -i 's/EMAIL_PLACEHOLDER/$EMAIL/ ; s/SMTP_HOSTNAME_PLACEHOLDER/$SMTP_HOSTNAME/ ; s/SMTP_PORT_PLACEHOLDER/$SMTP_PORT/ ; s/SMTP_PASSWORD_PLACEHOLDER/$PASSWORD/ ; s/DOMAIN_PLACEHOLDER/$DOMAIN/ ; s/HOSTNAME_PLACEHOLDER/$HOSTNAME/' /srv/salt/mail/ssmtp.conf
```

In the lines below, replace $EMAIL with the mail address of the person to contact if there is some hardware defect on the machine.
```sh
sed -i 's/EMAIL_PLACEHOLDER/$EMAIL/' /srv/salt/monitoring/smartd.conf
```
Edit the file /srv/salt/monitoring/smartd.conf to make sure all fixed storage devices (not the removable devices) of the machine are listed in it. Use ```ls /dev/sd* /dev/hd*``` to list all the storage devices of the machine.

```sh
apt update
salt-call --local state.highstate
apt upgrade
reboot now
```

## Update the computer and the configuration as root on Debian or Ubuntu

```sh
cd /srv/salt
git pull --rebase --autostash
apt update
salt-call --local state.highstate
apt upgrade
reboot now
```
