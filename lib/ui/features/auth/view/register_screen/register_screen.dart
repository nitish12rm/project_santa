import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_santa/app/bottom_navigation_bar/view/bottombar.dart';
import 'package:provider/provider.dart';

import '../../view_models/auth_view_model.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  if (value.length < 3) {
                    return 'Name must be at least 3 characters long';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  final phoneRegex = RegExp(r'^\d{10}$');
                  if (!phoneRegex.hasMatch(value)) {
                    return 'Phone number must be exactly 10 digits';
                  }
                  return null;
                },
              ),
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
                    final name = nameController.text;
                    final phone = phoneController.text;
                    final email = emailController.text;
                    final password = passwordController.text;

                    // Execute the register command
                    await authViewModel.registerCommand.execute(
                      {
                        "name": name,
                        "phone": phone,
                        "email": email,
                        "password": password,
                      },
                    );

                    // Check the result of the registration operation
                    if (authViewModel.registerCommand.completed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Registration successful')));
                      log('User registered with name: $name, phone: $phone, email: $email');
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>KNavigationBar()));
                    } else if (authViewModel.registerCommand.error) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Registration failed: ${authViewModel.error}')));
                    }
                  }
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
