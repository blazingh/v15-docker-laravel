# Composer dependencies
FROM composer AS composer-build

WORKDIR /var/www/html

# files needed for composer install
COPY composer.json composer.lock /var/www/html/


# composer install with out auto loader nor platform reqs
RUN mkdir -p /var/www/html/database/{factories,seeds} \
    && composer install --no-dev --prefer-dist --no-scripts --no-autoloader --no-progress --ignore-platform-reqs

# NPM dependencies
FROM node:16 AS npm-build

WORKDIR /var/www/html

# files needed for npm install and npm build
COPY package.json package-lock.json vite.config.js /var/www/html/
COPY resources /var/www/html/resources/
COPY public /var/www/html/public/

RUN npm ci
RUN npm run build


# php for production
FROM php:8.1-fpm

WORKDIR /var/www/html

RUN apt-get update \
    && apt-get install --quiet --yes --no-install-recommends \
    libzip-dev \
    unzip \
    && docker-php-ext-install opcache zip pdo pdo_mysql 
# readd these line if redis is needed
# && pecl install -o -f redis-5.1.1 \
# && docker-php-ext-enable redis

# Use the default production configuration (from php docker image)
RUN mv $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini
COPY .docker/php/opcache.ini SPHP_INI_DIR/conf.d/

COPY --from=composer /usr/bin/composer /usr/bin/composer

# copying npm and composer dependencies and project folders
COPY --chown=www-data --from=composer-build /var/www/html/vendor/ /var/www/html/vendor/
COPY --chown=www-data --from=npm-build /var/www/html/public/ /var/www/html/public/
COPY --chown=www-data . /var/www/html

#running composer with autoloader and platform reqs
RUN composer dump -o \
    && composer check-platform-reqs \
    && rm -f /usr/bin/composer