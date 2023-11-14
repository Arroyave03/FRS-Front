class Recipe {
  String name;
  String url;
  String ingredients;

  Recipe({required this.name, required this.url, required this.ingredients});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['recipe'],
      url: json['recipe_urls'],
      ingredients: json['ingredients'],
    );
  }
}

class ResultRecipe {
  String name;
  String url;

  ResultRecipe({required this.name, required this.url});

  factory ResultRecipe.fromJson(Map<String, dynamic> json) {
    return ResultRecipe(
      name: json['recipe_name'],
      url: json['recipe_urls'],
    );
  }
}