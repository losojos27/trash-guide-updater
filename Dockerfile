FROM ubuntu:bionic

COPY docker/start.sh /
COPY docker/buildConfig.sh /

RUN  apt-get update \
  && apt-get install -y wget unzip libgssapi-krb5-2 \
  && rm -rf /var/lib/apt/lists/* \
  && wget -O trash.zip https://github.com/rcdailey/trash-updater/releases/latest/download/trash-linux-x64.zip \
  && unzip -o trash.zip \
  && rm trash.zip \
  && chmod u+rx trash \
  && mv trash /usr/local/bin/ \
  && chmod +x /start.sh /buildConfig.sh

COPY docker/myapp.nginx.conf /etc/nginx/conf.d/default.conf

ENV MYAPP_OPTION_A="Default option A value"
ENV MYAPP_OPTION_B="Default option B value"
ENV MYAPP_OPTION_C="Default option C value"

CMD ["/start.sh"]