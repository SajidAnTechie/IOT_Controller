import 'package:flutter/material.dart';
import 'package:iotcontroller/constants/colors.dart';
import 'package:iotcontroller/model/login.dart';
import 'package:iotcontroller/model/register.dart';
import 'package:iotcontroller/services/login.dart';
import 'package:iotcontroller/services/register.dart';
import 'package:iotcontroller/validators/inputField.dart';
import 'package:iotcontroller/components/backgrount.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:iotcontroller/components/rounded_button.dart';
import 'package:iotcontroller/components/ShowAlertDialog.dart';
import 'package:iotcontroller/components/input_text_field.dart';
import 'package:iotcontroller/components/input_password_field.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool _isAsyncCall = false;
  String email;
  String username;
  String address;
  String password;

  Future<void> _submit() async {
    // dismiss keyboard during async call
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      _isAsyncCall = true;
    });
    final body = RegisterModel(
        name: username, email: email, password: password, address: address);

    try {
      final response = await RegisterService.register(body);

      if (response != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/verify-email', (route) => false);
      }
    } catch (err) {
      print(err);
      AlertDialogComponent.dialog(context, "Incorrect email/password.");
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
            headerName: "Register",
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  InputTextField(
                      hintText: "Enter Your Username",
                      onChanged: (value) => {username = value},
                      icon: Icons.supervised_user_circle,
                      validator: InputFieldValidator.validateUsernameFiled),
                  InputTextField(
                      hintText: "Enter Your Email",
                      onChanged: (value) => {email = value},
                      icon: Icons.email,
                      validator: InputFieldValidator.validateEmailField),
                  InputTextField(
                      hintText: "Enter Your Address",
                      onChanged: (value) => {address = value},
                      icon: Icons.location_on,
                      validator: InputFieldValidator.validateAddressFiled),
                  InputPasswordField(
                      hintText: "Enter Your Password",
                      onChanged: (value) => {password = value},
                      icon: Icons.lock,
                      validator: InputFieldValidator.validatePasswordField),
                  RoundedButton(
                    press: () {
                      if (_formKey.currentState.validate()) {
                        print("Ok");
                        _submit();
                      } else {
                        print("Not ok");
                      }
                    },
                    text: "Register",
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                    child: Row(children: [
                      Text(
                        "Already have a account ?",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () => Navigator.pushNamedAndRemoveUntil(
                            context, '/login', (route) => false),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 50,
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
