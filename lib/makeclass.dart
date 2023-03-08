// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import "package:http/http.dart" as http;

void makeclass(ip, un, link) async {
  String url = ip + "api/makecls";
  await http.post(Uri.parse(url),
      body: json.encode({"class_url": link, "username": un}),
      headers: {"Content-Type": "application/json"});

  // print("inside make class");
  // print(resp.body);
}

void quitclass(ip, un) async {
  String url = ip + "api/quitcls";
  await http.post(Uri.parse(url),
      body: json.encode({"username": un}),
      headers: {"Content-Type": "application/json"});

  // print("inside quit class");
  // print(resp.body);
}

void addmalgicoins(ip, shnme, amt) async {
  // print("ge : \n $amt");
  String url = ip + "api/malgicoin";
  var resp = await http.post(Uri.parse(url),
      body: json.encode({"username": shnme, "amount": amt}),
      headers: {"Content-Type": "application/json"});

  // print("inside malgicoin ");
  // print(resp.body);
  String msgt = '';
  if (resp.body == "fail") {
    msgt = "Adding Malgi coins to $shnme failed !";
  } else {
    msgt = "$amt Malgi coins given to $shnme";
  }

  Fluttertoast.showToast(
      msg: msgt,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color.fromARGB(255, 86, 75, 247),
      textColor: Colors.white,
      fontSize: 16.0);
}

class Makeclass extends StatefulWidget {
  Makeclass({required this.username, required this.ip, super.key});

  String link = "http://google.com";
  String username;
  String shname = '';
  String ip;
  int amt = 0;

  @override
  State<Makeclass> createState() => _MakeclassState();
}

class _MakeclassState extends State<Makeclass> {
  late TextEditingController contr;
  late TextEditingController contr1;
  late TextEditingController contr2;

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

  late var handlelink = (val) {
    setState(() {
      widget.link = val;
    });
  };
  late var handleshname = (val) {
    setState(() {
      widget.shname = val;
    });
  };
  late var handlecoins = (val) {
    setState(() {
      widget.amt = int.parse(val);
    });
  };

  bool classrunning = false;

  @override
  Widget build(BuildContext context) {
    return classrunning
        ? Wrap(
            children: [
              Text("Your class is running at ${widget.link}"),
              const Text("Add Malgi coins here:"),
              TextField(
                controller: contr1,
                onChanged: handleshname,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: contr2,
                onChanged: handlecoins,
                decoration:
                    const InputDecoration(labelText: "No of Malgi coins"),
              ),
              TextButton(
                  onPressed: () {
                    addmalgicoins(widget.ip, widget.shname, widget.amt);
                    setState(() {
                      widget.amt = 0;
                      widget.shname = '';
                    });
                  },
                  child: const Text("ADD COINS")),
              TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white),
                  onPressed: () {
                    quitclass(
                      widget.ip,
                      widget.username,
                    );
                    setState(() {
                      classrunning = false;
                    });
                  },
                  child: const Text("EXIT CLASS"))
            ],
          )
        : Wrap(children: [
            const Text("Start a class"),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.amber),
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                // live classes here
                TextField(
                  controller: contr,
                  onChanged: handlelink,
                  style: const TextStyle(
                      color: Colors.blue, decoration: TextDecoration.underline),
                ),
                TextButton(
                    onPressed: () {
                      makeclass(widget.ip, widget.username, widget.link);
                      setState(() {
                        classrunning = true;
                      });
                    },
                    child: const Text("Create"))
              ]),
            )
          ]);
  }
}
