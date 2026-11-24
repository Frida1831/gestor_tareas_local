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

Se utiliza Drift para definir las tablas y realizar las operaciones CRUD de manera asíncrona. También se utiliza drift_flutter para facilitar la conexión con SQLite en las diferentes plataformas.

Esta combinación permite compartir una misma capa de persistencia y un mismo código fuente entre los tres entornos establecidos para el proyecto:

- **Escritorio:** Windows.
- **Móvil:** Android.
- **Web:** Google Chrome.

## Diseño de la base de datos

La base de datos se denomina `gestor_tareas` y cuenta con una tabla llamada `tareas`.

| Campo | Tipo | Descripción |
|---|---|---|
| id | INTEGER | Identificador único autoincrementable y clave primaria. |
| titulo | TEXT | Título obligatorio de la tarea. |
| completada | INTEGER | Estado de la tarea: 0 pendiente y 1 completada. Su valor predeterminado es 0. |

Drift permite trabajar con el campo completada mediante valores booleanos (true y false), mientras que SQLite almacena estos valores como números enteros.

## Funcionalidades de la aplicación

- Agregar tareas.
- Consultar tareas almacenadas.
- Editar el título de una tarea.
- Marcar tareas como completadas o pendientes.
- Eliminar tareas mediante su identificador.
- Solicitar confirmación antes de eliminar una tarea.
- Validar títulos vacíos.
- Conservar la información después de reiniciar la aplicación.
- Mostrar mensajes de confirmación y error.
- Diferenciar visualmente las tareas completadas de las pendientes.

## Instalación y ejecución

### Instalar las dependencias

```bash
flutter pub get
```

### Generar el código de Drift

```bash
dart run build_runner build
```

### Analizar el código

```bash
flutter analyze
```

### Ejecutar las pruebas automatizadas

```bash
flutter test
```

### Ejecutar la aplicación en Windows

```bash
flutter run -d windows
```

Para ejecutar la aplicación en Windows es necesario contar con Visual Studio y la carga de trabajo Desarrollo para el escritorio con C++, incluyendo las herramientas MSVC, CMake y el SDK de Windows.

### Ejecutar la aplicación en el entorno web

Los archivos `sqlite3.wasm` y `drift_worker.js` deben estar en la carpeta `web`.

```bash
flutter run -d web-server --web-hostname=localhost --web-port=8080
```

Abrir Google Chrome e ingresar a http://localhost:8080.

Para conservar los datos entre ejecuciones se debe utilizar el mismo navegador, perfil, dirección y puerto.

### Ejecutar la aplicación en Android

Es necesario contar con el SDK de Android y un dispositivo físico o emulador. En un dispositivo físico, activar las opciones de desarrollador y la depuración USB.

Consultar los dispositivos disponibles:

```bash
flutter devices
```

Ejecutar la aplicación:

```bash
flutter run -d ID_DEL_DISPOSITIVO
```

Reemplazar `ID_DEL_DISPOSITIVO` por el identificador correspondiente al dispositivo Android.

## Estado del proyecto

Actualmente, la aplicación cuenta con una base de datos SQLite funcional, las operaciones CRUD completas, validación de datos, manejo de errores y seis pruebas automatizadas aprobadas.

Se ha comprobado el funcionamiento y la persistencia de los datos en Windows, Android y Google Chrome.

| Etapa | Descripción | Estado |
|---|---|---|
| 1 | Preparación del proyecto y diseño de la base de datos | Completada |
| 2 | Implementación de persistencia con SQLite | Completada |
| 3 | Implementación del CRUD y pruebas automatizadas | Completada |
| 4 | Funcionamiento multiplataforma | Completada |
| 5 | Documentación y entrega final | En desarrollo |

### Estado por plataforma

| Entorno | Plataforma | Estado |
|---|---|---|
| Escritorio | Windows | Verificado |
| Móvil | Android 15 | Verificado |
| Web | Google Chrome | Verificado |

## Etapa 1. Preparación del proyecto y diseño de la base de datos

Durante esta etapa se realizó la preparación del entorno de desarrollo, la configuración inicial del proyecto Flutter y el diseño de la base de datos que se utilizaría para almacenar las tareas.

### Actividades realizadas

- Creación del proyecto Flutter.
- Incorporación de la interfaz inicial proporcionada para la práctica.
- Instalación de las dependencias Drift y drift_flutter.
- Instalación de las dependencias de desarrollo drift_dev y build_runner.
- Diseño de la tabla de tareas.
- Definición de los campos y tipos de datos.
- Análisis inicial del código.
- Ejecución de la prueba automatizada inicial.
- Creación del repositorio Git.
- Publicación del proyecto en GitHub.
- Elaboración de la documentación inicial.

### Pruebas realizadas

