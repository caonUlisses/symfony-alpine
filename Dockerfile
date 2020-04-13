FROM php:7.4-fpm-alpine

LABEL mainteiner="ulissescaon@gmail.com"

RUN apk add --update --no-cache \
    icu \
    icu-dev \
    git \
    bash \
    wget \
    curl \
    yarn \
    autoconf g++ make && \
    pecl install -f xdebug && \
    docker-php-ext-enable xdebug

RUN docker-php-ext-install opcache intl
RUN docker-php-ext-install pdo pdo_mysql

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

RUN adduser --shell /bin/bash --disabled-password docker

USER docker
RUN wget https://get.symfony.com/cli/installer -O - | bash
RUN export PATH="$HOME/.symfony/bin:$PATH"

USER root
RUN mv /home/docker/.symfony/bin/symfony /usr/local/bin/symfony

RUN export XDEBUG_CONFIG="idekey=debug"

USER docker
EXPOSE 9000
