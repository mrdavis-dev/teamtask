# TeamTask - Docker Setup Instructions

## Instrucciones de Instalación con Docker

### 1. Prerrequisitos
- Docker Desktop instalado
- Docker Compose v2 o superior
- Git

### 2. Clonar el Repositorio
```bash
git clone <repository-url>
cd teamtask
```

### 3. Configurar Variables de Entorno
```bash
cp .env.docker .env
```

### 4. Construir y Ejecutar los Contenedores
```bash
# Construcción inicial
docker-compose up --build -d

# Verificar que los servicios estén ejecutándose
docker-compose ps
```

### 5. Configurar la Aplicación Laravel
```bash
# Generar clave de aplicación
docker-compose exec app php artisan key:generate

# Ejecutar migraciones
docker-compose exec app php artisan migrate

# Limpiar caches
docker-compose exec app php artisan config:clear
docker-compose exec app php artisan cache:clear
```

### 6. Verificar la Instalación
- **Aplicación**: http://localhost:8000
- **SQL Server**: localhost:1433 (usuario: sa, contraseña: YourStrong@Passw0rd)

### Comandos Útiles

#### Gestión de Contenedores
```bash
# Ver logs
docker-compose logs -f

# Reiniciar servicios
docker-compose restart

# Detener servicios
docker-compose down

# Eliminar volúmenes (CUIDADO: elimina datos)
docker-compose down -v
```

#### Comandos Laravel
```bash
# Artisan commands
docker-compose exec app php artisan migrate
docker-compose exec app php artisan tinker
docker-compose exec app php artisan queue:work

# Composer
docker-compose exec app composer install
docker-compose exec app composer update

# NPM (si es necesario)
docker-compose exec app npm install
docker-compose exec app npm run build
```

#### Base de Datos SQL Server
```bash
# Conectar a SQL Server
docker-compose exec sqlserver /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P YourStrong@Passw0rd -C

# Backup de base de datos
docker-compose exec sqlserver /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P YourStrong@Passw0rd -C -Q "BACKUP DATABASE teamtask_db TO DISK = '/var/opt/mssql/backup/teamtask_backup.bak'"
```

### Troubleshooting

#### Problemas Comunes

1. **Error de permisos en storage/**
```bash
docker-compose exec app chmod -R 755 /var/www/html/storage
docker-compose exec app chown -R www-data:www-data /var/www/html/storage
```

2. **SQL Server no inicia**
```bash
# Verificar logs
docker-compose logs sqlserver

# Recrear contenedor
docker-compose stop sqlserver
docker-compose rm sqlserver
docker-compose up -d sqlserver
```

3. **Error de conexión a base de datos**
```bash
# Verificar que SQL Server esté listo
docker-compose exec sqlserver /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P YourStrong@Passw0rd -C -Q "SELECT @@VERSION"

# Verificar configuración en .env
cat .env | grep DB_
```

4. **Assets no se cargan**
```bash
# Reconstruir assets
docker-compose exec app npm run build

# Verificar permisos de public/
docker-compose exec app chmod -R 755 /var/www/html/public
```

### Configuración de Desarrollo

Para desarrollo, puedes montar el código como volumen para hot-reload:

```yaml
# En docker-compose.yml, bajo el servicio app:
volumes:
  - .:/var/www/html
  - /var/www/html/vendor
  - /var/www/html/node_modules
```

### Configuración de Producción

Para producción, modifica las siguientes variables en `.env`:

```env
APP_ENV=production
APP_DEBUG=false
APP_URL=https://tu-dominio.com

# Configurar cache
CACHE_STORE=redis
SESSION_DRIVER=redis
QUEUE_CONNECTION=redis

# Configurar SSL para SQL Server
DB_ENCRYPT=yes
DB_TRUST_SERVER_CERTIFICATE=false
```

### Monitoreo

#### Ver recursos del sistema
```bash
# Uso de CPU y memoria
docker stats

# Logs en tiempo real
docker-compose logs -f app
docker-compose logs -f sqlserver
```

#### Health checks
```bash
# Verificar servicios
docker-compose exec app php artisan route:list
docker-compose exec app php artisan config:show database

# Test de conexión a base de datos
docker-compose exec app php artisan tinker -c "DB::connection()->getPdo();"
```

### Respaldo y Restauración

#### Backup completo
```bash
# Crear directorio de backup
mkdir -p ./backups

# Backup de base de datos
docker-compose exec sqlserver /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P YourStrong@Passw0rd -C -Q "BACKUP DATABASE teamtask_db TO DISK = '/var/opt/mssql/backup/teamtask_$(date +%Y%m%d_%H%M%S).bak'"

# Backup de archivos uploaded (si los hay)
docker cp teamtask-app:/var/www/html/storage/app ./backups/storage_$(date +%Y%m%d_%H%M%S)
```

#### Restauración
```bash
# Restaurar base de datos
docker-compose exec sqlserver /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P YourStrong@Passw0rd -C -Q "RESTORE DATABASE teamtask_db FROM DISK = '/var/opt/mssql/backup/teamtask_backup.bak' WITH REPLACE"

# Restaurar archivos
docker cp ./backups/storage_backup teamtask-app:/var/www/html/storage/app
```

---

Para más información, consulta el README.md principal del proyecto.