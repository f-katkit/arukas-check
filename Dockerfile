FROM alpine:3.3

ENV NGINX_VERSION=1.10.0 \
 SAMPLEENV=unabled  \
 NEXTENV=unabled

RUN apk --update add pcre-dev openssl-dev \
  && apk add --virtual build-dependencies build-base curl \
  && curl -SLO http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
  && tar xzvf nginx-${NGINX_VERSION}.tar.gz \
  && cd nginx-${NGINX_VERSION} \
  && ./configure \
      --with-http_ssl_module \
      --with-http_gzip_static_module \
      --prefix=/usr/share/nginx \
      --sbin-path=/usr/local/sbin/nginx \
      --conf-path=/etc/nginx/conf/nginx.conf \
      --pid-path=/var/run/nginx.pid \
      --http-log-path=/var/log/nginx/access.log \
      --error-log-path=/var/log/nginx/error.log \
  && make \
  && make install \
  && cd / \
  && apk del build-dependencies \
  && ln -sf /dev/stdout /var/log/nginx/access.log \
  && ln -sf /dev/stderr /var/log/nginx/error.log \
  && rm -rf \
  nginx-${NGINX_VERSION} \
  nginx-${NGINX_VERSION}.tar.gz \
           /var/cache/apk/* \
  && echo "<p> ENV TEST </p>" > /usr/share/nginx/html/index.html \
  && echo "SAMPLEENV = ${SAMPLEENV}  <br>" >> /usr/share/nginx/html/index.html \
  && echo "NEXTENV = ${NEXTENV}  <br>" >> /usr/share/nginx/html/index.html \
  && echo "<p>CMD check</p>" >> /usr/share/nginx/html/index.html \
  && echo '<p style="color:red;">CMD is not working!! </p>' >> /usr/share/nginx/html/index.html \
  && echo '#!/bin/ash' > /cmd.sh \
  && echo 'sed -i "s/red/green/g" /usr/share/nginx/html/index.html' >> /cmd.sh \
  && echo 'sed -i "s/not //g" /usr/share/nginx/html/index.html' >> /cmd.sh \
  && echo 'sed -i "s/!!/ =P/g" /usr/share/nginx/html/index.html' >> /cmd.sh \
  && echo '/cron.sh && crond start && nginx -g "daemon off;"' >> /cmd.sh \
  && chmod 755 /cmd.sh \
  && echo 'sed -i "s/SAMPLEENV.*/SAMPLEENV = $(printenv SAMPLEENV) <br>/" /usr/share/nginx/html/index.html' > /cron.sh \
  && echo 'sed -i "s/NEXTENV.*/NEXTENV = $(printenv NEXTENV) <br> /" /usr/share/nginx/html/index.html' >> /cron.sh \
  && chmod 755 /cron.sh \
  && echo '*/1     *       *       *       *       /cron.sh' >> /etc/crontabs/root


EXPOSE 80 443

CMD crond start && /cron.sh && nginx -g "daemon off;"
