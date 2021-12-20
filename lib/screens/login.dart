import 'package:flutter/material.dart';
import 'package:iotcontroller/model/user.dart';
import 'package:iotcontroller/components/backgrount.dart';
import 'package:iotcontroller/components/rounded_button.dart';
import 'package:iotcontroller/components/input_text_field.dart';
import 'package:iotcontroller/components/input_password_field.dart';
import 'package:iotcontroller/screens/home.dart';
import 'package:iotcontroller/validators/login.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;

  Future<void> _submit() async {
    UserModel body = UserModel(email: email, password: password);
    print(body);
    Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home()));
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
                    onChanged: (value) => {email = value},
                    icon: Icons.email,
                    validator: LoginValidator.validateEmail),
                InputPasswordField(
                    hintText: "Enter Password",
                    onChanged: (value) => {password = value},
                    icon: Icons.lock,
                    validator: LoginValidator.validatePassword),
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
