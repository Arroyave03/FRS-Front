import 'package:flutter/material.dart';
import 'package:front_is/usuario.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Recetas extends StatelessWidget {
  const Recetas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FOOD RECOMMENDATION SYSTEM",
          style: GoogleFonts.montserrat(
              color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Color.fromARGB(255, 171, 32, 32),
        actions: <Widget>[
          const Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
          ),
          IconButton(
            icon: Image.asset(
              "assets/images/git.png",
              width: 30,
              height: 30,
            ),
            onPressed: () async {
              await launch('https://github.com');
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment(0.0, 0.3),
                colors: [
                  Color.fromARGB(255, 107, 20, 20),
                  Color.fromARGB(255, 57, 57, 57)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
