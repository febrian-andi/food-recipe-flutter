import 'package:flutter/material.dart';
import 'package:foodrecipeapp/model/recipes.dart';
import 'package:foodrecipeapp/screens/recipe_detail_screen.dart';
import 'package:foodrecipeapp/utils/favorite_manager.dart';

class RecipeFavoriteScreen extends StatelessWidget {
  final FavoriteManager favoriteManager;
  final Function(Recipe) onRemoveFavorite;

  const RecipeFavoriteScreen({
    super.key,
    required this.favoriteManager,
    required this.onRemoveFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final favoriteRecipes = favoriteManager.favorites;

    if (favoriteRecipes.isEmpty) {
      return Center(
        child: Text(
          'Belum ada resep favorit.',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Daftar Resep Favorit',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: favoriteRecipes.length,
            itemBuilder: (context, index) {
              final recipe = favoriteRecipes[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: Image.asset(
                    'images/recipes/${recipe.image}',
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                  title: Text(recipe.name),
                  subtitle: Text('${recipe.category} • ${recipe.cookTime}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => onRemoveFavorite(recipe),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RecipeDetailScreen(
                          recipe: recipe,
                          favoriteManager: favoriteManager,
                          toggleFavorite: onRemoveFavorite,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
