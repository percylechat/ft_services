#!/bin/sh
sleep 20
cd var/www/html && wp core install --url=172.17.0.2:5050 --title=mysite --admin_user=admin --admin_email=admin@admin.fr
wp user update admin admin@admin.fr --role=administrator --user_pass=admin && wp user create percy percy@admin.fr --role=editor --user_pass=percy && \
wp user create ivitch ivitch@admin.fr --role=editor --user_pass=ivitch
cd ../../../