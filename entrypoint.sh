#!/bin/bash
sleep 1

cd /home/container

sed -i 's/localhost/'"${DB_HOST}"'/g' ./phpmyadmin/config.inc.php

SECRET=$(pwgen 32 1)
sed -i "s/cfg\['blowfish_secret'\] = '.*/cfg['blowfish_secret'] = '"${SECRET}"';/g" ./phpmyadmin/config.inc.php

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
${MODIFIED_STARTUP}