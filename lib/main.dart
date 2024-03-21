import 'package:flutter/material.dart';

import 'Screens/create_job.dart';
import 'Screens/loginWithModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CreateJob(),
    );
  }
}
