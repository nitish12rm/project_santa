import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_santa/app/bottom_navigation_bar/view/bottombar.dart';
import 'package:provider/provider.dart';

import '../../view_models/auth_view_model.dart';
import '../register_screen/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final email = emailController.text;
                    final password = passwordController.text;

                    // Execute the sign-in command
                    await authViewModel.signInCommand.execute(email, password);

                    // Check the result of the sign-in operation
                    if (authViewModel.signInCommand.completed) {
                      // If the command is completed successfully, show success
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logged in successfully')));
                      log(authViewModel.user!.email.toString());
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => KNavigationBar()),
                      );
                    } else if (authViewModel.signInCommand.error) {
                      // If there is an error, show the error message
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed: ${authViewModel.error}')));
                    }
                  }
                },
                child: Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to Registration Screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationScreen()),
                  );
                },
                child: Text('Don\'t have an account? Register here'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
