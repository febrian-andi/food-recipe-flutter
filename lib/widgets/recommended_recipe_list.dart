import 'package:flutter/material.dart';
import 'package:foodrecipeapp/model/recipes.dart';
import 'package:foodrecipeapp/screens/recipe_detail_screen.dart';
import 'package:foodrecipeapp/utils/favorite_manager.dart';

class RecommendedRecipeList extends StatelessWidget {
  final List<Recipe> popularRecipes;
  final FavoriteManager favoriteManager;
  final Function(Recipe) toggleFavorite;

  const RecommendedRecipeList({
    super.key,
    required this.popularRecipes,
    required this.favoriteManager,
    required this.toggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: popularRecipes.length,
        itemBuilder: (context, index) {
          final recipe = popularRecipes[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RecipeDetailScreen(
                  recipe: recipe,
                  favoriteManager: favoriteManager,
                  toggleFavorite: toggleFavorite,
                ),
              ),
            ),
            child: Container(
              width: 160,
              margin: EdgeInsets.only(left: index == 0 ? 16 : 8, right: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'images/recipes/${recipe.image}',
                      height: 120,
                      width: 160,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          recipe.category,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
