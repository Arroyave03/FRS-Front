import 'dart:html';
import 'package:flutter/material.dart';
import 'package:front_is/menu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatelessWidget {
  Future<void> authRequest(String user, String password, context) async {
    final client = http.Client();
    final url = Uri.parse(
        'http://127.0.0.1:6970/login'); //TODO: made a better implementation, not hardcoded

    try {
      final response = await client.get(
        url,
        headers: <String, String>{
          'username': user,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);

        String secretAuth = json['secretAuth'] ?? "ERROR";
        if (secretAuth == "ERROR") {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Error"),
                content: const Text(
                    "Could not fetch the secretAuth. Please try again."),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Menu(user, secretAuth)),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text(
                  "Your credential are not valid. If you think this is an error, please contact an administrator or try again in a few minutes."),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                      'OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(
                "Something unexpected happened.\n  ${e.toString()}"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                    'OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Login({Key? key}) : super(key: key);
  late String username;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FOOD RECOMMENDATION SYSTEM",
          style: GoogleFonts.montserrat(
              color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color.fromARGB(255, 171, 32, 32),
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
                const SizedBox(height: 20),
                Image.asset(
                  "assets/images/perfil.png",
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 400,
                  child: TextField(
                    //when this textfield is filled, the user is extracted
                    decoration: InputDecoration(
                      hintText: "Usuario",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onChanged: (value) => username = value,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
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
                    onChanged: (value) => password = value,
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    authRequest(username, password, context);

                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Menu()),
                    );*/
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 247, 47, 47),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    minimumSize: const Size(200, 50),
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
