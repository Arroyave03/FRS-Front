import 'package:flutter/material.dart';
import 'package:front_is/menu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

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
                  Color.fromARGB(255, 57, 57, 57),
                ],
              ),
            ),
          ),
          // Inicio de sesión
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Image.asset(
                  "assets/images/perfil.png",
                  width: 150,
                  height: 150,
                ),
                SizedBox(height: 40),
                Container(
                  width: 400,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Usuario",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 400,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Contraseña",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Menu()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 247, 47, 47),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    minimumSize: Size(200, 50),
                  ),
                  child: Text("Login",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
