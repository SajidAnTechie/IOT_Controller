import 'package:flutter/material.dart';

class ShowAlertDialog extends StatelessWidget {
  final String errorMessage;
  const ShowAlertDialog({this.errorMessage, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 5,
      content: Text(errorMessage),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context, 'OK');
            },
            child: Text("OK")),
      ],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
    );
  }
}
