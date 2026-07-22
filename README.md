# Gestión de Proyectos y Tareas - UI Premium

Esta es una aplicación Ruby on Rails robusta y visualmente moderna para gestionar Clientes, Proyectos y Tareas. 
Cuenta con una interfaz intuitiva potenciada por **Bootstrap 5**, y un sistema de notificaciones y confirmaciones interactivas usando **SweetAlert2**.

## Características Principales y Lógica de Negocio

- **CRUD de Clientes y Proyectos**: Gestión completa desde la interfaz visual.
- **Gestión de Tareas Integrada**: Las tareas se crean, listan y marcan como completadas directamente dentro de la vista individual del proyecto.
- **Barra de Progreso Dinámica**: Cada proyecto muestra su porcentaje de avance gráficamente (tareas completadas / total) mediante una barra animada.
- **Validaciones Estrictas (Backend y Frontend)**:
  - Un **Cliente** no puede ser eliminado si posee proyectos en estado `active` (Activo).
  - Un **Proyecto** debe tener siempre un estado válido: `active`, `paused` o `completed`.
  - Los **Proyectos Pausados** (`paused`) deshabilitan visualmente los checkboxes de sus tareas y bloquean en el servidor cualquier intento de completarlas.
  - Los **Proyectos Completados** (`completed`) ocultan el formulario para agregar tareas y el backend rechaza cualquier intento de añadir nuevas tareas.
  - Las **Tareas Vencidas** (fecha límite pasada y no hechas) se resaltan en rojo, deshabilitan su checkbox y el backend rechaza cualquier intento de marcarlas como hechas.
- **Filtrado Visual**: Los proyectos pueden ser filtrados fácilmente por su estado en la vista principal mediante un selector.
- **Diseño Premium**: Interfaz moderna, responsiva, sombras suaves, alertas flotantes animadas y cuadros de diálogo amigables.

## Estructura del Proyecto

A continuación, se detalla la estructura principal de los archivos creados y modificados para este sistema:

```text
c:\hola\BLOG\
├── app/
│   ├── models/
│   │   ├── client.rb           # Validaciones de clientes (impide borrado con proyectos activos)
│   │   ├── project.rb          # Validaciones de estado y cálculo matemático del % de avance
│   │   └── task.rb             # Validaciones de fechas vencidas y restricciones por estado del proyecto
│   ├── controllers/
│   │   ├── clients_controller.rb
│   │   ├── projects_controller.rb # Lógica de filtrado por estado (?status=)
│   │   └── tasks_controller.rb    # Controlador dedicado al cambio de estado de tareas
│   ├── views/
│   │   ├── layouts/
│   │   │   └── application.html.erb # Inyección de Bootstrap, SweetAlert, Navbar y overrides globales
│   │   ├── clients/            # Vistas visuales (tablas modernas, tarjetas)
│   │   └── projects/           # Grid de tarjetas y layout a 2 columnas para el detalle de tareas
│   └── assets/
│       └── stylesheets/
│           └── application.css # CSS personalizado (animaciones, progresos, personalización visual)
├── test/
│   ├── models/                 # Tests unitarios estructurados
│   └── controllers/            # Tests funcionales asegurando redirecciones y reglas de borrado
└── db/
    └── migrate/                # Archivos para generar el esquema de base de datos relacional
```

## Instalación y Configuración

### Prerrequisitos
- Ruby 3.4.0 (o superior recomendado)
- SQLite3 (por defecto para desarrollo)
- Bundler (`gem install bundler`)

### Linux (Ubuntu/Debian)
1. Instalar dependencias del sistema:
   ```bash
   sudo apt update
   sudo apt install ruby-full sqlite3 libsqlite3-dev build-essential
   ```
2. Clonar el repositorio y entrar en la carpeta.
3. Instalar gemas:
   ```bash
   bundle install
   ```
4. Preparar la base de datos (crear tablas y ejecutar migraciones):
   ```bash
   rails db:create db:migrate
   ```
5. Levantar el servidor:
   ```bash
   rails server
   ```

### Windows
1. Descargar e instalar [RubyInstaller for Windows](https://rubyinstaller.org/). Asegúrate de marcar la opción para instalar la cadena de herramientas MSYS2 durante la instalación.
2. Abrir la terminal (PowerShell o Command Prompt) y verificar la instalación:
   ```bash
   ruby -v
   sqlite3 --version
   ```
3. Navegar a la carpeta del proyecto.
4. Instalar dependencias:
   ```bash
   bundle install
   ```
5. Preparar la base de datos:
   ```bash
   rails db:create db:migrate
   ```
6. Levantar el servidor:
   ```bash
   rails server
   ```

> [!TIP]
> **Solución a errores comunes en Windows:**
> Si al cargar la página ves un error rojo que dice `Errno::EACCES` relacionado con `tmp/cache`, se debe a que el antivirus (Windows Defender) está bloqueando la caché de Rails. 
> **Solución:** Detén el servidor, ejecuta `rails tmp:clear` en la consola, y vuelve a levantarlo. Para evitarlo definitivamente, agrega la carpeta `tmp/` del proyecto a las exclusiones de tu antivirus.

## Ejecución de Tests Automáticos

El sistema cuenta con un robusto conjunto de más de 20 tests entre modelos y controladores que garantizan que las reglas de negocio complejas no se rompan en el futuro.

**Paso 1:** Siempre asegúrate de preparar y sincronizar la base de datos de pruebas antes de ejecutarlos (especialmente si es la primera vez que clonas el proyecto):
```bash
rails db:test:prepare
```

**Paso 2:** Ejecuta todos los tests:
```bash
rails test
```

> [!WARNING]
> **Aviso para usuarios de Windows:**
> Si al correr `rails test` obtienes el mismo error `Errno::EACCES` (Permission denied) relacionado con `tmp/cache/assets/sprockets`, significa que tu antivirus bloqueó los archivos temporales generados durante el test.
> **Solución:** Ejecuta `rails tmp:clear` y vuelve a correr los tests.
