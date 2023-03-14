// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import 'dart:convert';
import "makeclass.dart";
import "package:fluttertoast/fluttertoast.dart";

import "package:http/http.dart" as http;

void regAsTchr(ip, un, pw, sub, cb) async {
  
  String url = ip + "api/reg_as_tchr";
  String msgt='msg not set';


  if(un!=''&&pw!=''){

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"username": un, "password": pw, "subject": sub}));
  

  msgt = response.body == "already taken"
      ? "Incorrect password!"
      : response.body == "Success"
          ? "Successfully registered !"
          : "Something went wrong :(";


  }else{
    msgt = "Enter valid input";
  }

  Fluttertoast.showToast(
      msg: msgt,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color.fromARGB(255, 86, 75, 247),
      textColor: Colors.white,
      fontSize: 16.0);

  if (msgt == "Successfully registered !") cb();
}

class Teacher extends StatefulWidget {
  Teacher({this.hk, required this.ip, super.key});

  dynamic hk;
  String ip;
  bool loggedin = false;

  @override
  State<Teacher> createState() => _TeacherState();
}

class _TeacherState extends State<Teacher> {
  late TextEditingController contr, contr1, contr2;
  String username = '';
  String password = '';
  String subject = 'Physics';

  @override
  void initState() {
    super.initState();
    contr = TextEditingController();
    contr1 = TextEditingController();
    contr2 = TextEditingController();
  }

  @override
  void dispose() {
    contr.dispose();
    contr1.dispose();
    contr2.dispose();
    super.dispose();
  }

  late var handlername = (val) {
    setState(() {
      username = val;
    });
  };
  late var handlerpass = (val) {
    setState(() {
      password = val;
    });
  };
  late var handlersub = (val) {
    setState(() {
      subject = val;
    });
  };
  var subjects = ["Maths", "Science", "Physics", "English"];

  @override
  Widget build(BuildContext context) {
    return widget.loggedin
        ? Makeclass(username: username, ip: widget.ip)
        : Wrap(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("Enter your details to register"),
                TextField(
                  controller: contr,
                  onChanged: handlername,
                  decoration: const InputDecoration(labelText: "Username"),
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                TextField(
                  controller: contr1,
                  onChanged: handlerpass,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Password"),
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Image(
                      image: const AssetImage("assets/teacher.png"),
                      width: MediaQuery.of(context).size.width,
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 40),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            DropdownButton(
                                style: const TextStyle(color: Colors.black),
                                value: subject,
                                icon: const Icon(Icons.arrow_downward),
                                items: subjects
                                    .map((e) => DropdownMenuItem(
                                        value: e, child: Text(e)))
                                    .toList(),
                                onChanged: handlersub),
                            TextButton(
                                onPressed: () {
                                  cb() {
                                    setState(() {
                                      widget.loggedin = true;
                                    });
                                  }

                                  regAsTchr(widget.ip, username, password,
                                      subject, cb);
                                },
                                child: const Text("Register!"))
                          ]),
                    ),
                  ],
                )
              ],
            ),
          ]);
  }
}
