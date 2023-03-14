// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import 'dart:convert';
import "package:fluttertoast/fluttertoast.dart";

import "package:http/http.dart" as http;
import "joinclass.dart";

void regAsStud(ip, un, pw, cb) async {

  String url = ip + "api/reg_as_std";
  String msgt='msg not set';
  if(un!=''&&pw!=''){

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"username": un, "password": pw}));
  

  msgt = response.body == "already taken"
      ? "Incorrect Password!"
      : response.body == "Success"
          ? "Successfully registered !"
          : "Something went wrong :(";

  }else{
    msgt = 'Enter valid input';
    
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

class Student extends StatefulWidget {
  Student({hk, required this.ip, super.key});

  String ip;
  bool loggedin = false;

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
  late TextEditingController contr, contr1, contr2;
  String username = '';
  String password = '';

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

  @override
  Widget build(BuildContext context) {
    return widget.loggedin
        ? Joinclass(ip: widget.ip, un: username)
        : Wrap(children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                const Image(image: AssetImage("assets/student.png")),
                Column(
                  children: [
                    const Text("Enter details:"),
                    TextField(
                      controller: contr,
                      onChanged: handlername,
                      decoration: const InputDecoration(labelText: "Username"),
                    ),
                    TextField(
                        controller: contr1,
                        onChanged: handlerpass,
                        obscureText: true,
                        decoration:
                            const InputDecoration(labelText: "Password")),
                    TextButton(
                        onPressed: () {
                          cb() {
                            setState(() {
                              widget.loggedin = true;
                            });
                          }

                          regAsStud(widget.ip, username, password, cb);
                        },
                        child: const Text("Register!"))
                  ],
                )
              ],
            ),
          ]);
  }
}
