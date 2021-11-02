#!/bin/bash -e
set -e

sed -i "s/SERVERNAME/$SERVERNAME/g" /etc/nginx/conf.d/default.conf
if [ -n "$PHP_CONTAINER_NAME" ]; then
  sed -i "s/PHPCONTAINERNAME/$PHP_CONTAINER_NAME/g" /etc/nginx/conf.d/default.conf
else
  sed -i "s/PHPCONTAINERNAME/php/g" /etc/nginx/conf.d/default.conf
fi
sed -i "s/DOCUMENTROOT/$DOCUMENTROOT/g" /etc/nginx/conf.d/default.conf
OWNER=$(stat -c '%u' /app)
GROUP=$(stat -c '%g' /app)
USERNAME=app
[ -e "/etc/debian_version" ] || USERNAME=app
if [ "$OWNER" != "0" ]; then
  usermod -o -u $OWNER $USERNAME
  groupmod -o -g $GROUP www-data
fi
