import 'package:flutter/material.dart';
import 'package:project_santa/ui/features/auth/view/login_screen/login_screen.dart';
import 'package:provider/provider.dart';

import '../../auth/view_models/auth_view_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Center(child: ElevatedButton(onPressed: () async{
      await authViewModel.signOutCommand.execute();
      if(authViewModel.signOutCommand.completed){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      }
      if(authViewModel.signOutCommand.error){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign out failed')));

      }
    }, child: Text("SignOut")),);
  }
}
