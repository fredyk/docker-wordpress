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

RUN echo "pwd: $(pwd)"
# RUN wp --allow-root package install https://github.com/wp-cli/wp-super-cache-cli.git
RUN wp --allow-root package install /tmp/wp-super-cache-cli-master.zip
RUN wp --allow-root plugin install --activate wp-super-cache
RUN wp --allow-root plugin install --activate jwt-authentication-for-wp-rest-api
RUN wp --allow-root plugin install --activate updraftplus
