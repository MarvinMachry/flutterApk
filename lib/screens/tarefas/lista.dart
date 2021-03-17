import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projeto1/database/tarefas_dao.dart';
import 'file:///E:/Users/AndroidStudioProjects/projeto1/lib/screens/tarefas/form.dart';
import 'package:projeto1/models/tarefa.dart';

class ListaTarefa extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ListaTarefaState();
  }
}

class ListaTarefaState extends State<ListaTarefa> {
  TarefasDao _dao = new TarefasDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarefas'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future future =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormTarefa();
          }));
          future.then((tarefa) {
            setState(() => {});
          });
        },
      ),
      body: FutureBuilder<List<Tarefa>>(
        initialData: List(),
        future: Future.delayed(Duration(seconds: 1))
            .then((value) => _dao.findAll()),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text('Loading'),
                  ],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.data != null) {
                final List<Tarefa> tarefas = snapshot.data;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final Tarefa tarefa = tarefas[index];
                    return itemTarefa(context, tarefa);
                  },
                  itemCount: tarefas.length,
                );
              }
              break;
          } //switch
          return Text('erro desconhecido.');
        }, //builder
      ),
    );
  }

  Widget itemTarefa(BuildContext context, Tarefa tarefa) {
    return InkWell(
        child: Container(
            padding: EdgeInsets.all(1.0),
            child: Card(
                child: ListTile(
                    leading: Icon(Icons.edit),
                    title: Text(tarefa.descricao),
                    subtitle: Text(tarefa.obs),
                    enabled: true,
                    onTap: () {
                      Timer(Duration(milliseconds: 100), () {
                        final Future future = Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return FormTarefa(tarefa: tarefa);
                            }));
                        future.then((tarefa) {
                          setState(() => {});
                        });
                      });
                    })
            )
        )
    );
  }
}
