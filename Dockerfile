FROM ubuntu:14.04
MAINTAINER David Amom <davidamom@gmail.com>

RUN apt-get update && apt-get install -y \
    # Apache 2.4.7
    apache2 \
    # PHP 5.5.9
        php5 \
        php5-common \
        php5-cli \
        #libapache2-mod-php \
        php5-xdebug \
        phpunit \
        php5-mcrypt \
        php5-pgsql \
        php5-mysql \
        #php5-ldap \
        php5-sybase \
        php5-apcu \
        php5-json \
        php5-gd \
        php5-imagick \
        php5-curl \
        php5-ldap \
        php-soap \
    #dialog apt-utils \
    nano \
    && apt-get clean && apt-get autoclean && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

ENV APACHE_RUN_USER  www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR   /var/log/apache2
ENV APACHE_LOCK_DIR  /var/lock
ENV APACHE_PID_FILE  /var/run/apache2.pid

VOLUME /var/www

COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY run /usr/local/bin/run
RUN chmod +x /var/www
RUN chmod +x /usr/local/bin/run
RUN a2enmod rewrite

EXPOSE 80

CMD ["/usr/local/bin/run"]