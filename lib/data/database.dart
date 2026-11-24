import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

// Definición de la tabla de tareas
@DataClassName('TareaDB')
class Tareas extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get titulo => text()();

  BoolColumn get completada => boolean().withDefault(const Constant(false))();
}

// Base de datos de la aplicación
@DriftDatabase(tables: [Tareas])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
    : super(
        driftDatabase(
          name: 'gestor_tareas',
          web: DriftWebOptions(
            sqlite3Wasm: Uri.parse('sqlite3.wasm'),
            driftWorker: Uri.parse('drift_worker.js'),
          ),
        ),
      );

  // Constructor para pruebas automatizadas
  AppDatabase.prueba(super.executor);

  @override
  int get schemaVersion => 1;

  // Agregar una nueva tarea
  Future<int> agregarTarea(String titulo) async {
    return await into(tareas).insert(TareasCompanion.insert(titulo: titulo));
  }

  // Consultar todas las tareas
  Future<List<TareaDB>> obtenerTareas() async {
    return await select(tareas).get();
  }

  // Actualizar el título de una tarea
  Future<int> editarTarea(int id, String titulo) async {
    return await (update(tareas)..where((tarea) => tarea.id.equals(id))).write(
      TareasCompanion(titulo: Value(titulo)),
    );
  }

  // Cambiar el estado de una tarea
  Future<int> actualizarEstado(int id, bool completada) async {
    return await (update(tareas)..where((tarea) => tarea.id.equals(id))).write(
      TareasCompanion(completada: Value(completada)),
    );
  }

  // Eliminar una tarea por su identificador
  Future<int> eliminarTarea(int id) async {
    return await (delete(tareas)..where((tarea) => tarea.id.equals(id))).go();
  }
}
