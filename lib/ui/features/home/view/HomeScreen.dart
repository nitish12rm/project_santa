import 'package:flutter/material.dart';
import 'package:project_santa/ui/features/auth/view_models/auth_view_model.dart';
import 'package:project_santa/ui/features/category/view/category_screen.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel=Provider.of<AuthViewModel>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Text("Name: ${authViewModel.user!.displayName}"),
        Text("Email: ${authViewModel.user!.email}"),
        ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryScreen()));}, child: Text("Category"))
      ],
    );
  }
}
