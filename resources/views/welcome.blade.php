<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome - TeamTask</title>
    @vite(['resources/js/app.js'])
</head>
<body>
    <div class="welcome-container">
        <h1 class="welcome-title">TeamTask</h1>
        <p class="welcome-subtitle">Gestiona tus tareas de manera eficiente y colaborativa</p>
        <div class="welcome-actions">
            <a href="{{ route('login') }}" class="btn btn-primary">Iniciar Sesión</a>
            <a href="{{ route('register') }}" class="btn btn-secondary">Registrarse</a>
        </div>
    </div>
</body>
</html>