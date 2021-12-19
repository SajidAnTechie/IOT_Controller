import 'package:flutter/material.dart';
import 'package:iotcontroller/model/user.dart';
import 'package:iotcontroller/components/backgrount.dart';
import 'package:iotcontroller/components/rounded_button.dart';
import 'package:iotcontroller/components/input_text_field.dart';
import 'package:iotcontroller/components/input_password_field.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  UserModel user = new UserModel();

  String _validateEmail(String value) {
    if (value == null || value.isEmpty) {
      return "Email is required.";
    }

    const pattern = r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return "Please enter the valid email.";
    }
    return null;
  }

  String _validatePassword(String value) {
    if (value == null || value.isEmpty) {
      return "Password is required.";
    }
    return null;
  }

  void _submit() {
    UserModel body = UserModel(email: user.email, password: user.password);
    print(body);
  }

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
                    hintText: "Enter Email",
                    onChanged: (value) => {user.email = value},
                    icon: Icons.email,
                    validator: _validateEmail),
                InputPasswordField(
                    hintText: "Enter Password",
                    onChanged: (value) => {user.password = value},
                    icon: Icons.lock,
                    validator: _validatePassword),
                RoundedButton(
                  press: () {
                    if (_formKey.currentState.validate()) {
                      print("Ok");
                      _submit();
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
