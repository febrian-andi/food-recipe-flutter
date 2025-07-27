import 'package:flutter/material.dart';
import 'package:foodrecipeapp/model/recipes.dart';
import 'package:foodrecipeapp/widgets/info_icon.dart';
import 'package:foodrecipeapp/widgets/list_item.dart';
import 'package:foodrecipeapp/widgets/favorite_button.dart';
import 'package:foodrecipeapp/utils/favorite_manager.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;
  final FavoriteManager favoriteManager;
  final Function(Recipe) toggleFavorite;

  const RecipeDetailScreen({
    super.key,
    required this.recipe,
    required this.favoriteManager,
    required this.toggleFavorite,
  });

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  void _handleToggleFavorite(Recipe recipe) {
    widget.toggleFavorite(recipe);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageHeight = screenWidth > 500.0 ? 350.0 : 200.0;
    final imageFit = screenWidth > 500.0 ? BoxFit.fitHeight : BoxFit.cover;
    final recipe = widget.recipe;

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        actions: [
          FavoriteButton(
            recipe: recipe,
            favoriteManager: widget.favoriteManager,
            onToggle: _handleToggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'images/recipes/${recipe.image}',
                height: imageHeight,
                width: double.infinity,
                fit: imageFit,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                recipe.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InfoIcon(icon: Icons.bar_chart, text: recipe.difficulty),
                    InfoIcon(icon: Icons.local_dining, text: recipe.category),
                    InfoIcon(
                      icon: Icons.people,
                      text: '${recipe.servings} Porsi',
                    ),
                    InfoIcon(icon: Icons.timer, text: recipe.cookTime),
                  ],
                ),
              ),
            ),
            const Divider(height: 32),
            const Text(
              'Bahan-bahan:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListItem(items: recipe.ingredients),
            const SizedBox(height: 24),
            const Text(
              'Cara Memasak:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListItem(items: recipe.steps, numberedList: true),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
