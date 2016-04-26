FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive


RUN apt-get update -qq && \
    apt-get upgrade -y && \
    apt-get install -y \
        poppler-utils \
        catdoc \
        php5-gd \
        php-pear \
        php5-mysql \
        apache2 \
        libapache2-mod-php5

RUN a2enmod rewrite php5

COPY installation-files/* /usr/src/seeddms/

RUN pear install /usr/src/seeddms/SeedDMS_Core-5.0.3.tgz

RUN pear install /usr/src/seeddms/SeedDMS_Lucene-1.1.8.tgz

RUN pear install /usr/src/seeddms/SeedDMS_Preview-1.1.8.tgz

RUN pear channel-discover zend.googlecode.com/svn
RUN pear install zend/zend

RUN pear install Log 

RUN pear install Mail

RUN pear install HTTP_WebDAV_Server-beta 

RUN tar -xzvf /usr/src/seeddms/seeddms-5.0.3.tar.gz -C /var/www/html

RUN touch /var/www/html/seeddms-5.0.3/conf/ENABLE_INSTALL_TOOL

RUN bash -c 'mkdir -p /var/www/seeddms-5.0.3/data/{staging,lucene,cache}'

RUN chown -R www-data /var/www/seeddms-5.0.3/data/ /var/www/html/seeddms-5.0.3/

COPY apache.conf.sample /etc/apache2/sites-available/seeddms.conf

RUN a2dissite 000-default
RUN a2ensite seeddms

WORKDIR /var/www/html/seeddms-5.0.3