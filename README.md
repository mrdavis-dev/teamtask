# TeamTask - Task Management Application

TeamTask es una aplicación moderna de gestión de tareas desarrollada con Laravel 11, Vue.js 3 e Inertia.js, con soporte completo para contenedores Docker y base de datos SQL Server.

## 🚀 Características

- **Frontend Moderno**: Vue.js 3 con Composition API e Inertia.js para una experiencia SPA
- **Backend Robusto**: Laravel 11 con todas las características modernas
- **Base de Datos**: SQL Server con soporte completo
- **Autenticación**: Sistema completo de login/registro con diseño moderno
- **Diseño Responsivo**: UI moderna con gradientes y transiciones suaves
- **Containerización**: Docker y Docker Compose para desarrollo y producción
- **Cache y Colas**: Redis para cache y procesamiento de trabajos en segundo plano

## 🎨 Diseño

La aplicación cuenta con un diseño moderno inspirado en las mejores prácticas de UX/UI:

- **Gradientes dinámicos**: Colores azul-púrpura para login y rosa-rojo para registro
- **Transiciones suaves**: Animaciones entre estados y hover effects
- **Wallpapers animados**: Fondos con gradientes y efectos visuales
- **Glassmorphism**: Efectos de cristal translúcido en las tarjetas
- **Responsive Design**: Optimizado para desktop y móvil

## 📋 Requisitos

### Desarrollo Local
- PHP 8.2+
- Node.js 18+
- Composer
- SQL Server o SQL Server Express
- Redis (opcional)

### Desarrollo con Docker
- Docker
- Docker Compose

## 🛠️ Instalación

### Opción 1: Desarrollo Local

1. **Clonar el repositorio**
   ```bash
   git clone <repository-url>
   cd teamtask
   ```

2. **Instalar dependencias de PHP**
   ```bash
   composer install
   ```

3. **Instalar dependencias de Node.js**
   ```bash
   npm install
   ```

4. **Configurar variables de entorno**
   ```bash
   cp .env.example .env
   php artisan key:generate
   ```

5. **Configurar base de datos en .env**
   ```env
   DB_CONNECTION=sqlsrv
   DB_HOST=localhost
   DB_PORT=1433
   DB_DATABASE=teamtask_db
   DB_USERNAME=sa
   DB_PASSWORD=your_password
   DB_ENCRYPT=yes
   DB_TRUST_SERVER_CERTIFICATE=true
   ```

6. **Ejecutar migraciones**
   ```bash
   php artisan migrate
   ```

7. **Compilar assets**
   ```bash
   npm run build
   ```

8. **Iniciar servidor de desarrollo**
   ```bash
   php artisan serve
   ```

### Opción 2: Docker (Recomendado)

1. **Clonar el repositorio**
   ```bash
   git clone <repository-url>
   cd teamtask
   ```

2. **Configurar variables de entorno para Docker**
   ```bash
   cp .env.docker .env
   ```

3. **Construir y ejecutar con Docker Compose**
   ```bash
   docker-compose up --build -d
   ```

4. **Ejecutar migraciones**
   ```bash
   docker-compose exec app php artisan migrate
   ```

5. **Generar clave de aplicación**
   ```bash
   docker-compose exec app php artisan key:generate
   ```

La aplicación estará disponible en:
- **Aplicación**: http://localhost:8000
- **SQL Server**: localhost:1433
- **Redis**: localhost:6379

## 🐳 Configuración Docker

### Servicios Incluidos

- **app**: Aplicación Laravel con PHP 8.2 + Apache
- **sqlserver**: SQL Server 2022 Express
- **redis**: Redis 7 para cache y colas
- **nginx**: Servidor web para producción (opcional)

### Volúmenes

- `sqlserver_data`: Datos persistentes de SQL Server
- `redis_data`: Datos persistentes de Redis

### Variables de Entorno Docker

```env
# Base de datos
DB_CONNECTION=sqlsrv
DB_HOST=sqlserver
DB_PORT=1433
DB_DATABASE=teamtask_db
DB_USERNAME=sa
DB_PASSWORD=YourStrong@Passw0rd

# Cache y Sesiones
CACHE_STORE=redis
SESSION_DRIVER=redis
QUEUE_CONNECTION=redis
REDIS_HOST=redis
```

## 🔧 Comandos Útiles

