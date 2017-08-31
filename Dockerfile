FROM ubuntu:14.04
# MAINTAINER David Amom <davidamom@gmail.com> (deprecated)
LABEL maintainer = "David Amom <davidamom@gmail.com>"

RUN apt-get update && apt-get install -y \
    # Apache 2.4.7
    apache2 \
    # PHP 5.5.9
        php5 \
        php5-common \
        php5-cli \
        # Optional System Utilities and Libraries
        #libapache2-mod-php \
        php5-xdebug \
        phpunit \
        # Optional Security/Encryption Utilities and Libraries
        php5-mcrypt \
        # Optional Data Management Utilities and Libraries
        php5-pgsql \
        php5-mysql \
        php5-sybase \
        php5-apcu \
        php5-json \
        #php5-ldap \
        # Optional Graphics Utilities and Libraries
        php5-gd \
        php5-imagick \
        # Optional Web Utilities
        php5-curl \
        php5-ldap \
        php-soap \
    # Optional
    #dialog apt-utils \
    nano \
    #curl \

    # Cleaning...
    && apt-get clean && apt-get autoclean && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*
# Setting environment vars
ENV APACHE_RUN_USER  = "www-data"
ENV APACHE_RUN_GROUP = "www-data"
ENV APACHE_LOG_DIR   = "/var/log/apache2"
ENV APACHE_LOCK_DIR  = "/var/lock"
ENV APACHE_PID_FILE  = "/var/run/apache2/apache2.pid"

VOLUME /var/www/html
#ADD . /var/www/html/

COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY run /usr/local/bin/run
RUN chmod +x /var/www
RUN chmod +x /usr/local/bin/run
RUN chown -R www-data:www-data /var/www/html
# Enables apache rewrite module
RUN a2enmod rewrite

#SSL
#RUN /usr/sbin/a2ensite default-ssl
#RUN /usr/sbin/a2enmod ssl
# https://httpd.apache.org/docs/2.4/mod/prefork.html
#RUN /usr/sbin/a2dismod 'mpm_*' && /usr/sbin/a2enmod mpm_prefork

LABEL Description=" Apache 2.4.7 Webserver - PHP 5.5.9"
EXPOSE 80
#SSL
#EXPOSE 443

CMD ["/usr/local/bin/run"]