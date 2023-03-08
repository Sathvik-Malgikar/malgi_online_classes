// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";

class LinkBlock extends StatelessWidget {
  LinkBlock({required this.link, required this.name, super.key});

  String name;
  String link;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.amber, borderRadius: BorderRadius.circular(20)),
      child: Center(
          child: Column(
        children: [
          Text(name),
          Text(
            link,
            style: const TextStyle(
                decoration: TextDecoration.underline, color: Colors.blue),
          ),
        ],
      )),
    );
  }
}
