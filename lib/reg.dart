// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  Register({this.hk, super.key});

  dynamic hk;

  

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final btnstyle = TextButton.styleFrom(
      foregroundColor: const Color.fromARGB(137, 0, 0, 0),
      backgroundColor: Colors.amber,
      textStyle: const TextStyle(fontSize: 20),
      padding: const EdgeInsets.all(26));
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () {
              widget.hk("Student");
            },
            style: btnstyle,
            child: const Text("Register as a student")),
        TextButton(
            onPressed: () {
              widget.hk("Teacher");
            },
            style: btnstyle,
            child: const Text("Register as a Teacher"))
      ],
    );
  }
}
