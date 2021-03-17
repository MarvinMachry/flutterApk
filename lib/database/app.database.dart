import 'package:projeto1/database/cursos_dao.dart';
import 'package:projeto1/database/tarefas_dao.dart';
import 'package:projeto1/models/curso.dart';
import 'package:projeto1/models/tarefa.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'dbtarefas.db');
  return openDatabase(
      path,
      onCreate: (db, version) {
        db.execute(TarefasDao.tableSQL);
        db.execute(CursosDao.tableSQL);
      },
      onDowngrade: onDatabaseDowngradeDelete,
      version: 1
  );
}



