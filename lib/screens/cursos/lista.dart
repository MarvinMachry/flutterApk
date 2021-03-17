import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projeto1/database/cursos_dao.dart';
import 'file:///E:/Users/AndroidStudioProjects/projeto1/lib/screens/cursos/form.dart';
import 'package:projeto1/models/curso.dart';

class ListaCurso extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ListaCursoState();
  }
}

class ListaCursoState extends State<ListaCurso> {
  CursosDao _dao = new CursosDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cursos'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future future =
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormCurso();
          }));
          future.then((curso) {
            setState(() => {});
          });
        },
      ),
      body: FutureBuilder<List<Curso>>(
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
                final List<Curso> cursos = snapshot.data;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final Curso curso = cursos[index];
                    return itemCurso(context, curso);
                  },
                  itemCount: cursos.length,
                );
              }
              break;
          } //switch
          return Text('erro desconhecido.');
        }, //builder
      ),
    );
  }

  Widget itemCurso(BuildContext context, Curso curso) {
    return InkWell(
        child: Container(
            padding: EdgeInsets.all(1.0),
            child: Card(
                child: ListTile(
                    leading: Icon(Icons.edit),
                    title: Text(curso.nome),
                    subtitle: Text(curso.descricao),
                    enabled: true,
                    onTap: () {
                      Timer(Duration(milliseconds: 100), () {
                        final Future future = Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return FormCurso(curso: curso);
                            }));
                        future.then((curso) {
                          setState(() => {});
                        });
                      });
                    })
            )
        )
    );
  }
}
