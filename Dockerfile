FROM ubuntu:16.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    apache2 libapache2-mod-php7.0 php7.0-pgsql php7.0-sqlite3 php7.0-xml php7.0-mcrypt \
    php7.0-opcache php7.0-mcrypt php7.0-mbstring php7.0-json php7.0-curl cron && \
    apt-get clean

RUN echo \
    "ServerName localhost\n" \
    "<Directory /var/www/html/data/>\n" \
    "    Deny from all\n" \
    "</Directory>\n" \
    "<Directory /var/www/html/data/favicons/>\n" \
    "    Allow from all\n" \
    "</Directory>\n" >> /etc/apache2/apache2.conf

RUN echo \
    "# Update all feeds every 3 hours\n" \
    "0 */3 * * *  cd /var/www/html && php cronjob.php >/dev/null 2>&1" \
    >> /var/spool/cron/crontabs/root

COPY . /var/www/html

VOLUME /var/www/html/data

RUN rm -rf /var/www/html/index.html /var/www/html/data/* && \
    mkdir /var/www/html/data/favicons && \
    chown -R www-data:www-data /var/www/html/data

EXPOSE 80

CMD /usr/sbin/apache2ctl -D FOREGROUND
