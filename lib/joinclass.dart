// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:malgi_online_classes/main.dart';
import "linkblock.dart";
import "buttons.dart";

void actclass(ip, sub, listhandler) async {
  String query = "?sub=$sub";
  String url = ip + "api/findcls" + query;

  var resp = await http
      .get(Uri.parse(url), headers: {"Content-Type": "application/json"});

  List docarray = json.decode(resp.body) as List;

  List<Widget> col = docarray
      .map((e) => LinkBlock(link: e["link"], name: e["username"]))
      .toList();

  listhandler(col);
}

class Joinclass extends StatefulWidget {
  Joinclass({required this.ip, required this.un, super.key});

  String ip;
  String un;
  String coins = '0';

  void getcoins(ss) async {
    String url = "${ip}api/malgicoin?acc=$un";
    var resp = await http.get(Uri.parse(url));
    // print(resp.body);
    ss(() {
      // if (resp.body == "-1") print("student username not found error");
      coins = resp.body;
    });
  }

  @override
  State<Joinclass> createState() => _JoinclassState();
}

class _JoinclassState extends State<Joinclass> {
  String sub = 'Physics';
  List<Widget> linklist = [];

  late var listhandler = (val) {
    setState(() {
      linklist = val;
    });
  };

  var subjects = ["Maths", "Science", "Physics", "English"];

  late var handlersub = (val) {
    setState(() {
      sub = val;
    });
  };

  @override
  void initState() {
    widget.getcoins(setState);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget btn = logoutbtn(context);
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        btn,
        Container(
          padding: const EdgeInsets.all(30),
          child: Center(child: Text("you have ${widget.coins} Malgicoins !")),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: const Center(
                child: Text("Join a class"),
              ),
            ),
            DropdownButton(
                value: sub,
                icon: const Icon(Icons.arrow_downward),
                items: subjects
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: handlersub),
            TextButton.icon(
                onPressed: () {
                  actclass(widget.ip, sub, listhandler);
                },
                icon: const Icon(Icons.refresh),
                label: const Text("Find"))
          ],
        ),
        linklist.isEmpty
            ? Container()
            : Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.amber),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: linklist,
                ))
      ],
    );
  }
}
