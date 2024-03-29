import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Abutton extends StatelessWidget {
  Abutton({
    required this.size,
    required this.onpressed,
    required this.child,
    required this.colors,
    Key? key,
  }) : super(key: key);
  Size size;
  Widget child;
  void Function() onpressed;
  Color colors;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(colors),
            fixedSize: MaterialStateProperty.all(size),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
            shadowColor: MaterialStateProperty.all(Colors.black)),
        onPressed: onpressed,
        child: child);
  }
}
