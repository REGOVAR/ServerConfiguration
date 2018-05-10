# Regovar server

## Deployment as root on Debian or Ubuntu

```sh
sed -i 's@^#\(precedence ::ffff:0:0/96  10\)@\1@' /etc/gai.conf # to prefer IPv4 to IPv6, necessary in some places
apt install salt-minion git
mkdir -p /srv
git clone https://github.com/REGOVAR/ServerConfiguration.git /srv/salt
```

### Network configuration

Check if `/srv/salt/network/interfaces` matches your network interfaces.

### Users configuration

Change `/srv/salt/users/init.sls` to specify the users you want on the computer. For more information, we invite you to visit the [SaltStack documentation](https://docs.saltstack.com/en/latest/ref/states/all/salt.states.user.html).

### Mail server configuration (optional but recommended)

In the lines below, replace `$HOSTNAME` with the name you want to give to your computer.

```sh
sed -i 's/HOSTNAME_PLACEHOLDER/$HOSTNAME/' /srv/salt/hostname
sed -i 's/HOSTNAME_PLACEHOLDER/$HOSTNAME/' /srv/salt/hosts
```

In the lines below, replace:
- `$SENDER_EMAIL` with the email address of the computer administrator,
- `$SMTP_HOSTNAME` with the hostname of the SMTP server (eg. `smtp.gmail.com` if your email is on Gmail),
- `$SMTP_PORT` with the port of the SMTP server (eg. `465` if your email is on Gmail),
- `$SMTP_PASSWORD` with the email password of the computer administrator,
- `$DOMAIN` with the email domain (eg. `gmail.com` if your email is on Gmail),
- `$HOSTNAME` with the name of your computer.
We recommend to use a email account dedicated to this computer and not your personal mail account. This email account will be used to send all the automatic emails from this computer.

```sh
sed -i 's/SENDER_EMAIL_PLACEHOLDER/$SENDER_EMAIL/' /srv/salt/mail/revaliases
sed -i 's/SENDER_EMAIL_PLACEHOLDER/$SENDER_EMAIL/ ; s/SMTP_HOSTNAME_PLACEHOLDER/$SMTP_HOSTNAME/ ; s/SMTP_PORT_PLACEHOLDER/$SMTP_PORT/ ; s/SMTP_PASSWORD_PLACEHOLDER/$PASSWORD/ ; s/DOMAIN_PLACEHOLDER/$DOMAIN/ ; s/HOSTNAME_PLACEHOLDER/$HOSTNAME/' /srv/salt/mail/ssmtp.conf
```

### Monitoring configuration (optional but recommended)

It requires a proper mail server configuration.

In the lines below, replace:
- `$RECIPIENT_EMAIL` with the mail address of the person to contact if there is some hardware defect on the computer or some software upgrade issue,
- `$SENDER_EMAIL` with the email address of the computer administrator.

```sh
sed -i 's/RECIPIENT_EMAIL_PLACEHOLDER/$RECIPIENT_EMAIL/' /srv/salt/monitoring/smartd.conf
sed -i 's/RECIPIENT_EMAIL_PLACEHOLDER/$RECIPIENT_EMAIL/' /srv/salt/security/cron-apt-config
sed -i 's/RECIPIENT_EMAIL_PLACEHOLDER/$RECIPIENT_EMAIL/ ; s/SENDER_EMAIL_PLACEHOLDER/$SENDER_EMAIL/' /srv/salt/security/fail2ban-jail.local
sed -i 's/RECIPIENT_EMAIL_PLACEHOLDER/$RECIPIENT_EMAIL/' /srv/salt/monitoring/logwatch-cron
```

Edit `/srv/salt/monitoring/smartd.conf` to make sure all fixed storage devices like /dev/sda (not the removable devices and not the partitions like /dev/sda*1*) of the computer are listed in it. Use `lsblk -p` to list all the storage devices of the computer.
Do the same in `/srv/salt/monitoring/init.sls`, for the line above smartctl.

### SSH configuration (optional)

In the line below, replace `$SSH_USERS` with a space-separated list of users allowed to connect to the computer using SSH.

```sh
sed -i 's/SSH_USERS_PLACEHOLDER/$SSH_USERS/' /srv/salt/network/sshd_config
```

For these users, add authorized keys in the `/srv/salt/users` directory.

### Apply the SaltStack Configuration

```sh
apt update
salt-call --local state.highstate
```

This step may take some time, mainly depending on your network speed.

```sh
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
