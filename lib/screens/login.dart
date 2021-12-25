import 'package:flutter/material.dart';
import 'package:iotcontroller/model/login.dart';
import 'package:iotcontroller/services/login.dart';
import 'package:iotcontroller/validators/login.dart';
import 'package:iotcontroller/components/backgrount.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
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
  bool _isAsyncCall = false;
  String email;
  String password;

  Future<void> _submit() async {
    // dismiss keyboard during async call
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      _isAsyncCall = true;
    });
    final body = LoginModel(email: email, password: password);

    try {
      final response = await LoginService.login(body);

      if (response != null) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    } catch (err) {
      print(err);
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                elevation: 5,
                content: Text("Incorrect email/password."),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'OK');
                      },
                      child: Text("Ok")),
                ],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ));
    } finally {
      setState(() {
        _isAsyncCall = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        child: SingleChildScrollView(
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
        inAsyncCall: _isAsyncCall,
        progressIndicator: CircularProgressIndicator(),
        opacity: 0.5,
      ),
    );
  }
}
