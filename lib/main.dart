import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:projeto1/screens/cursos/lista.dart';
import 'package:projeto1/screens/tarefas/lista.dart';

void main() {
  runApp(MyApp());
  /*save(Tarefa(0, 'teste1', 'teste obs')).then((id){
    findAll().then((tarefas) => debugPrint(tarefas.toString()));
  });*/
}

class MyApp extends StatelessWidget {
  const MyApp({key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.grey[600],
          accentColor: Colors.yellowAccent,
        ),
        home: MyStatefulWidget());
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[ListaTarefa(), ListaCurso()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Tarefas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Cursos',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}