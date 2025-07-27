import 'package:flutter/material.dart';
import 'package:foodrecipeapp/model/recipes.dart';
import 'package:foodrecipeapp/screens/recipe_detail_screen.dart';
import 'package:foodrecipeapp/widgets/favorite_button.dart';
import 'package:foodrecipeapp/utils/favorite_manager.dart';

class RecipeListView extends StatelessWidget {
  final List<Recipe> filteredRecipes;
  final FavoriteManager favoriteManager;
  final Function(Recipe) toggleFavorite;

  const RecipeListView({
    super.key,
    required this.filteredRecipes,
    required this.favoriteManager,
    required this.toggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredRecipes.length,
      itemBuilder: (context, index) {
        final recipe = filteredRecipes[index];
        return Card(
          color: Colors.white,
          shadowColor: Colors.grey[200],
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: Image.asset(
              'images/recipes/${recipe.image}',
              width: 80,
              fit: BoxFit.cover,
            ),
            title: Text(recipe.name),
            subtitle: Text('${recipe.category} • ${recipe.cookTime}'),
            trailing: FavoriteButton(
              recipe: recipe,
              favoriteManager: favoriteManager,
              onToggle: toggleFavorite,
            ),
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
          ),
        );
      },
    );
  }
}