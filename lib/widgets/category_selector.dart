import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategorySelector({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: OutlinedButton(
              onPressed: () => onCategorySelected(category),
              style: OutlinedButton.styleFrom(
                backgroundColor: isSelected ? Colors.orange : Colors.orange[50],
                foregroundColor: isSelected ? Colors.white : Colors.orange[800],
                side: const BorderSide(color: Colors.orange, width: 1.5),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(category),
            ),
          );
        },
      ),
    );
  }
}
