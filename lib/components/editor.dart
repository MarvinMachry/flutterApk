import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData icone;
  final bool valido;

  Editor(this.controlador, this.rotulo, this.dica, this.icone, this.valido);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextFormField(
        controller: controlador,
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
            icon: icone != null ? Icon(icone) : null,
            labelText: rotulo,
            hintText: dica),
        validator: (value){
          if (value.isEmpty && this.valido) {
            return 'Insira um texto!';
          }
          return null;
        }
      ),
    );
  }
}