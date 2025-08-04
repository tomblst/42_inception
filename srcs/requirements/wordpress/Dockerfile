FROM debian:bullseye

# wget = outil pour télécharger des fichiers depuis le internet
RUN apt-get update && apt-get upgrade -y
RUN apt-get -y install wget

RUN apt-get install -y php7.4 php7.4-fpm php7.4-mysql mariadb-client

RUN wget https://fr.wordpress.org/wordpress-6.8-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.8-fr_FR.tar.gz && rm wordpress-6.8-fr_FR.tar.gz

# Copie notre configurtion de PHP
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Set permissions
RUN chown -R www-data:www-data /var/www/wordpress

# Install WP-CLI, outil de ligne de commande pour WordPress sans l'interface graphique
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# Copy script d'initialisation
COPY conf/auto_config.sh /auto_config.sh
RUN chmod +x /auto_config.sh

EXPOSE 9000

ENTRYPOINT ["bash", "/auto_config.sh"]