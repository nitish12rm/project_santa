import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_santa/app/bottom_navigation_bar/view/bottombar.dart';
import 'package:project_santa/ui/features/auth/view/login_screen/login_screen.dart';
import 'package:provider/provider.dart';

import '../ui/features/auth/view_models/auth_view_model.dart';



class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder<User?>(
        stream: authViewModel.authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show a loading screen while waiting
          }
          if (snapshot.hasData) {
            return KNavigationBar(); // User is logged in
          }
          return LoginScreen(); // User is not logged in
        },
      ),
    );
  }
}