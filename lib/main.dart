import 'package:flutter/material.dart';

import 'home_scrren.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          primaryColor: Color.fromARGB(255, 105, 142, 160),
          shadowColor: Color.fromARGB(255, 18, 177, 201),
          splashColor: Color.fromARGB(153, 9, 93, 123)),
      home: const HomePage(),
    );
  }
}
