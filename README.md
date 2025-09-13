# TeamTask

Aplicación de gestión de tareas con Laravel, Vue.js 3, SQL Server y Docker.

## 🚀 Instalación y Ejecución

### Requisitos
- Docker Desktop (Windows/Mac) o Docker + Docker Compose (Linux)

### Pasos

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/mrdavis-dev/teamtask.git
   cd teamtask
   ```

2. **Ejecutar con Docker**
   ```bash
   docker-compose up --build -d
   ```

3. **Acceder a la aplicación**
   - Abrir navegador en: http://localhost:8000

¡Listo! La aplicación estará funcionando con base de datos SQL Server incluida.

## �️ Comandos útiles

```bash
# Ver logs
docker-compose logs app

# Parar la aplicación
docker-compose down

# Reiniciar después de cambios
docker-compose up --build -d
```

## 🎨 Características

- ✅ Sistema de autenticación (login/registro)
- ✅ UI moderna con gradientes
- ✅ Base de datos SQL Server
- ✅ Totalmente dockerizado
