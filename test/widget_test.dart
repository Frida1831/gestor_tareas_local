import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';

import 'package:gestor_tareas_local/data/database.dart';
import 'package:gestor_tareas_local/screens/tareas_page.dart';

void main() {
  testWidgets('La pantalla inicial se muestra sin errores', (tester) async {
    final database = AppDatabase.prueba(NativeDatabase.memory());

    await tester.runAsync(() async {
      await database.obtenerTareas();
    });

    await tester.pumpWidget(MaterialApp(home: TareasPage(database: database)));

    expect(find.text('Gestor de tareas'), findsOneWidget);

    expect(find.text('Agregar tarea'), findsOneWidget);

    expect(find.byType(TextField), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());

    await tester.runAsync(() async {
      await database.close();
    });
  });
}
