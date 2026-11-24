# Gestor de tareas SQLite multiplataforma

## Datos generales

- **Universidad:** Universidad Autónoma de Aguascalientes.
- **Carrera:** Ingeniería en Sistemas Computacionales.
- **Materia:** Programación de Dispositivos Móviles.
- **Alumna:** Frida Sofía Martínez Gallegos.
- **Grupo:** ISC 7A.

## Descripción

El proyecto consiste en desarrollar una aplicación Flutter para administrar tareas mediante una base de datos SQLite local, permitiendo conservar la información después de cerrar y volver a abrir la aplicación.

## Objetivo

Implementar un gestor de tareas con persistencia local que permita agregar, consultar, editar, eliminar y cambiar el estado de las tareas, sin depender de servidores externos.

## Tecnologías utilizadas

- Flutter.
- Dart.
- SQLite.
- Drift.
- drift_flutter.
- drift_dev.
- build_runner.

## Elección de la tecnología de persistencia

Se eligió SQLite porque permite almacenar información de manera local y persistente, sin necesidad de utilizar un servidor externo.

Se utilizará Drift para definir las tablas y realizar las operaciones CRUD de manera asíncrona. También se utilizará drift_flutter para facilitar la conexión con SQLite en las diferentes plataformas.

Esta combinación permite compartir una misma capa de persistencia entre Android, iOS, Windows, Linux, macOS y web.

## Diseño de la base de datos

La base de datos se llamará `gestor_tareas` y contará con una tabla denominada `tareas`.

| Campo | Tipo | Descripción |
|---|---|---|
| id | INTEGER | Identificador único autoincrementable. |
| titulo | TEXT | Título obligatorio de la tarea. |
| completada | INTEGER | Estado de la tarea: 0 pendiente y 1 completada. |

## Funcionalidades previstas

- Agregar tareas.
- Consultar tareas almacenadas.
- Editar el título de una tarea.
- Marcar tareas como completadas o pendientes.
- Eliminar tareas.
- Validar títulos vacíos.
- Conservar la información después de reiniciar la aplicación.

## Ejecución inicial

Para instalar las dependencias:

`flutter pub get`

Para analizar el código:

`flutter analyze`

Para ejecutar las pruebas:

`flutter test`

Para ejecutar la interfaz inicial en el navegador:

`flutter run -d chrome`

## Estado del proyecto

Actualmente se cuenta con la interfaz inicial, las dependencias de persistencia instaladas y el diseño de la base de datos. Las operaciones CRUD y la persistencia SQLite se implementarán en las siguientes etapas.

## Referencias

- https://drift.simonbinder.eu/
- https://drift.simonbinder.eu/platforms/web/
- https://pub.dev/packages/drift_flutter
- https://docs.flutter.dev/data-and-backend/persistence/sqlite

## Etapa 2. Implementación de persistencia con SQLite

Durante esta etapa se implementó la conexión de la aplicación Flutter con una base de datos local SQLite mediante Drift y drift_flutter.

### Funcionalidades implementadas

- Creación de la base de datos local.
- Definición de la tabla de tareas.
- Generación automática de código mediante build_runner.
- Registro de nuevas tareas.
- Consulta y visualización de las tareas almacenadas.
- Validación de títulos vacíos.
- Manejo de errores mediante mensajes en pantalla.
- Liberación de recursos y cierre de la conexión.
- Adaptación de la prueba inicial mediante una base de datos SQLite en memoria.

### Funcionamiento de la persistencia

Las tareas se almacenan directamente en SQLite. Al iniciar la aplicación, se consultan los registros existentes y se muestran en la interfaz gráfica, permitiendo conservar la información incluso después de cerrar completamente la aplicación.

### Pruebas realizadas

| Prueba | Resultado |
|---|---|
| Análisis estático con flutter analyze | Correcto |
| Prueba automatizada con flutter test | Correcto |
| Ejecución en Windows | Correcto |
| Registro de tres tareas | Correcto |
| Persistencia después de cerrar y abrir la aplicación | Correcto |
| Validación de títulos vacíos | Correcto |

### Dificultades encontradas

Durante la primera ejecución en Windows, Flutter indicó que no se encontraban las herramientas de compilación de Visual Studio. Para solucionar este problema, se instaló Visual Studio con la carga de trabajo Desarrollo para el escritorio con C++, incluyendo las herramientas MSVC, CMake y el SDK de Windows.

Después de realizar esta configuración, la aplicación se ejecutó correctamente.

### Funcionalidades pendientes

- Edición del título de una tarea.
- Actualización del estado de una tarea.
- Eliminación de tareas.
- Configuración de SQLite para el entorno web.
- Verificación del funcionamiento en dispositivos móviles.
- Implementación de pruebas automatizadas adicionales.