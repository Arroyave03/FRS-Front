import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Usuario extends StatelessWidget {
  const Usuario({Key? key}) : super(key: key);

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
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Text("Hola, Usuario",
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
            ),
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
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.20,
            color: Color.fromARGB(255, 107, 20, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 70),
                Image.asset("assets/images/perfil.png",
                    width: 200, height: 200),
                const SizedBox(height: 55),
                Text("USUARIO",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white,
                    )),
                const SizedBox(height: 15),
                Text("Teléfono",
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      color: Colors.white,
                    )),
                const SizedBox(height: 15),
                Text("Email",
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment(0.0, 0.3),
                      colors: [
                        Color.fromARGB(255, 107, 20, 20),
                        Color.fromARGB(255, 57, 57, 57),
                      ],
                    ),
                  ),
                ),
                // Cuadro con margen
                Positioned.fill(
                  child: Container(
                    margin: const EdgeInsets.all(40.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 5.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
