import 'package:flutter/material.dart';
import 'package:front_is/load.dart';
import 'package:url_launcher/url_launcher.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<bool> ingredientSelected = List.generate(12, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FOOD RECOMMENDATION SYSTEM"),
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
              child: const Text("Hola, Usuario",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          IconButton(
            icon: Icon(Icons.person),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                      top: 25.0, left: 20.0, right: 20.0, bottom: 15.0),
                  child: Text(
                    "Selecciona los ingredientes",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      childAspectRatio: 1.1,
                    ),
                    itemCount: 12,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return IngredientCard(
                        ingredientName: getIngredientName(index),
                        imageAssetPath: "assets/ingredient_$index.png",
                        isSelected: ingredientSelected[index],
                        onSelected: () {
                          setState(() {
                            ingredientSelected[index] =
                                !ingredientSelected[index];
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            left: MediaQuery.of(context).size.width / 2 - 60,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 208, 33, 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child:
                    Text("Let Him Cook", style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getIngredientName(int index) {
    switch (index) {
      case 0:
        return "Tomato";
      case 1:
        return "Pumpkin";
      case 2:
        return "Carrot";
      case 3:
        return "Beef";
      case 4:
        return "Lettuce";
      case 5:
        return "Asparagus";
      case 6:
        return "Broccoli";
      case 7:
        return "Pork";
      case 8:
        return "Cucumber";
      case 9:
        return "Chicken";
      case 10:
        return "Fish";
      case 11:
        return "Potato";
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
              width: 70, // Ancho de la imagen
              height: 70, // Alto de la imagen
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
