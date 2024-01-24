import 'package:app/model/meal.dart';
import 'package:app/screens/categories.dart';
import 'package:app/screens/meals.dart';
import 'package:app/widgets/main_drwer.dart';
import 'package:flutter/material.dart';

class TabsSceen extends StatefulWidget {
  const TabsSceen({super.key});

  @override
  State<TabsSceen> createState() => _TabsSceenState();
}

class _TabsSceenState extends State<TabsSceen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];

  void _showInfoMessage(String message){
    ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),));

  } 

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
       _showInfoMessage('Meal is no longer a favorite.');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
         _showInfoMessage('Marked as a favorite!');
      });
      
    }
  }

  void _selctPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }
  void _setScreen(String identifier){
    if (identifier == 'filters') {
      
    }else{
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
    );
    var activePageTitel = 'Category';
    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitel = 'Your favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitel),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen,),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selctPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites')
        ],
      ),
    );
  }
}
