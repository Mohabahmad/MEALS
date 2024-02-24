
import 'package:app/providers/filters_provider.dart';
import 'package:app/providers/favorites_providers.dart';
import 'package:app/screens/categories.dart';
import 'package:app/screens/filters.dart';
import 'package:app/screens/meals.dart';
import 'package:app/widgets/main_drwer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const kInitialFilters = {
  Filter.glutenFree:false,
    Filter.lactoseFree:false,
    Filter.vegetarian:false,
    Filter.vegan:false,
};
class TabsSceen extends ConsumerStatefulWidget {
  const TabsSceen({super.key});

  @override
  ConsumerState<TabsSceen> createState() => _TabsSceenState();
}

class _TabsSceenState extends ConsumerState<TabsSceen> {
  int _selectedPageIndex = 0;
 

    
 

  void _selctPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
  Navigator.of(context).pop();
  if (identifier == 'Filters') {
     await Navigator.of(context).push<Map<Filter, bool>>(
      MaterialPageRoute(
        builder: (ctx) => const FilterScreen(),
      ),
    );
   
  } else if (identifier == 'Meals') {
    setState(() {
      _selectedPageIndex = 0; // Set the index to 0 for the Meals screen
    });
  }
}

  @override
  Widget build(BuildContext context) {
    
    final availableMeals= ref.watch(filteredMealProvider);


    Widget activePage = CategoriesScreen(
      
      availableMeals: availableMeals,
    );
    var activePageTitel = 'Category';
    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(fevoriteMealProvider);

      activePage = MealsScreen(
        meals: favoriteMeals,
       
      );
      activePageTitel = 'Your favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitel),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
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
