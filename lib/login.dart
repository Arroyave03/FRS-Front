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
        if(secretAuth == 0){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("ERROR, THIS DID'T WORK AS  EXPECTED :("),
                content: const Text(
                    "Could not fetch the secretAuth. Please try again."),
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
              title: const Text('ALERT'),
              content: const Text(
                  "As you can see, you entered a wrong username or password. Please try again. and please don't try to hack me :)"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                      'OK, I understand, I will not try to hack you :)'),
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
            title: const Text('ERROR, THIS S**T DID NOT WORK AS  EXPECTED :('),
            content: Text(
                "Something went wrong. Please try again. and please don't try to hack me :)" +
                    e.toString()),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                    'OK, I understand, I will not try to hack you :)'),
              ),
            ],
          );
        },
      );
    }
  }

  Login({Key? key}) : super(key: key);
  String username = "";
  String password = "";

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
                    onChanged: (value) => password = value,
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    //TODO: call the authRequest function
                    //extract user from the first textfield
                    //extract password from the second textfield
                    //call the authRequest function
                    authRequest(username, password, context);

                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Menu()),
                    );*/
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
