# Use the official PHP-FPM image
FROM php:8.2-fpm

# Install system dependencies and PHP extensions for Laravel
RUN apt-get update && apt-get install -y \
    libpq-dev \
    unzip \
    zip \
    curl \
    libonig-dev \
    libxml2-dev \
    && docker-php-ext-install \
    pdo \
    pdo_pgsql \
    mbstring \
    xml \
    bcmath

# Set the working directory in the container
WORKDIR /var/www

# Copy the Laravel application files
COPY . .

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Laravel dependencies
RUN composer install --no-dev --optimize-autoloader

# Expose port 8005
EXPOSE 8005

# Ensure storage and cache directories are writable
RUN chmod -R 775 /var/www/storage /var/www/bootstrap/cache

# Command to run the Laravel development server
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8005"]

