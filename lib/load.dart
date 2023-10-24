import 'package:flutter/material.dart';

class Load extends StatelessWidget {
  const Load({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FOOD RECOMMENDATION SYSTEM1"),
        backgroundColor: Color.fromARGB(255, 208, 33, 20),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.link),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(Icons.person),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.red, Colors.black],
          ),
        ),
        child: const Column(
          children: [],
        ),
      ),
    );
  }
}
