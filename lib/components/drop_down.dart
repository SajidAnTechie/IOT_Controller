import 'package:flutter/material.dart';
import 'package:iotcontroller/constants/colors.dart';
import 'package:iotcontroller/components/input_filed_container.dart';
import 'package:iotcontroller/model/appliance.dart';

class DropDown extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final Function validator;
  final List<ApplianceData> itemList;
  final ValueChanged<String> onChanged;
  const DropDown({
    Key key,
    this.itemList,
    this.hintText,
    this.icon,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(itemList);
    return InputFieldContainer(
        child: DropdownButtonFormField(
            icon: Icon(
              icon,
              color: kPrimaryColor,
            ),
            decoration: InputDecoration(
                errorStyle: TextStyle(
                  color: Colors.red[400],
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
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
            onChanged: onChanged,
            validator: validator,
            items: itemList
                .map((item) => DropdownMenuItem(
                      child: Text(item.name),
                      value: item.id,
                    ))
                .toList()));
  }
}
