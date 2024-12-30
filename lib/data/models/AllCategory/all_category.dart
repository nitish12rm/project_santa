class AllCategoryModel {
  List<Supercategory>? supercategory;

  AllCategoryModel({this.supercategory});

  AllCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['supercategory'] != null) {
      supercategory = <Supercategory>[];
      json['supercategory'].forEach((v) {
        supercategory!.add(new Supercategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.supercategory != null) {
      data['supercategory'] =
          this.supercategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Supercategory {
  String? name;
  List<Category>? category;

  Supercategory({this.name, this.category});

  Supercategory.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String? name;
  String? imageLink;
  List<Items>? items;

  Category({this.name, this.imageLink, this.items});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imageLink = json['image_link'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image_link'] = this.imageLink;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? name;
  String? imageLink;

  Items({this.name, this.imageLink});

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imageLink = json['image_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image_link'] = this.imageLink;
    return data;
  }
}
