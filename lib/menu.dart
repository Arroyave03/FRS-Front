import 'package:flutter/material.dart';
import 'package:front_is/load.dart';
import 'package:front_is/usuario.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'recipe.dart';
import 'result.dart';

class Menu extends StatefulWidget {
  String username = "";
  String secret = "";

  Menu(String user, String secretAuth, {Key? key}) : super(key: key) {
    username = user;
    secret = secretAuth;
  }

  Future<void> requestUserData(context) async {
    dynamic client = http.Client();
    final url = Uri.parse(
        'http://127.0.0.1:6970/get_recipe_db'); //TODO: made a better implementation, not hardcoded

    try {
      final response = await client.get(
        url,
        headers: <String, String>{'secretAuth': secret, 'user': username},
      );
      if (response.statusCode == 200) {
        //print(response.body);
        List<dynamic> json = jsonDecode(response.body);
        List<ResultRecipe> recipes = json.map((itemData) => ResultRecipe.fromJson(itemData)).toList();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Usuario(username, secret, recipes)),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text("Something unexpected happened"),
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
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(
                "Something went wrong. Please try again. SORRY!!! ${e.toString()}"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('OK :('),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> foodRequest(
      String ingredients, int ingredientListLenght, context) async {
    dynamic client = http.Client();
    final url = Uri.parse(
        'http://127.0.0.1:6970/create_recipe'); //TODO: made a better implementation, not hardcoded

    if (ingredientListLenght == 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
                "As you can see, You didn't selected any ingredient at all. So we will not make any recommendation. If you want a recommendation, please select at least one ingredient. >:)"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                    'OK, I understand, I will use at least one ingredient :)'),
              ),
            ],
          );
        },
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Load()),
    );
    try {
      final response = await client.get(
        url,
        headers: <String, String>{
          'secretAuth': secret,
          'ingredients': ingredients
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> json = jsonDecode(response.body);
        List<Recipe> recipes =
            json.map((itemData) => Recipe.fromJson(itemData)).toList();
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Result(recipes, this.username, secret)),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text(
                  "Something unexpected happened. You will be redirected to the main page."),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK :('),
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
                "Something went wrong. Please try again. SORRY!!! ${e.toString()}"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('OK :('),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<bool> ingredientSelected = List.generate(24, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FOOD RECOMMENDATION SYSTEM",
            style: GoogleFonts.montserrat(
                color: Colors.white, fontWeight: FontWeight.w600)),
        backgroundColor: const Color.fromARGB(255, 171, 32, 32),
        actions: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
            child: ElevatedButton(
              onPressed: () {
                widget.requestUserData(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Text("Hola, ${widget.username}",
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
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment(0.0, 0.3),
              colors: [
                Color.fromARGB(255, 107, 20, 20),
                Color.fromARGB(255, 37, 37, 37)
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 25.0, left: 20.0, right: 20.0, bottom: 15.0),
                child: Text(
                  "Selecciona tus ingredientes",
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  childAspectRatio: 1.5,
                ),
                itemCount: 24,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return IngredientCard(
                    ingredientName: getIngredientName(index),
                    imageAssetPath: "assets/images/ingredientes/img_$index.png",
                    isSelected: ingredientSelected[index],
                    onSelected: () {
                      setState(() {
                        ingredientSelected[index] = !ingredientSelected[index];
                      });
                    },
                  );
                },
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      String ingredients = "";
                      int len = 0;
                      for (int i = 0; i < ingredientSelected.length; i++) {
                        if (ingredientSelected[i]) {
                          ingredients += "${getIngredientName(i)},";
                          len++;
                        }
                      }
                      widget.foodRequest(ingredients, len, context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 208, 33, 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text("Let Him Cook",
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Montserrat')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getIngredientName(int index) {
    switch (index) {
      case 0:
        return "Beef";
      case 1:
        return "Butter";
      case 2:
        return "Carrot";
      case 3:
        return "Cheese";
      case 4:
        return "Chicken";
      case 5:
        return "Coconut";
      case 6:
        return "Cream";
      case 7:
        return "Cucumber";
      case 8:
        return "Egg";
      case 9:
        return "Fish";
      case 10:
        return "Flour";
      case 11:
        return "Lemon";
      case 12:
        return "Lettuce";
      case 13:
        return "Milk";
      case 14:
        return "Mushroom";
      case 15:
        return "Onion";
      case 16:
        return "Orange";
      case 17:
        return "Pasta";
      case 18:
        return "Peanut";
      case 19:
        return "Pork";
      case 20:
        return "Potato";
      case 21:
        return "Rice";
      case 22:
        return "Salt";
      case 23:
        return "Tomato";
      default:
        return "Ingrediente $index";
    }
  }
}

class IngredientCard extends StatelessWidget {
  final String ingredientName;
  final String imageAssetPath;
  final bool isSelected;
  final VoidCallback onSelected;

  const IngredientCard({
    super.key,
    required this.ingredientName,
    required this.imageAssetPath,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        margin: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 107, 20, 20)
              : const Color.fromARGB(255, 209, 40, 40),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageAssetPath,
              width: 90,
              height: 90,
            ),
            Text(
              ingredientName,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
