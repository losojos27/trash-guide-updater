FROM ubuntu:bionic

RUN  apt-get update \
  && apt-get install -y wget unzip libgssapi-krb5-2 \
  && rm -rf /var/lib/apt/lists/* \
  && wget -O trash.zip https://github.com/rcdailey/trash-updater/releases/latest/download/trash-linux-x64.zip \
  && unzip -o trash.zip \
  && rm trash.zip \
  && chmod u+rx trash \
  && mv trash /usr/local/bin/