### Docker
```bash
# Iniciar servicios
docker-compose up -d

# Ver logs
docker-compose logs -f

# Ejecutar comandos en el contenedor
docker-compose exec app php artisan migrate
docker-compose exec app php artisan tinker

# Detener servicios
docker-compose down

# Reconstruir imagen
docker-compose up --build
```

### Laravel
```bash
# Migraciones
php artisan migrate
php artisan migrate:rollback

# Cache
php artisan cache:clear
php artisan config:clear
php artisan route:clear

# Colas
php artisan queue:work
php artisan queue:restart

# Testing
php artisan test
```

### Frontend
```bash
# Desarrollo
npm run dev

# Producción
npm run build

# Watch mode
npm run dev -- --watch
```

## 🏗️ Estructura del Proyecto

```
teamtask/
├── app/                          # Código Laravel
│   ├── Http/Controllers/         # Controladores
│   ├── Models/                   # Modelos Eloquent
│   └── Providers/               # Service Providers
├── resources/
│   ├── js/                      # Código Vue.js
│   │   ├── Components/          # Componentes Vue
│   │   ├── Layouts/             # Layouts (Guest, Authenticated)
│   │   └── Pages/               # Páginas Inertia.js
│   ├── css/                     # Estilos CSS
│   └── views/                   # Plantillas Blade
├── docker/                      # Configuraciones Docker
│   ├── apache/                  # Configuración Apache
│   ├── nginx/                   # Configuración Nginx
│   ├── supervisor/              # Configuración Supervisor
│   └── sqlserver/               # Scripts SQL Server
├── database/
│   ├── migrations/              # Migraciones de base de datos
│   └── seeders/                 # Seeders
├── routes/                      # Rutas de la aplicación
└── tests/                       # Tests automatizados
```

## 🎯 Funcionalidades

### Autenticación
- [x] Registro de usuarios con validación
- [x] Login con remember me
- [x] Logout
- [x] Recuperación de contraseña
- [x] Validación de formularios en tiempo real

### Gestión de Tareas (Próximamente)
- [ ] Crear, editar y eliminar tareas
- [ ] Categorización de tareas
- [ ] Estados: pendiente, en progreso, completado
- [ ] Fechas de vencimiento
- [ ] Prioridades
- [ ] Asignación de tareas
- [ ] Comentarios y notas

### UI/UX
- [x] Diseño responsivo
- [x] Tema oscuro/claro
- [x] Transiciones suaves
- [x] Feedback visual
- [x] Loading states
- [x] Manejo de errores

## 🔒 Seguridad

- Autenticación basada en sesiones
- Protección CSRF
- Validación de entrada
- Sanitización de datos
- Headers de seguridad
- Encriptación de datos sensibles

## 🧪 Testing

```bash
# Ejecutar todos los tests
php artisan test

# Tests con coverage
php artisan test --coverage

# Tests específicos
php artisan test --filter=AuthenticationTest
```

## 📊 Monitoreo y Logs

### Logs de Aplicación
```bash
# Ver logs en tiempo real
tail -f storage/logs/laravel.log

# Logs en Docker
docker-compose logs -f app
```

### Supervisión de Colas
```bash
# Estado de workers
php artisan queue:monitor

# Estadísticas
php artisan queue:stats
```

## 🚀 Despliegue en Producción

### Variables de Entorno de Producción
```env
APP_ENV=production
APP_DEBUG=false
DB_CONNECTION=sqlsrv
CACHE_STORE=redis
SESSION_DRIVER=redis
QUEUE_CONNECTION=redis
```

### Optimizaciones
```bash
# Cache de configuración
php artisan config:cache

# Cache de rutas
php artisan route:cache

# Cache de vistas
php artisan view:cache

# Optimización de autoloader
composer install --optimize-autoloader --no-dev
```

## 🤝 Contribución

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📝 Licencia

Este proyecto está bajo la licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 🆘 Soporte

Si encuentras algún problema o tienes preguntas:

1. Revisa la documentación
2. Busca en los issues existentes
3. Crea un nuevo issue con detalles del problema
4. Incluye logs y capturas de pantalla si es posible

## 🔄 Changelog

### v1.0.0 - 2024-01-XX
- ✨ Autenticación completa con diseño moderno
- 🐳 Configuración Docker con SQL Server
- 🎨 UI responsiva con gradientes y transiciones
- 📱 Soporte móvil completo
- 🔧 Configuración de desarrollo y producción

---

**TeamTask** - Gestión de tareas moderna y eficiente 🚀
