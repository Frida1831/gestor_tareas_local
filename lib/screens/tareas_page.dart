import 'package:flutter/material.dart';

import '../data/database.dart';

class TareasPage extends StatefulWidget {
  final AppDatabase? database;

  const TareasPage({super.key, this.database});

  @override
  State<TareasPage> createState() => _TareasPageState();
}

class _TareasPageState extends State<TareasPage> {
  final TextEditingController _tituloController = TextEditingController();

  // Instancia de la base de datos
  late final AppDatabase _database;

  // Lista de tareas obtenidas desde SQLite
  List<TareaDB> _tareas = [];

  bool _cargando = true;
  bool _guardando = false;

  @override
  void initState() {
    super.initState();

    _database = widget.database ?? AppDatabase();

    _cargarTareas();
  }

  // Consultar las tareas almacenadas en SQLite
  Future<void> _cargarTareas() async {
    try {
      final tareas = await _database.obtenerTareas();

      if (!mounted) return;

      setState(() {
        _tareas = tareas;
      });
    } catch (e) {
      if (!mounted) return;
      _pendiente('Error al consultar las tareas: $e');
    } finally {
      if (mounted) {
        setState(() {
          _cargando = false;
        });
      }
    }
  }

  // Agregar una tarea a SQLite
  Future<void> _agregarTarea() async {
    final titulo = _tituloController.text.trim();

    if (titulo.isEmpty) {
      _pendiente('Escribe el título de la tarea');
      return;
    }

    setState(() {
      _guardando = true;
    });

    try {
      await _database.agregarTarea(titulo);

      if (!mounted) return;

      _tituloController.clear();

      await _cargarTareas();

      if (!mounted) return;

      _pendiente('Tarea agregada correctamente');
    } catch (e) {
      if (!mounted) return;
      _pendiente('Error al guardar la tarea: $e');
    } finally {
      if (mounted) {
        setState(() {
          _guardando = false;
        });
      }
    }
  }

  // Cambiar el estado de una tarea
  Future<void> _alternarCompletada(TareaDB tarea, bool completada) async {
    try {
      await _database.actualizarEstado(tarea.id, completada);

      if (!mounted) return;

      await _cargarTareas();

      if (!mounted) return;

      if (completada) {
        _pendiente('Tarea marcada como completada');
      } else {
        _pendiente('Tarea marcada como pendiente');
      }
    } catch (e) {
      if (!mounted) return;

      _pendiente('Error al actualizar el estado: $e');
    }
  }

  // Editar el título de una tarea
  Future<void> _editarTarea(TareaDB tarea) async {
    final controller = TextEditingController(text: tarea.titulo);

    final nuevoTitulo = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar tarea'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Título de la tarea',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, controller.text.trim());
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );

    // Esperar a que termine de cerrarse el diálogo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.dispose();
    });

    if (!mounted || nuevoTitulo == null) return;

    if (nuevoTitulo.isEmpty) {
      _pendiente('El título no puede estar vacío');
      return;
    }

    try {
      await _database.editarTarea(tarea.id, nuevoTitulo);

      if (!mounted) return;

      await _cargarTareas();

      if (!mounted) return;

      _pendiente('Tarea actualizada correctamente');
    } catch (e) {
      if (!mounted) return;

      _pendiente('Error al editar la tarea: $e');
    }
  }

  // Eliminar una tarea
  Future<void> _eliminarTarea(TareaDB tarea) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar tarea'),
          content: Text(
            '¿Estás seguro de eliminar la tarea "${tarea.titulo}"?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancelar'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );

    if (!mounted || confirmar != true) return;

    try {
      await _database.eliminarTarea(tarea.id);

      if (!mounted) return;

      await _cargarTareas();

      if (!mounted) return;

      _pendiente('Tarea eliminada correctamente');
    } catch (e) {
      if (!mounted) return;

      _pendiente('Error al eliminar la tarea: $e');
    }
  }

  // Mostrar mensajes al usuario
  void _pendiente(String mensaje) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(mensaje)));
  }

  @override
  void dispose() {
    _tituloController.dispose();

    if (widget.database == null) {
      _database.close();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestor de tareas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(
                labelText: 'Nueva tarea',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _guardando || _cargando ? null : _agregarTarea,
              icon: const Icon(Icons.add),
              label: const Text('Agregar tarea'),
            ),
            const SizedBox(height: 12),
            const Text('Mis tareas', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Expanded(
              child: _cargando
                  ? const Center(child: CircularProgressIndicator())
                  : _tareas.isEmpty
                  ? const Center(child: Text('Todavía no hay tareas guardadas'))
                  : ListView.builder(
                      itemCount: _tareas.length,
                      itemBuilder: (context, index) {
                        final tarea = _tareas[index];

                        return Card(
                          child: ListTile(
                            leading: Checkbox(
                              value: tarea.completada,
                              onChanged: (valor) {
                                if (valor != null) {
                                  _alternarCompletada(tarea, valor);
                                }
                              },
                            ),
                            title: Text(
                              tarea.titulo,
                              style: TextStyle(
                                decoration: tarea.completada
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: tarea.completada ? Colors.grey : null,
                              ),
                            ),
                            subtitle: Text(
                              'ID: ${tarea.id} - '
                              '${tarea.completada ? "Completada" : "Pendiente"}',
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  tooltip: 'Editar',
                                  icon: const Icon(Icons.edit),
                                  onPressed: () => _editarTarea(tarea),
                                ),
                                IconButton(
                                  tooltip: 'Eliminar',
                                  icon: const Icon(Icons.delete_outline),
                                  onPressed: () => _eliminarTarea(tarea),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
