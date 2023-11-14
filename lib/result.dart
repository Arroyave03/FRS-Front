import 'dart:html';
import 'package:flutter/material.dart';
import 'package:front_is/menu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Result extends StatelessWidget {
  late List recipeList;
  late String user;
  late String secret;

  Future<void> sendRecipe(String recipeName, String recipeUrl, context) async {
    final client = http.Client();
    final url = Uri.parse(
        'http://127.0.0.1:6970/insert_recipe_db'); //TODO: made a better implementation, not hardcoded

    try {
      final response = await client.get(
        url,
        headers: <String, String>{
          'username': user,
          'secretAuth': secret,
          'name': recipeName,
          'url': recipeUrl
        },
      );
      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Recipe saved successfully'),
              content: const Text(
                  "The recipe has been saved in your favorites"),
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
      else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(
                  "Something unexpected happened.\n  ${response.statusCode}"),
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

  Result(this.recipeList, this.user, this.secret, {Key? key}) : super(key: key);

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
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 100.0),
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(500),
                    ),
                    child: DataTable(
                        columns: [
                          DataColumn(
                            label: Text(
                              'Name',
                              style: GoogleFonts.montserrat(
                                  color: Colors.white, fontWeight: FontWeight.w600
                                )
                              )
                          ),
                          DataColumn(
                            label: Text(
                              'URL',
                              style: GoogleFonts.montserrat(
                                  color: Colors.white, fontWeight: FontWeight.w600
                                )
                              )
                          ),
                          DataColumn(
                            label: Text(
                              'Ingredients',
                              style: GoogleFonts.montserrat(
                                  color: Colors.white, fontWeight: FontWeight.w600
                                )
                            )
                          ),
                          DataColumn(
                            label: Text(
                              'Favorites',
                              style: GoogleFonts.montserrat(
                                  color: Colors.white, fontWeight: FontWeight.w600
                                )
                            )
                          ),
                        ],
                        rows: recipeList.map((item) {
                          return DataRow(cells: [
                            DataCell(
                              Text(
                                item.name, 
                                style: GoogleFonts.montserrat(
                                  color: Colors.white, fontWeight: FontWeight.w600
                                )
                              ),
                            ),
                            DataCell(
                              Text(
                                item.url,
                                style: GoogleFonts.montserrat(
                                  color: Colors.white, fontWeight: FontWeight.w600
                                )
                                )
                            ),
                            DataCell(
                              Text(
                                item.ingredients,
                                style: GoogleFonts.montserrat(
                                  color: Colors.white, fontWeight: FontWeight.w600
                                )
                              )
                            ),
                            DataCell(IconButton(
                              icon: const Icon(Icons.favorite, color: Colors.white,),
                              onPressed: () {
                                // Call your function when the heart button is pressed
                                // You can pass the item to the function if needed
                                //TODO: call function to send favorite
                                sendRecipe(item.name, item.url, context);
                              },
                            )),
                          ]);
                        }).toList(),
                        headingRowColor: MaterialStateColor.resolveWith(
                            (states) => const Color.fromARGB(255, 107, 20, 20)),
                        dataRowColor: MaterialStateColor.resolveWith((states) =>
                            const Color.fromARGB(255, 209, 40, 40))
                    )
                  )
                ),
          ),
        ],
      ),
    );
  }
}
