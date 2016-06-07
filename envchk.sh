#!/bin/ash
sed -i "s/SAMPLEENV.*/SAMPLEENV = $(printenv SAMPLEENV) <br>/" /usr/share/nginx/html/index.html
sed -i "s/NEXTENV.*/NEXTENV = $(printenv NEXTENV) <br> /" /usr/share/nginx/html/index.html
