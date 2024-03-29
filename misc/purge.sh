#!/bin/bash

echo '
###############
# # WARNING # #
###############
# This will PURGE ANY DATA installed by fufix.
# Configuration files, databases, mailboxes and more!
# Use with caution!
###############
'
read -p "Type \"confirm\" to continue: " confirminput
[[ $confirminput == "confirm" ]] || exit 0

service fail2ban stop
service rsyslog stop
service nginx stop
service php5-fpm stop
service clamav-daemon stop
service clamav-freshclam stop
service spamassassin stop
service fuglu stop
service mysql stop
service dovecot stop
service postfix stop
update-rc.d -f fail2ban remove
update-rc.d -f fuglu remove
# dovecot purge fails at first, that is okay
apt-get -y purge php5 git dnsutils python-sqlalchemy python-beautifulsoup python-setuptools \
python-magic openssl php-auth-sasl php-http-request php-mail php-mail-mime php-mail-mimedecode php-net-dime php-net-smtp \
php-net-socket php-net-url php-pear php-soap php5 php5-cli php5-common php5-curl php5-fpm php5-gd php5-imap subversion \
php5-intl php5-mcrypt php5-mysql php5-sqlite mysql-client mysql-server nginx dovecot-common dovecot-core mailutils \
dovecot-imapd dovecot-lmtpd dovecot-managesieved dovecot-sieve dovecot-mysql dovecot-pop3d postfix \
postfix-mysql postfix-pcre clamav clamav-base clamav-daemon clamav-freshclam spamassassin
# running autoremove two times to purge dovecot
apt-get -y autoremove --purge
apt-get -y autoremove --purge
killall -u vmail
userdel vmail
killall -u fuglu
userdel fuglu
rm -rf /etc/ssl/mail/
rm -rf /etc/spamassassin/
rm -rf /etc/clamav/
rm -rf /etc/dovecot/
rm -rf /etc/postfix/
rm -rf /etc/fuglu/
rm -rf /etc/fail2ban/
rm -rf /etc/nginx/
rm -rf /etc/php5/
rm -rf /etc/mysql/
rm -rf /usr/share/nginx/
rm -rf /usr/local/lib/python2.7/dist-packages/fuglu/
rm -f /usr/local/bin/fuglu*
rm -f /usr/local/lib/python2.7/dist-packages/fuglu-0.6.2.egg-info
rm -rf /usr/local/lib/python2.7/dist-packages/fail2ban-*
rm -f /usr/local/bin/fail2ban*
rm -rf /var/lib/mysql/
rm -f /etc/init.d/fail2ban
rm -f /etc/init.d/fuglu
rm -rf /var/log/fuglu/
rm -f /var/run/fuglu.pid
rm -rf /var/run/fail2ban/
rm -f /var/log/fail2ban.log
cat /dev/null > /var/log/mail.warn
cat /dev/null > /var/log/mail.err
cat /dev/null > /var/log/mail.info
cat /dev/null > /var/log/mail.log
rm -rf /var/lib/fail2ban/
rm -rf /var/lib/dovecot/
rm -rf /var/vmail/
rm -f /var/log/mail*1
rm -f /var/log/mail*gz
rm -rf /var/log/nginx/
rm -rf /var/log/clamav/
rm -rf /var/log/mysql*
