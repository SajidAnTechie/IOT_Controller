import 'package:flutter/material.dart';
import 'package:iotcontroller/components/backgrount.dart';
import 'package:iotcontroller/components/input_password_field.dart';
import 'package:iotcontroller/components/input_text_field.dart';
import 'package:iotcontroller/components/rounded_button.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BackgroundComponent(
          headerName: "Login",
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                InputTextField(
                  hintText: "Your Email",
                  onChanged: (value) => {},
                  icon: Icons.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid email';
                    }
                    return null;
                  },
                ),
                InputPasswordField(
                  hintText: "Your Password",
                  onChanged: (value) => {},
                  icon: Icons.lock,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
                RoundedButton(
                  press: () {
                    if (_formKey.currentState.validate()) {
                      print("Ok");
                    } else {
                      print("Not ok");
                    }
                  },
                  text: "Login",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
