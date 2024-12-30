import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:project_santa/ui/common/widgets/side_category_tile/side_cat_tile.dart';
import 'package:project_santa/ui/features/category/view/category_screen.dart';

class SuperCategoryScreen extends StatelessWidget {
  const SuperCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) {
          return KSuperSubCategoryGroupWidget(
            heading: 'Grocery & Kitchen',
            imageLink: 'assets/atta.png',
            title: 'Atta, Rice & Dal',
            isLoading: false, itemCount: 10, // Set to true to show shimmer
          );
        },
      ),
    );
  }
}

class KSuperSubCategoryGroupWidget extends StatelessWidget {
  const KSuperSubCategoryGroupWidget({
    super.key,
    required this.title,
    required this.imageLink,
    required this.heading,
    this.isLoading = false, required this.itemCount,
  });

  final String heading, title;
  final String imageLink;
  final bool isLoading;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KHeadingWidget(
          title: heading,
          isLoading: isLoading, // Pass the loading state
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .02,
        ),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 8,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            crossAxisCount: 4,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            return KCategoryCardWidget(
              imageLink: imageLink,
              title: title,
              isLoading: isLoading, // Pass the loading state
            );
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .02,
        ),
      ],
    );
  }
}

class KCategoryCardWidget extends StatelessWidget {
  const KCategoryCardWidget({
    super.key,
    required this.imageLink,
    required this.title,
    this.isLoading = false,
  });

  final String imageLink, title;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            height: 12.0,
            width: 60.0,
            color: Colors.grey,
          ),
        ],
      ),
    )
        : InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CategoryScreen()),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.indigo,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  imageLink,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

class KHeadingWidget extends StatelessWidget {
  const KHeadingWidget({
    super.key,
    required this.title,
    this.isLoading = false,
  });

  final String title;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: double.infinity,
        height: 20.0,
        color: Colors.grey,
      ),
    )
        : Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }
}
