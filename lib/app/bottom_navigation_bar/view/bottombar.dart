import 'package:flutter/material.dart';
import 'package:project_santa/ui/features/auth/view/login_screen/login_screen.dart';
import 'package:project_santa/ui/features/home/view/HomeScreen.dart';
import 'package:provider/provider.dart';

import '../../../ui/features/auth/view/register_screen/register_screen.dart';
import '../../../ui/features/profile/view/profile_screen.dart';
import '../view_model/bottom_navigation_bar_viewmodel.dart';

class KNavigationBar extends StatefulWidget {
  const KNavigationBar({super.key});

  @override
  State<KNavigationBar> createState() => _KNavigationBarState();
}

class _KNavigationBarState extends State<KNavigationBar> {
  final List<Widget> _pages = [
    Homescreen(),
    Center(child: Text('Search Page')),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Consumer<KNavigationBarViewModel>(
        builder: (context, viewModel, child) {
          return _pages[viewModel.index];
        },
      ),
      bottomNavigationBar: Consumer<KNavigationBarViewModel>(
        builder: (context, viewModel, child) {
          return NavigationBar(
              selectedIndex: viewModel.index,
              onDestinationSelected: (index)=>viewModel.setIndex(index),
              destinations: [
            NavigationDestination(icon: Icon(Icons.home_filled), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          ]);
        },
      ),
    );
  }
}

