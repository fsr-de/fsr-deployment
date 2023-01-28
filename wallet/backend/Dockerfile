FROM php:7.4-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    nginx \
    supervisor

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

#COPY config/fpm-pool.conf /etc/php74/php-fpm.d/www.conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY backend /app
WORKDIR /app
COPY .env .

RUN composer install
RUN php artisan key:generate
RUN php artisan jwt:secret
RUN chmod 777 storage -R

COPY entrypoint.sh .
ENTRYPOINT ["/app/entrypoint.sh"]