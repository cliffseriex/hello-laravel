
# Use the official PHP-FPM image
FROM php:8.2-fpm

# Install system dependencies for Postgres and extensions
RUN apt-get update && apt-get install -y \
    libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql

# Set the working directory in the container
WORKDIR /var/www

# Copy the Laravel application files
COPY . .

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer update

# Expose port 8000
EXPOSE 8005

# Command to run the Laravel development server
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8005"]
