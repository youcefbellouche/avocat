import 'package:flutter/material.dart';
import 'package:avocat/constant.dart';

// ignore: must_be_immutable
class CustomField extends StatelessWidget {
  CustomField(
      {Key? key,
      required this.label,
      this.textInputType,
      required this.read,
      this.value,
      this.mdp = false,
      this.controller,
      this.suffix,
      this.validator})
      : super(key: key);
  String label;
  String? value;
  TextEditingController? controller;
  TextInputType? textInputType;
  FormFieldValidator<String>? validator;
  bool read;
  Widget? suffix;
  bool mdp;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12, right: 12),
      padding: EdgeInsets.all(12),
      child: TextFormField(
        obscureText: mdp,
        readOnly: read,
        controller: controller,
        initialValue: value,
        validator: validator,
        keyboardType: textInputType,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(color: Colors.black, decoration: TextDecoration.none),
        decoration: InputDecoration(
          suffixIcon: suffix,
          labelStyle:
              TextStyle(fontWeight: FontWeight.w400, color: primaryColor),
          labelText: label,
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(24)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: primaryColor, width: 1),
              borderRadius: BorderRadius.circular(24)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: secondaryColor, width: 1),
              borderRadius: BorderRadius.circular(24)),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: secondaryColor, width: 1),
              borderRadius: BorderRadius.circular(24)),
        ),
      ),
    );
  }
}
