import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iotcontroller/components/ShowAlertDialog.dart';
import 'package:iotcontroller/components/rounded_button.dart';
import 'package:iotcontroller/constants/colors.dart';
import 'package:iotcontroller/services/verify.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key key}) : super(key: key);

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType> errorController;

  bool _isAsyncCall = false;
  bool hasError = false;
  String validationCode;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  Future<void> _submit() async {
    // dismiss keyboard during async call
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      _isAsyncCall = true;
    });

    try {
      final response = await VerifyService.verify(validationCode);

      if (response != null) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    } catch (err) {
      print(err);
      AlertDialogComponent.dialog(context, "Incorrect code.");
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
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              "assets/images/verificationImage.jpg",
              width: 300,
              height: 300,
            ),
            Text(
              "We've sent you an verification code to your email.",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700),
            ),
            Form(
              key: _formKey,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                  child: PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                    backgroundColor: Colors.white,

                    length: 6,
                    obscureText: true,
                    obscuringCharacter: '*',
                    // obscuringWidget: FlutterLogo(
                    //   size: 24,
                    // ),
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                        inactiveColor: Colors.white,
                        inactiveFillColor: Colors.white,
                        selectedFillColor: Colors.white),
                    cursorColor: Colors.black,
                    animationDuration: Duration(milliseconds: 300),
                    enableActiveFill: true,
                    errorAnimationController: errorController,
                    controller: textEditingController,
                    keyboardType: TextInputType.text,
                    boxShadows: [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: kPrimaryColor,
                        blurRadius: 10,
                      )
                    ],
                    onCompleted: (v) {
                      print("Completed $v");
                      _submit();
                    },
                    onChanged: (value) {
                      validationCode = value;
                    },
                  )),
            ),
            RoundedButton(
              press: () {
                _formKey.currentState.validate();
                // conditions for validating
                if (validationCode.length != 6) {
                  errorController.add(ErrorAnimationType
                      .shake); // Triggering error shake animation
                  setState(() => hasError = true);
                } else {
                  setState(
                    () {
                      hasError = false;
                    },
                  );
                  _submit();
                }
              },
              text: "VERIFY",
            ),
          ]),
        ),
        inAsyncCall: _isAsyncCall,
        progressIndicator: CircularProgressIndicator(),
        opacity: 0.5,
      ),
    );
  }
}
