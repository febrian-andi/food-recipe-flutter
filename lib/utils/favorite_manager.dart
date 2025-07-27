import 'package:foodrecipeapp/model/recipes.dart';

class FavoriteManager {
  final List<Recipe> _favorites = [];

  List<Recipe> get favorites => List.unmodifiable(_favorites);

  bool isFavorite(Recipe recipe) => _favorites.contains(recipe);

  void toggle(Recipe recipe) {
    if (isFavorite(recipe)) {
      _favorites.remove(recipe);
    } else {
      _favorites.add(recipe);
    }
  }
}
