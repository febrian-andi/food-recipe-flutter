import 'package:flutter/material.dart';
import 'package:foodrecipeapp/model/recipes.dart';
import 'package:foodrecipeapp/widgets/recipe_gried_view.dart';
import 'package:foodrecipeapp/widgets/recipe_list_view.dart';
import 'package:foodrecipeapp/widgets/recommended_recipe_list.dart';
import 'package:foodrecipeapp/widgets/category_selector.dart';
import 'package:foodrecipeapp/utils/favorite_manager.dart';

class RecipeList extends StatelessWidget {
  final List<Recipe> recipes;
  final FavoriteManager favoriteManager;
  final String selectedCategory;
  final Function(Recipe) toggleFavorite;
  final List<String> categories;
  final Function(String) onCategorySelected;

  const RecipeList({
    super.key,
    required this.recipes,
    required this.favoriteManager,
    required this.toggleFavorite,
    required this.selectedCategory,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final popularRecipes = recipes.take(5).toList();

    final filteredRecipes =
        (selectedCategory == 'Semua'
                ? recipes
                : recipes.where((r) => r.category == selectedCategory))
            .where((r) => !popularRecipes.contains(r))
            .toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Rekomendasi',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          RecommendedRecipeList(
            popularRecipes: popularRecipes,
            favoriteManager: favoriteManager,
            toggleFavorite: toggleFavorite,
          ),
          CategorySelector(
            categories: categories,
            selectedCategory: selectedCategory,
            onCategorySelected: onCategorySelected,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              selectedCategory == 'Semua'
                  ? 'Semua Resep'
                  : 'Resep $selectedCategory',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth <= 600) {
                return RecipeListView(
                  filteredRecipes: filteredRecipes,
                  favoriteManager: favoriteManager,
                  toggleFavorite: toggleFavorite,
                );
              } else {
                return RecipeGridView(
                  filteredRecipes: filteredRecipes,
                  favoriteManager: favoriteManager,
                  toggleFavorite: toggleFavorite,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
