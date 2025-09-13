# Use PHP with Apache
FROM php:8.2-apache

# Set working directory
WORKDIR /var/www/html

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    zip \
    unzip \
    nodejs \
    npm \
    gnupg2 \
    gpg \
    ca-certificates

# Install SQL Server ODBC Driver
RUN curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/microsoft-prod.gpg] https://packages.microsoft.com/debian/11/prod bullseye main" > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql18 mssql-tools18 unixodbc-dev

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd zip

# Install SQL Server PHP extensions
RUN pecl install sqlsrv pdo_sqlsrv \
    && docker-php-ext-enable sqlsrv pdo_sqlsrv

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Configure Apache DocumentRoot and AllowOverride
RUN sed -i 's|/var/www/html|/var/www/html/public|g' /etc/apache2/sites-available/000-default.conf
RUN sed -i 's|/var/www/|/var/www/html/public|g' /etc/apache2/apache2.conf
RUN sed -i '/<Directory \/var\/www\/html\/public>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

# Copy application files
COPY . /var/www/html/

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage \
    && chmod -R 755 /var/www/html/bootstrap/cache

# Install dependencies
RUN composer install --no-dev --optimize-autoloader
RUN npm ci && npm run build

# Create startup script inline
RUN echo '#!/bin/bash\n\
echo "Waiting for SQL Server to be ready..."\n\
until /opt/mssql-tools18/bin/sqlcmd -S ${DB_HOST:-sqlserver} -U ${DB_USERNAME:-sa} -P ${DB_PASSWORD:-YourStrong@Passw0rd} -C -Q "SELECT 1" > /dev/null 2>&1; do\n\
    echo "SQL Server is unavailable - sleeping"\n\
    sleep 1\n\
done\n\
echo "SQL Server is ready!"\n\
echo "Creating database if it does not exist..."\n\
/opt/mssql-tools18/bin/sqlcmd -S ${DB_HOST:-sqlserver} -U ${DB_USERNAME:-sa} -P ${DB_PASSWORD:-YourStrong@Passw0rd} -C -Q "\n\
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = '\''${DB_DATABASE:-teamtask_db}'\'')\n\
BEGIN\n\
    CREATE DATABASE ${DB_DATABASE:-teamtask_db};\n\
    PRINT '\''Database ${DB_DATABASE:-teamtask_db} created successfully'\'';\n\
END\n\
ELSE\n\
BEGIN\n\
    PRINT '\''Database ${DB_DATABASE:-teamtask_db} already exists'\'';\n\
END\n\
"\n\
echo "Running Laravel migrations..."\n\
php artisan migrate --force\n\
echo "Clearing caches..."\n\
php artisan config:clear\n\
php artisan cache:clear\n\
php artisan route:clear\n\
echo "Starting Apache..."\n\
exec apache2-foreground' > /usr/local/bin/start.sh

RUN chmod +x /usr/local/bin/start.sh

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["/usr/local/bin/start.sh"]