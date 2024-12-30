import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_santa/app/bottom_navigation_bar/view/bottombar.dart';
import 'package:project_santa/data/repository/database/database_repository.dart';
import 'package:project_santa/ui/common/widgets/product_tile/product_tile.dart';
import 'package:project_santa/ui/features/auth/view_models/auth_view_model.dart';
import 'package:project_santa/ui/features/category/view_models/category_view_model.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'app/bottom_navigation_bar/view_model/bottom_navigation_bar_viewmodel.dart';
import 'data/repository/auth/auth_repository.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => KNavigationBarViewModel(),
      ),
      Provider<AuthRepository>(create: (_) => AuthRepository()),
      ChangeNotifierProvider<AuthViewModel>(
          create: (context) => AuthViewModel( authRepository: context.read<AuthRepository>())),
      ChangeNotifierProvider<CategoryViewModel>(create: (context)=>CategoryViewModel(databaseRepository: DatabaseRepository()))
    ],
      child:  MyApp(),
    ),

  );
}
