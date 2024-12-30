import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_santa/data/models/AllCategory/all_category.dart';
import 'package:project_santa/data/repository/database/database_repository.dart';
import 'package:project_santa/ui/features/auth/view_models/auth_view_model.dart';
import 'package:project_santa/ui/features/category/view/category_screen.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/result.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Name: ${authViewModel.user!.displayName}"),
        Text("Email: ${authViewModel.user!.email}"),
        ElevatedButton(
            onPressed: () async{
                DatabaseRepository repo = DatabaseRepository();
                final result =await  repo.fetchCollection("all_category");

                switch (result) {
                  case Ok<List<Map<String,dynamic>>?>(value:var value):
                    AllCategoryModel data=AllCategoryModel.fromJson(value![0]);
                    log(data.supercategory![0].category![0].items![2].name!);
                    log("auth_VM_success:${value}");
                    log(value![0]["supercategory"][0]["name"].toString());
                  case Error<List<Map<String,dynamic>>?>(error: var error):
                    log("auth_VM_error");

                }
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => CategoryScreen()));
            },
            child: Text("Category"))
      ],
    );
  }
}
