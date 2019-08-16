FROM ubuntu:18.04
LABEL maintainer="Victor Mongi"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y gnupg tzdata vim\
    && dpkg-reconfigure -f noninteractive tzdata

RUN apt-get install -y software-properties-common \
 && apt-add-repository ppa:ondrej/php
RUN apt-get update

RUN apt-get install -y \
    build-essential \
    curl \
    libaio1 \
    tdsodbc \
    unixodbc \
    unzip \
    php7.0 \
    php7.0-bcmath \
    php7.0-bz2 \
    php7.0-cgi \
    php7.0-cli \
    php7.0-common \
    php7.0-curl \
    php7.0-dba \
    php7.0-dev \
    php7.0-enchant \
    php7.0-gd \
    php7.0-gmp \
    php7.0-imap \
    php7.0-interbase \
    php7.0-intl \
    php7.0-json \
    php7.0-ldap \
    php7.0-mbstring \
    php7.0-mcrypt \
    php7.0-mysql \
    php7.0-odbc \
    php7.0-opcache \
    php7.0-pgsql \
    php7.0-phpdbg \
    php7.0-pspell \
    php7.0-readline \
    php7.0-recode \
    php7.0-soap \
    php7.0-sqlite3 \
    php7.0-sybase \
    php7.0-tidy \
    php7.0-xml \
    php7.0-xmlrpc \
    php7.0-xsl \
    php7.0-zip \
    php-memcached \
    php-memcache \
    php-apcu \
    libpcre3-dev \
    libxml2-dev \
    vim \
    apt-transport-https

RUN apt-get -y install nginx supervisor php7.0-fpm

RUN apt-get update \
    && mkdir /run/php \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && echo "daemon off;" >> /etc/nginx/nginx.conf
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["supervisord"]

COPY ./default /etc/nginx/sites-available/default
