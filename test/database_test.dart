import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';

import 'package:gestor_tareas_local/data/database.dart';

void main() {
  late AppDatabase database;

  // Crear una base de datos antes de cada prueba
  setUp(() {
    database = AppDatabase.prueba(NativeDatabase.memory());
  });

  // Cerrar la base de datos después de cada prueba
  tearDown(() async {
    await database.close();
  });

  // Prueba 1: Agregar una tarea
  test('Agregar una tarea correctamente', () async {
    final id = await database.agregarTarea('Estudiar Flutter');

    final tareas = await database.obtenerTareas();

    expect(tareas.length, 1);
    expect(tareas.first.id, id);
    expect(tareas.first.titulo, 'Estudiar Flutter');
    expect(tareas.first.completada, false);
  });

  // Prueba 2: Consultar todas las tareas
  test('Consultar todas las tareas registradas', () async {
    await database.agregarTarea('Tarea 1');
    await database.agregarTarea('Tarea 2');
    await database.agregarTarea('Tarea 3');

    final tareas = await database.obtenerTareas();

    expect(tareas.length, 3);
    expect(
      tareas.map((tarea) => tarea.titulo),
      unorderedEquals(['Tarea 1', 'Tarea 2', 'Tarea 3']),
    );
  });

  // Prueba 3: Editar el título
  test('Editar el título de una tarea', () async {
    final id = await database.agregarTarea('Título original');

    final modificadas = await database.editarTarea(id, 'Título actualizado');

    final tareas = await database.obtenerTareas();

    expect(modificadas, 1);
    expect(tareas.length, 1);
    expect(tareas.first.id, id);
    expect(tareas.first.titulo, 'Título actualizado');
  });

  // Prueba 4: Cambiar el estado
  test('Marcar y desmarcar una tarea', () async {
    final id = await database.agregarTarea('Terminar práctica');

    await database.actualizarEstado(id, true);

    var tareas = await database.obtenerTareas();

    expect(tareas.first.completada, true);

    await database.actualizarEstado(id, false);

    tareas = await database.obtenerTareas();

    expect(tareas.first.completada, false);
  });

  // Prueba 5: Eliminar una tarea
  test('Eliminar únicamente la tarea seleccionada', () async {
    final id1 = await database.agregarTarea('Tarea 1');
    final id2 = await database.agregarTarea('Tarea 2');

    final eliminadas = await database.eliminarTarea(id1);

    final tareas = await database.obtenerTareas();

    expect(eliminadas, 1);
    expect(tareas.length, 1);
    expect(tareas.first.id, id2);
    expect(tareas.first.titulo, 'Tarea 2');
  });
}
