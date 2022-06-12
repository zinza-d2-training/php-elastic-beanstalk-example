FROM php:8.1.7-fpm-alpine

# Copy composer.lock and composer.json
COPY composer.lock composer.json /var/www/

# Set working directory
WORKDIR /var/www

# Install dependencies
RUN apk update && apk add \
    libzip-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libwebp-dev \
    freetype-dev \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl

# Install extensions
RUN docker-php-ext-install pdo_mysql zip exif pcntl
RUN docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/
RUN docker-php-ext-install gd

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy existing application directory contents
COPY . /var/www

# Add user for laravel application
ARG DOCKER_GID
ARG DOCKER_UID
RUN if [ ${DOCKER_GID:-0} -ne 0 ] && [ ${DOCKER_UID:-0} -ne 0 ]; then \
    addgroup -g ${DOCKER_GID} www &&\
    adduser -u ${DOCKER_UID} -G www www --disabled-password &&\
    install -d -m 0755 -o www -g www /home/www \
;fi

## Change current user to www
#USER www

RUN composer install --no-scripts

CMD ["php-fpm"]
