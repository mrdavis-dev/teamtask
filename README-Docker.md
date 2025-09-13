# TeamTask - Docker Setup

## 🚀 Instalación Rápida en Cualquier PC

Este proyecto está completamente dockerizado y listo para funcionar en cualquier máquina que tenga Docker instalado.

### Requisitos Previos
- Docker Desktop (Windows/Mac) o Docker Engine + Docker Compose (Linux)
- Puerto 8000 y 1433 disponibles

### Pasos de Instalación

1. **Clonar el repositorio**
   ```bash
   git clone <tu-repositorio>
   cd teamtask
   ```

2. **Construir y ejecutar los contenedores**
   ```bash
   docker-compose up --build -d
   ```

3. **Verificar que todo funcione**
   - Abrir navegador en: http://localhost:8000
   - Deberías ver la página de login con el diseño moderno

### ⚙️ Configuración Personalizada

Si necesitas cambiar configuraciones (puertos, contraseñas, etc.), edita el archivo `docker-compose.yml`:

```yaml
# Cambiar puerto de la aplicación
ports:
  - "8080:80"  # Cambiar 8000 por 8080

# Cambiar puerto de SQL Server  
ports:
  - "1444:1433"  # Cambiar 1433 por 1444

# Cambiar contraseña de SQL Server
environment:
  - DB_PASSWORD=TuNuevaContraseña123!
  - SA_PASSWORD=TuNuevaContraseña123!
```

### 🔧 Comandos Útiles

```bash
# Iniciar contenedores
docker-compose up -d

# Parar contenedores
docker-compose down

# Ver logs
docker-compose logs app
docker-compose logs sqlserver

# Reconstruir después de cambios
docker-compose up --build -d

# Acceder al contenedor de la aplicación
docker-compose exec app bash

# Ejecutar comandos de Laravel
docker-compose exec app php artisan migrate
docker-compose exec app php artisan tinker
```

### 🗄️ Base de Datos

- **Motor**: SQL Server 2022 Express
- **Host**: localhost:1433
- **Usuario**: sa
- **Contraseña**: YourStrong@Passw0rd
- **Base de datos**: teamtask_db

### 🎨 Características Incluidas

- ✅ Laravel 11 con Inertia.js
- ✅ Vue.js 3 con diseño moderno
- ✅ SQL Server con drivers nativos
- ✅ Sistema de autenticación completo
- ✅ UI con gradientes y wallpapers dinámicos
- ✅ Migraciones automáticas
- ✅ Assets compilados (CSS/JS)

### 🔍 Solución de Problemas

**Puerto ocupado:**
```bash
# Cambiar puerto en docker-compose.yml
ports:
  - "8001:80"  # O cualquier puerto libre
```

**Permisos en Linux:**
```bash
sudo chown -R $USER:$USER .
```

**Limpiar todo y empezar de nuevo:**
```bash
docker-compose down -v
docker system prune -f
docker-compose up --build -d
```

### 📁 Estructura del Proyecto

```
teamtask/
├── Dockerfile              # Imagen de la aplicación Laravel
├── docker-compose.yml      # Orquestación de contenedores
├── app/                    # Código Laravel
├── resources/js/           # Componentes Vue.js
├── database/migrations/    # Migraciones SQL Server
└── public/                # Assets públicos
```

### 🌐 Acceso

Una vez ejecutado `docker-compose up -d`:
- **Aplicación**: http://localhost:8000
- **Base de datos**: localhost:1433

¡La aplicación estará lista para usar con datos de prueba incluidos!