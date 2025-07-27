import 'package:flutter/material.dart';
import 'package:foodrecipeapp/model/recipes.dart';
import 'package:foodrecipeapp/screens/recipe_favorite_screen.dart';
import 'package:foodrecipeapp/widgets/recipe_list.dart';
import 'package:foodrecipeapp/utils/favorite_manager.dart';

class RecipeHomeScreen extends StatefulWidget {
  const RecipeHomeScreen({super.key});

  @override
  State<RecipeHomeScreen> createState() => _RecipeHomeScreenState();
}

class _RecipeHomeScreenState extends State<RecipeHomeScreen> {
  int _selectedIndex = 0;
  String selectedCategory = 'Semua';
  final FavoriteManager favoriteManager = FavoriteManager();

  List<String> get categories => [
        'Semua',
        ...{...recipeList.map((r) => r.category.trim())}.toList()..sort(),
      ];

  void toggleFavorite(Recipe recipe) {
    setState(() {
      favoriteManager.toggle(recipe);
    });
  }

  void onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Row(
          children: [
            Image.asset('images/logo.png', width: 45, height: 45),
            const SizedBox(width: 4),
            Text(
              'Resep Masakan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
      body: _selectedIndex == 0
          ? RecipeList(
              recipes: recipeList,
              favoriteManager: favoriteManager,
              selectedCategory: selectedCategory,
              toggleFavorite: toggleFavorite,
              categories: categories,
              onCategorySelected: onCategorySelected,
            )
          : RecipeFavoriteScreen(
              favoriteManager: favoriteManager,
              onRemoveFavorite: toggleFavorite,
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Colors.orange[50],
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorit'),
        ],
      ),
    );
  }
}
