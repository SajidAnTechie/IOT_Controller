import 'package:flutter/material.dart';
import 'package:iotcontroller/constants/colors.dart';
import 'package:iotcontroller/components/input_filed_container.dart';

class InputPasswordField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final Function validator;
  final ValueChanged<String> onChanged;
  const InputPasswordField(
      {Key key, this.hintText, this.icon, this.onChanged, this.validator})
      : super(key: key);

  @override
  _InputPasswordFieldState createState() => _InputPasswordFieldState();
}

class _InputPasswordFieldState extends State<InputPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return InputFieldContainer(
      child: TextFormField(
        validator: widget.validator,
        obscureText: _obscureText,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
            errorStyle: TextStyle(
              color: Colors.red[400],
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
            hintText: widget.hintText,
            prefixIcon: Icon(
              Icons.lock,
              color: kPrimaryColor,
            ),
            suffixIcon: IconButton(
              icon:
                  Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              color: kPrimaryColor,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(29),
                borderSide: BorderSide(color: kPrimaryColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(29),
                borderSide: BorderSide(color: kPrimaryColor)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(29),
                borderSide: BorderSide(color: Colors.red[400])),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(29),
                borderSide: BorderSide(color: Colors.red[400]))),
      ),
    );
  }
}
