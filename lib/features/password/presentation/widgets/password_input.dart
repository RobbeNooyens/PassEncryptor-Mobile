import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/password_bloc.dart';

class PasswordInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PasswordInputState();
  
}
class PasswordInputState extends State<PasswordInput> {
  String encryptionKey, application;
  bool _showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          obscureText: !this._showPassword,
          onChanged: (val) => {
            encryptionKey = val
          },
          decoration: InputDecoration(
            prefix: Text("Encryption Key: "
            ),
          suffixIcon: IconButton(
          icon: Icon(
            Icons.remove_red_eye,
            color: this._showPassword ? Colors.grey[200] : Colors.grey[100],
          ),
          onPressed: () {
            setState(() => this._showPassword = !this._showPassword);
          },
        ),),),
        TextField(
          onChanged: (val) => application = val,
          decoration: InputDecoration(prefix: Text("Application: "),)),
        RaisedButton(
          onPressed: () { 
            BlocProvider.of<PasswordBloc>(context)
        .add(EncryptPasswordEvent(application: application, encryptionKey: encryptionKey)); },
          child: Text("Generate"),),
        RaisedButton(
          onPressed: () {
            BlocProvider.of<PasswordBloc>(context)
        .add(EncryptSimplifiedPasswordEvent(application: application, encryptionKey: encryptionKey));
          },
          child: Text("Generate simplified"),)
      ],);
  }
  
}