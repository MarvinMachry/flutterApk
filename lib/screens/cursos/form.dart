import 'package:flutter/material.dart';
import 'package:projeto1/components/editor.dart';
import 'package:projeto1/database/cursos_dao.dart';
import 'package:projeto1/models/curso.dart';

class FormCurso extends StatefulWidget {
  final Curso curso;

  FormCurso({this.curso});

  @override
  State<StatefulWidget> createState() {
    return FormCursoState();
  }
}

class FormCursoState extends State<FormCurso> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controladorCampoNome =
  TextEditingController();
  final TextEditingController _controladorCampoDescricao =
  TextEditingController();
  int _id = null;
  double _value = 60;
  String dropdownValue = 'One';

  @override
  void initState() {
    super.initState();
    if (widget.curso != null) {
      _id = widget.curso.id;
      _controladorCampoNome.text = widget.curso.nome;
      _controladorCampoDescricao.text = widget.curso.descricao;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Formulário de Cursos'),
        ),
        body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Editor(_controladorCampoNome, 'Curso', 'Informe o nome do curso',
                      Icons.assessment_sharp, true),
                  Editor(_controladorCampoDescricao, 'Descricao',
                      'Informe a descricao', Icons.notes, true),
                  /*Padding(
                      padding: const EdgeInsets.all(20),
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        elevation: 24,
                        onChanged: (String newValue) {
                          setState(() => dropdownValue = newValue);
                        },
                        items: <String>['One', 'Two', 'Three', 'Four']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: Slider(
                        value: _value,
                        min: 0,
                        max: 100,
                        divisions: 5,
                        label: _value.round().toString(),
                        activeColor: Theme.of(context).primaryColor,
                        onChanged: (double value) {
                          setState(() => _value = value);
                        },
                      )),*/

                  RaisedButton(
                      padding: const EdgeInsets.all(16),
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        'Confirmar',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          setState(() => _saveCurso(context));
                        }
                      }),
                  SizedBox(height: 16),

                  RaisedButton(
                      padding: const EdgeInsets.all(16),
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        'Excluir',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () {
                        showAlertDialog(context);
                      }),
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: Image.network(
                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg')),
                ],
              ),
            )));
  }

  void _saveCurso(context) {
    CursosDao _dao = new CursosDao();
    if (_id != null) {
      final cursoAlterada = Curso(_id, _controladorCampoNome.text,
          _controladorCampoDescricao.text);
      _dao.update(cursoAlterada).then((id) => Navigator.pop(context));
    } else {
      final cursoCriada = Curso(
          0, _controladorCampoNome.text, _controladorCampoDescricao.text);
      _dao.save(cursoCriada).then((id) => Navigator.pop(context));
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continuar"),
      onPressed: () {
        Navigator.pop(context);
        setState(() => _excluir(context));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Exclusão de Cursos"),
      content: Text("Você deseja excluir este curso?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _excluir(BuildContext context) {
    CursosDao _dao = new CursosDao();
    _dao.delete(_id).then((id) => Navigator.pop(context));
  }
}