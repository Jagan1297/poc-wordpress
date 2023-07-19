FROM php:7.4-apache

# Copy CMS code into the container
COPY . /var/www/html/

# Install any necessary dependencies
RUN apt-get update && apt-get install -y mysql-client

#Environment
ENV
    WORDPRESS_DB_HOST: wordpress.ckbmchm8dgx6.us-west-1.rds.amazonaws.com
    WORDPRESS_DB_USER: admin
    WORDPRESS_DB_PASSWORD: Wordpress2023
    WORDPRESS_DB_NAME: wordpress

# Expose the necessary ports
EXPOSE 80

# Start the Apache web server
CMD ["apache2-foreground"]
