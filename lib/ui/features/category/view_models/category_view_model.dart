import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_santa/data/models/AllCategory/all_category.dart';
import 'package:project_santa/data/repository/database/database_repository.dart';

import '../../../../core/utils/command.dart';
import '../../../../core/utils/result.dart';

class CategoryViewModel extends ChangeNotifier {
  final DatabaseRepository _databaseRepository;

  CategoryViewModel({required DatabaseRepository databaseRepository})
      : _databaseRepository = databaseRepository {
    load = Command0(getAllCategory)..execute();

  }

  AllCategoryModel _categories = AllCategoryModel();
  AllCategoryModel get categories => _categories;

  String _error = '';
  String get error => _error;

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  Future<Result> getAllCategory() async {
    final result = await _databaseRepository.fetchCollection("all_category");
    switch (result) {
      case Ok<List<Map<String, dynamic>>>(value: var value):
        AllCategoryModel data = AllCategoryModel.fromJson(value![0]);
        log(data.supercategory![0].category![0].items![2].name!);
        _categories = data;
        _isLoading=false;

        break;
      case Error<List<Map<String, dynamic>>>(error: var error):
        _error = error.toString();
        log("auth_VM_error");
        break;
    }
    notifyListeners();
    return result;
  }

  late final Command0 load;

  // Call this method in your screen's initState or when you want to load data
  Future<void> loadCategories() async {
    await load.execute();
  }
}

