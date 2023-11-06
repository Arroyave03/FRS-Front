import 'package:flutter/material.dart';
import 'package:front_is/load.dart';
import 'package:front_is/usuario.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Menu extends StatefulWidget {

  String username = ""; 
  
  Menu(user, {Key? key}): super(key: key){
    username = user;
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
        backgroundColor: Color.fromARGB(255, 171, 32, 32),
        actions: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Usuario()),
                );
              },
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Load(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 208, 33, 20),
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

  IngredientCard({
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
        margin: EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: isSelected
              ? Color.fromARGB(255, 107, 20, 20)
              : Color.fromARGB(255, 209, 40, 40),
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
