# Use an Apache image with PHP preinstalled
FROM php:7.4-apache

# Copy all project files into Apache's web root
COPY . /var/www/html/

# Enable Apache mod_rewrite if needed
RUN a2enmod rewrite

# Set correct permissions (optional, depending on needs)
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80

CMD ["apache2-foreground"]
