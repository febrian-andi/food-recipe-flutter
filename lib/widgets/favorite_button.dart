import 'package:flutter/material.dart';
import 'package:foodrecipeapp/model/recipes.dart';
import 'package:foodrecipeapp/utils/favorite_manager.dart';

class FavoriteButton extends StatelessWidget {
  final Recipe recipe;
  final FavoriteManager favoriteManager;
  final Function(Recipe) onToggle;

  const FavoriteButton({
    super.key,
    required this.recipe,
    required this.favoriteManager,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isFavorite = favoriteManager.isFavorite(recipe);

    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : Colors.grey,
      ),
      onPressed: () => onToggle(recipe),
    );
  }
}
