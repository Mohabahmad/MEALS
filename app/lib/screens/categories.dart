import 'package:app/data/dummy_data.dart';
import 'package:app/model/category.dart';
import 'package:app/model/meal.dart';

import 'package:app/screens/meals.dart';
import 'package:app/widgets/category_gred_item.dart';

import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key,required this.onToggleFavorite});
  final void Function(Meal meal ) onToggleFavorite;
  void _selectCategory(BuildContext context, Category category) {
    
    final filteredMeals = dummyMeals
        .where((meals) => meals.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) =>  MealsScreen(
          meals: filteredMeals,
          title: category.title,
          onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGredItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            )
        ],
    );
  }
}
