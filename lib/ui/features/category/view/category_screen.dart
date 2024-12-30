import 'package:flutter/material.dart';
import 'package:project_santa/ui/features/category/view_models/category_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:project_santa/ui/common/widgets/product_tile/product_tile.dart';
import 'package:project_santa/ui/common/widgets/side_category_tile/side_cat_tile.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CategoryViewModel>(context);
    final isLoading = false; // Set to false once data is loaded

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
              child: isLoading
                  ? ShimmerListPlaceholder(itemCount: 15)
                  : ListView.builder(
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
          Flexible(
            child: Card(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    height: 50,
                  ),
                  Flexible(
                    child: isLoading
                        ? ShimmerGridPlaceholder(itemCount: 10)
                        : GridView.builder(
                      itemCount: 10,
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.5,
                      ),
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider<AddButtonViewModel>(create: (context)=> AddButtonViewModel(),child: ProductTile(),);

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

class ShimmerListPlaceholder extends StatelessWidget {
  final int itemCount;

  const ShimmerListPlaceholder({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              height: 50,
              color: Colors.grey,
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
            ),
          ),
        );
      },
    );
  }
}

class ShimmerGridPlaceholder extends StatelessWidget {
  final int itemCount;

  const ShimmerGridPlaceholder({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.5,
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                color: Colors.grey,
                margin: const EdgeInsets.all(8.0),
              ),
              Container(
                height: 20,
                width: double.infinity,
                color: Colors.grey,
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
              ),
            ],
          ),
        );
      },
    );
  }
}
