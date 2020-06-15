import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passencryptor/features/password/presentation/bloc/password_bloc.dart';
import 'package:passencryptor/features/password/presentation/widgets/password_input.dart';

import '../../../../injection_container.dart';

class PasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: buildBody(context),
          ),
        ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey,
        child: Text(
          "Copyright © 2020 Robbe Nooyens. All Rights Reserved",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10
          ),
        )
      ),
    );
  }

  BlocProvider<PasswordBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PasswordBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              // Bottom half
              PasswordInput(),
              SizedBox(height: 10),
              // Top half
              BlocBuilder<PasswordBloc, PasswordState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return Text("");
                  } else if (state is Loading) {
                    return CircularProgressIndicator();
                  } else if (state is Loaded) {
                    Clipboard.setData(new ClipboardData(text: state.password.encrypted));
                    return Text("Copied to clipboard!");
                  } else if (state is Error) {
                    return Text(state.message);
                  } else {
                    return Text("Unknown state");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  
}