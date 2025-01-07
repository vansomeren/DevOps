# Set up the base image with PHP and necessary extensions
FROM php:8.1-apache AS base

# Install system dependencies and PHP extensions needed by Laravel
RUN apt-get update && apt-get install -y \
        libpng-dev \
        libjpeg-dev \
        libwebp-dev \
        libxpm-dev \
        zlib1g-dev \
        libxml2-dev \
        oniguruma-dev \
        libzip-dev \
        git \
        curl \
        nano \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql zip opcache bcmath \
    && apt-get clean

# Install Composer - Dependency manager for laravel
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Enable Apache mod_rewrite - this is to enable laravel routing
RUN a2enmod rewrite

# Create the application directory and set permissions
WORKDIR /var/www

# Copy the Laravel application files into the container
COPY . .

# Copy custom Apache config
COPY apache/000-default.conf /etc/apache2/sites-available/001-laravel.conf


# Install Laravel dependencies using Composer
RUN composer install --no-interaction --prefer-dist

# Set file permissions for Laravel storage and cache
RUN chown -R www-data:www-data /var/www \
    && chmod -R 775 /var/www/storage /var/www/bootstrap/cache

# Generate application key
RUN php artisan key:generate

# Expose the port the app will run on
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
