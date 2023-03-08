// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'reg.dart';
import 'student.dart';
import 'teacher.dart';

void main() async {
  String adr = "https://malgi-online-classes.onrender.com/";

  runApp(MyApp(ip: adr));
}

class MyApp extends StatefulWidget {
  MyApp({required this.ip, super.key});

  String useragent = "none";
  String ip = 'ip not assigned';
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late var changescreen = (newscreen) {
    setState(() {
      widget.useragent = newscreen;
    });
  };
  late var screen = {
    "none": Register(hk: changescreen),
    "Student": Student(hk: changescreen, ip: widget.ip),
    "Teacher": Teacher(hk: changescreen, ip: widget.ip)
  };

  bool loaded = false;

  late var appLoad = () {
    setState(() {
      loaded = true;
    });
  };

  Duration dur = const Duration(seconds: 2);

  @override
  void initState() {
    super.initState();

    Timer(dur, appLoad);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: loaded
          ? Scaffold(
              appBar: AppBar(
                title: Row(children: [
                  IconButton(
                      onPressed: () {
                        changescreen("none");
                      },
                      icon: const Icon(Icons.arrow_back)),
                  const Text("Malgi online classes !")
                ]),
              ),
              body: Center(child: screen[widget.useragent]),
            )
          : const Image(image: AssetImage("assets/splash.png")),
    );
  }
}
