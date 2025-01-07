# Use the official PHP image
FROM php:8.2-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev \
    libzip-dev \
    unzip \
    curl \
    libxml2-dev \
    libonig-dev \
    && docker-php-ext-install \
    pdo_pgsql \
    zip \
    bcmath \
    mbstring \
    xml

# Set the working directory
WORKDIR /var/www

# Copy application files
COPY . .

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Laravel dependencies
RUN composer install --no-dev --optimize-autoloader

# Ensure storage and cache directories are writable
RUN chmod -R 775 /var/www/storage /var/www/bootstrap/cache

# Expose port for the application
EXPOSE 8000

# Command to run the application
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
