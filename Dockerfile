FROM php:7.4-apache

# Copy CMS code into the container
COPY . /var/www/html/

# Install any necessary dependencies
RUN apt-get update && apt-get install -y mysql-client

# Expose the necessary ports
EXPOSE 80

# Start the Apache web server
CMD ["apache2-foreground"]
