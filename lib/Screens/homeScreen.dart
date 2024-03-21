import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String id;
  final String name;
  final String job;

  HomeScreen(
      {super.key, required this.id, required this.name, required this.job});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("ID: ${widget.id}"),
          Text("Name: ${widget.name}"),
          Text("Job: ${widget.job}"),
        ],
      ),
    );
  }
}
