FROM wordpress:latest AS builder

# Remove the default wp-content directory
RUN rm -rf /var/www/html/wp-content

# Stage 2: Final image
FROM wordpress:latest

# Set non-interactive environment variable
ENV DEBIAN_FRONTEND=noninteractive

# Expose the necessary ports
EXPOSE 80

# Copy the built wp-content from the builder stage
COPY --from=builder . /var/www/html/wp-content

# Set environment variables for MySQL database credentials
ENV WORDPRESS_DB_HOST=rds-mysql.ckbmchm8dgx6.us-west-1.rds.amazonaws.com
ENV WORDPRESS_DB_NAME=dbname
ENV WORDPRESS_DB_USER=masterUsername
ENV WORDPRESS_DB_PASSWORD=admin123

# Optionally, you can set other WordPress environment variables
# For example, to configure the WordPress site URL
#ENV WORDPRESS_HOME=http://your-site-url.com
#ENV WORDPRESS_SITEURL=http://your-site-url.com

# Start Apache web server along with WordPress entrypoint
CMD ["apache2-foreground"]

# Stage 3: Add EFS mount
# Replace the EFS filesystem ID and mount point with your actual values
RUN apt-get update && \
    apt-get install -y nfs-common && \
    rm -rf /var/lib/apt/lists/*

#RUN echo "YOUR_EFS_FILESYSTEM_ID:/ /var/www/html/wp-content nfs defaults,_netdev 0 0" >> /etc/fstab