import 'package:projeto1/database/tarefas_dao.dart';
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
      },
      version: 1
  );
}

Future<int> save(Tarefa tarefa) async{
  final Database db = await getDatabase();
  final Map<String, dynamic> tarefaMap = Map();
  tarefaMap['descricao'] = tarefa.descricao;
  tarefaMap['obs'] = tarefa.obs;
  return db.insert('tarefas', tarefaMap);
}


Future<List<Tarefa>> findAll() async {
  final Database db = await getDatabase();
  final List<Map<String, dynamic>> result = await db.query('tarefas');
  final List<Tarefa> tarefas = List();
  for (Map<String, dynamic> row in result) {
    final Tarefa tarefa = Tarefa(
      row['id'],
      row['descricao'],
      row['obs'],
    );
    tarefas.add(tarefa);
  }
  return tarefas;
}



