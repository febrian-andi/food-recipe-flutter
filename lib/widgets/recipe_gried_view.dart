import 'package:flutter/material.dart';
import 'package:foodrecipeapp/model/recipes.dart';
import 'package:foodrecipeapp/screens/recipe_detail_screen.dart';
import 'package:foodrecipeapp/utils/favorite_manager.dart';
import 'package:foodrecipeapp/widgets/favorite_button.dart';

class RecipeGridView extends StatelessWidget {
  final List<Recipe> filteredRecipes;
  final FavoriteManager favoriteManager;
  final Function(Recipe) toggleFavorite;

  const RecipeGridView({
    super.key,
    required this.filteredRecipes,
    required this.favoriteManager,
    required this.toggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 800 ? 4 : 3;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GridView.count(
        crossAxisCount: crossAxisCount,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.7,
        children: filteredRecipes.map((recipe) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RecipeDetailScreen(
                    recipe: recipe,
                    favoriteManager: favoriteManager,
                    toggleFavorite: toggleFavorite,
                  ),
                ),
              );
            },
            child: Card(
              color: Colors.white,
              shadowColor: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.asset(
                      'images/recipes/${recipe.image}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      recipe.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: Text(
                      '${recipe.category} • ${recipe.cookTime}',
                      style: const TextStyle(fontSize: 13),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 8.0),
                    child: FavoriteButton(
                      recipe: recipe,
                      favoriteManager: favoriteManager,
                      onToggle: toggleFavorite,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