| Prueba | Resultado |
|---|---|
| Instalación de dependencias | Correcto |
| Análisis estático con flutter analyze | Correcto |
| Prueba automatizada inicial con flutter test | Correcto |
| Publicación del proyecto en GitHub | Correcto |

### Funcionalidades pendientes al finalizar la etapa

- Creación de la base de datos SQLite.
- Implementación de la persistencia local.
- Implementación de las operaciones CRUD.
- Configuración y verificación de los diferentes entornos.

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

Las operaciones de almacenamiento y consulta se realizan de manera asíncrona, evitando ejecutar consultas directamente dentro del método build de la interfaz.

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

Durante la primera ejecución en Windows, Flutter indicó que no se encontraban las herramientas de compilación de Visual Studio.

Para solucionar este problema, se instaló Visual Studio Community con la carga de trabajo Desarrollo para el escritorio con C++, incluyendo las herramientas MSVC, CMake y el SDK de Windows.

Después de realizar esta configuración, la aplicación se ejecutó correctamente.

### Funcionalidades pendientes al finalizar la etapa

- Edición del título de una tarea.
- Actualización del estado de una tarea.
- Eliminación de tareas.
- Configuración de SQLite para el entorno web.
- Verificación del funcionamiento en dispositivos móviles.
- Implementación de pruebas automatizadas adicionales.

## Etapa 3. Implementación del CRUD completo

Durante esta etapa se implementaron las operaciones restantes para la administración de tareas mediante SQLite y Drift, completando las funcionalidades CRUD de la aplicación.

### Funcionalidades implementadas

- Edición del título de una tarea mediante una ventana de diálogo.
- Validación de títulos vacíos durante la edición.
- Actualización del estado de las tareas mediante un Checkbox.
- Identificación visual de las tareas completadas mediante texto tachado y color gris.
- Visualización del identificador y estado de cada tarea.
- Eliminación de tareas mediante su identificador.
- Ventana de confirmación antes de eliminar una tarea.
- Manejo de errores mediante bloques try-catch.
- Actualización de la interfaz después de realizar operaciones en SQLite.

### Operaciones de la base de datos

| Método | Operación SQL | Descripción |
|---|---|---|
| agregarTarea() | INSERT | Registra una nueva tarea. |
| obtenerTareas() | SELECT | Consulta las tareas almacenadas. |
| editarTarea() | UPDATE | Modifica el título de una tarea. |
| actualizarEstado() | UPDATE | Cambia el estado de una tarea. |
| eliminarTarea() | DELETE | Elimina una tarea mediante su ID. |

### Validación y manejo de errores

Se implementaron validaciones para impedir el registro y la edición de tareas con títulos vacíos o compuestos únicamente por espacios.

Las operaciones de la base de datos se invocan desde la interfaz mediante bloques try-catch para controlar posibles errores durante el registro, consulta, edición, actualización y eliminación de tareas.

Los mensajes de confirmación y error se muestran mediante SnackBar, proporcionando información al usuario sobre el resultado de las operaciones.

También se incorporó una ventana de confirmación antes de eliminar una tarea, con el propósito de evitar eliminaciones accidentales.

### Pruebas manuales en Windows

| Prueba | Resultado |
|---|---|
| Registro de tareas | Correcto |
| Consulta de tareas | Correcto |
| Edición del título | Correcto |
| Persistencia del título modificado | Correcto |
| Marcar una tarea como completada | Correcto |
| Desmarcar una tarea completada | Correcto |
| Persistencia del estado | Correcto |
| Confirmación de eliminación | Correcto |
| Cancelación de eliminación | Correcto |
| Persistencia después de eliminar | Correcto |
| Validación de títulos vacíos | Correcto |

### Pruebas automatizadas

Se creó el archivo `test/database_test.dart`, utilizando una base de datos SQLite en memoria para comprobar las operaciones de manera independiente, sin afectar los registros reales de la aplicación.

Antes de ejecutar cada prueba se crea una nueva base de datos temporal y, al finalizar, se cierra la conexión correspondiente.

También se conserva la prueba inicial de la interfaz gráfica ubicada en el archivo `test/widget_test.dart`.

| Prueba | Resultado |
|---|---|
| Visualización de la interfaz inicial | Aprobada |
| Registro de una tarea | Aprobada |
| Consulta de todas las tareas | Aprobada |
| Edición del título | Aprobada |
| Cambio de estado | Aprobada |
| Eliminación de una tarea específica | Aprobada |

### Resultados generales

- `flutter analyze`: sin errores ni advertencias.
- `flutter test`: 6 pruebas aprobadas.
- Operaciones CRUD: funcionamiento correcto.
- Persistencia de datos en Windows: verificada.

