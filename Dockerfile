FROM wordpress

RUN apt-get update
RUN apt-get install -y \
    sudo \
    less \
    nano

COPY wp-cli.phar wp-cli.phar
COPY wp-super-cache-cli-master.zip /tmp/wp-super-cache-cli-master.zip

RUN php wp-cli.phar --info
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN wp --info

# RUN wp --allow-root package install https://github.com/wp-cli/wp-super-cache-cli.git
RUN wp --allow-root package install /tmp/wp-super-cache-cli-master.zip

RUN chown www-data:www-data /var/www -R

USER www-data

#ENTRYPOINT wp core download && \
#    wp config create --dbname="$WORDPRESS_DB_NAME" --dbuser="$WORDPRESS_DB_USER" --dbpass="$WORDPRESS_DB_PASSWORD" --dbhost="$WORDPRESS_DB_HOST" && \
#    wp core install && \
#    wp plugin install --activate wp-super-cache && \
#    wp plugin install --activate jwt-authentication-for-wp-rest-api && \
#    wp plugin install --activate updraftplus && \
#    wp plugin install --activate duplicator && \
#    wp plugin install --activate wordfence && \
#    docker-entrypoint.sh
