import 'package:flutter/material.dart';
import 'package:iotcontroller/constants/colors.dart';
import 'package:iotcontroller/components/input_filed_container.dart';

class InputTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final Function validator;
  final ValueChanged<String> onChanged;
  const InputTextField(
      {Key key, this.hintText, this.icon, this.onChanged, this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputFieldContainer(
      child: TextFormField(
        validator: validator,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
            errorStyle: TextStyle(
              color: Colors.red[400],
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
            prefixIcon: Icon(
              icon,
              color: kPrimaryColor,
            ),
            hintText: hintText,
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