Las pruebas automatizadas comprueban el funcionamiento de las operaciones CRUD utilizando una base de datos en memoria, mientras que las pruebas manuales permiten verificar la persistencia real de la información después de cerrar y volver a abrir la aplicación.

### Funcionalidades pendientes al finalizar la etapa

- Configuración de SQLite mediante WebAssembly para navegadores.
- Verificación del funcionamiento y persistencia en el entorno web.
- Verificación del funcionamiento y persistencia en dispositivos móviles Android.
- Elaboración de la documentación final del proyecto.

## Etapa 4. Funcionamiento multiplataforma

Durante esta etapa se configuró y verificó el funcionamiento de la aplicación en los entornos de escritorio, web y móvil, utilizando el mismo código fuente desarrollado con Flutter, SQLite y Drift.

### Versiones de las dependencias

| Dependencia | Versión |
|---|---|
| drift | 2.35.4 |
| drift_dev | 2.35.3 |
| drift_flutter | 0.3.1 |
| sqlite3 | 3.5.2 |

### Configuración del entorno web

Para permitir el funcionamiento de SQLite en Google Chrome se incorporaron los archivos sqlite3.wasm y drift_worker.js dentro de la carpeta web del proyecto.

También se actualizó la configuración de la conexión en el archivo lib/data/database.dart mediante DriftWebOptions.

Se utilizó un servidor web local con el puerto fijo 8080 para mantener el mismo origen durante las pruebas de persistencia.

### Pruebas realizadas en Google Chrome

| Prueba | Resultado |
|---|---|
| Ejecución de la aplicación | Correcto |
| Registro y consulta de tareas | Correcto |
| Edición de tareas | Correcto |
| Actualización del estado | Correcto |
| Eliminación de tareas | Correcto |
| Validación de títulos vacíos | Correcto |
| Persistencia después de recargar la página | Correcto |
| Persistencia después de cerrar y abrir el navegador | Correcto |
| Persistencia después de reiniciar el servidor local | Correcto |

### Configuración del entorno móvil

Para verificar el funcionamiento en dispositivos móviles se utilizó un teléfono físico con las siguientes características:

- Modelo: NIC LX3.
- Sistema operativo: Android 15.
- Nivel de API: 35.
- Arquitectura: ARM64.

Se activaron las opciones de desarrollador y la depuración USB del dispositivo.

Posteriormente, se conectó el teléfono a la computadora mediante un cable USB y se verificó su reconocimiento mediante el comando flutter devices.

La aplicación se compiló e instaló directamente en el dispositivo mediante Flutter, sin necesidad de utilizar un emulador.

### Pruebas realizadas en Android

| Prueba | Resultado |
|---|---|
| Detección del dispositivo físico | Correcto |
| Compilación e instalación | Correcto |
| Registro y consulta de tareas | Correcto |
| Edición de tareas | Correcto |
| Actualización del estado | Correcto |
| Eliminación de tareas | Correcto |
| Validación de títulos vacíos | Correcto |
| Persistencia después de cerrar y abrir la aplicación | Correcto |
| Funcionamiento sin conexión USB a la computadora | Correcto |

### Comparación de la persistencia entre plataformas

| Plataforma | Almacenamiento | Persistencia |
|---|---|---|
| Windows | Base de datos SQLite local | Verificada |
| Android | Base de datos SQLite en el almacenamiento de la aplicación | Verificada |
| Web | SQLite mediante WebAssembly y almacenamiento del navegador | Verificada |

Cada plataforma administra sus propios datos de manera independiente. Las tareas registradas en un entorno no se sincronizan automáticamente con los demás, debido a que la aplicación utiliza almacenamiento local y no depende de un servidor externo.

### Consideraciones del almacenamiento web

La persistencia en el navegador depende del origen de la aplicación y del perfil utilizado.

Cambiar el puerto, utilizar otro navegador, eliminar los datos del sitio o utilizar una sesión de navegación privada puede impedir el acceso a los registros previamente almacenados.

### Resultados de la etapa

Se comprobó que la aplicación permite realizar las operaciones CRUD y conservar la información después de cerrar y volver a abrir la aplicación en los tres entornos establecidos.

Se reutilizó el mismo código fuente para las diferentes plataformas, sin necesidad de desarrollar aplicaciones independientes.

### Actividades pendientes al finalizar la etapa

- Elaboración del reporte final en PDF.
- Documentación de la investigación realizada.
- Selección de evidencias.
- Revisión final del repositorio.
- Entrega del proyecto.

## Referencias

- Documentación oficial de Drift: https://drift.simonbinder.eu/
- Documentación de Drift para web: https://drift.simonbinder.eu/platforms/web/
- Paquete drift_flutter: https://pub.dev/packages/drift_flutter
- Documentación de persistencia SQLite en Flutter: https://docs.flutter.dev/data-and-backend/persistence/sqlite
