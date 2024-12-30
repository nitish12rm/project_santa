import 'package:flutter/material.dart';
import 'package:project_santa/ui/common/widgets/product_tile/product_tile.dart';
import 'package:project_santa/ui/common/widgets/side_category_tile/side_cat_tile.dart';
class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .18,
            child: Card(


color: Colors.white,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SideCatTile(),
                  );
                },
              ),
            ),
          ),
          Flexible( // Added Flexible to make sure content adjusts
            child: Card(

              color: Colors.white,
              child: Column(
                children: [
                  Container(height: 50,),
                  Flexible(
                    child: GridView.builder(
                      itemCount: 10,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.5, // Adjust aspect ratio for better fit
                      ),
                      itemBuilder: (context, index) {
                        return ProductTile();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
