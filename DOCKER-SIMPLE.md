# 🐳 TeamTask - Docker Setup Rápido

## Instrucciones de Uso

### 1. Preparar el entorno
```bash
# Copiar configuración de Docker
cp .env.docker.simple .env

# Construir y ejecutar
docker-compose up --build -d
```

### 2. Verificar que funciona
- **Aplicación**: http://localhost:8000
- **Base de datos**: localhost:1433 (sa / YourStrong@Passw0rd)

### 3. Comandos útiles
```bash
# Ver logs
docker-compose logs -f

# Parar servicios
docker-compose down

# Reiniciar
docker-compose restart

# Limpiar todo (CUIDADO: borra la base de datos)
docker-compose down -v
```

### 4. Acceso a base de datos
```bash
# Conectar a SQL Server
docker exec -it teamtask_sqlserver /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P YourStrong@Passw0rd -C

# Ver tablas
1> USE teamtask_db;
2> SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES;
3> GO
```

### 5. Comandos Laravel dentro del contenedor
```bash
# Entrar al contenedor
docker exec -it teamtask_app bash

# Ejecutar migraciones
php artisan migrate

# Crear usuario de prueba
php artisan tinker
>>> User::factory()->create(['email' => 'test@test.com'])
```

## Solución de Problemas

### Error: "sqlserver is not ready"
```bash
# Verificar que SQL Server esté corriendo
docker-compose ps

# Ver logs de SQL Server
docker-compose logs sqlserver
```

### Error: "Permission denied storage"
```bash
# Arreglar permisos
sudo chmod -R 755 storage/
sudo chown -R $USER:$USER storage/
```

### Reconstruir desde cero
```bash
# Parar y limpiar todo
docker-compose down -v --remove-orphans

# Limpiar imágenes
docker system prune -f

# Construir de nuevo
docker-compose up --build -d
```

¡Eso es todo! Con estos comandos tendrás TeamTask funcionando con SQL Server en minutos. 🚀