#!/bin/ash

sed -i "s/red/green/g" /usr/share/nginx/html/index.html
sed -i "s/not //g" /usr/share/nginx/html/index.html
sed -i "s/!!/ =P/g" /usr/share/nginx/html/index.html
/envchk.sh && crond start && nginx -g "daemon off;"
