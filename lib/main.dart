import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:projeto1/database/app.database.dart';
import 'package:projeto1/models/tarefa.dart';
import 'package:projeto1/screens/lista.dart';

void main() {
  runApp(MyApp());
  save(Tarefa(0, 'teste1', 'teste obs')).then((id){
    findAll().then((tarefas) => debugPrint(tarefas.toString()));
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.grey[600],
          accentColor: Colors.yellowAccent,
        ),
        home: ListaTarefa());
  }
}