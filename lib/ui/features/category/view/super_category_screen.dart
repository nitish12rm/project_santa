import 'package:flutter/material.dart';
import 'package:project_santa/ui/common/widgets/side_category_tile/side_cat_tile.dart';
import 'package:project_santa/ui/features/category/view/category_screen.dart';

class SuperCategoryScreen extends StatelessWidget {
  const SuperCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(itemCount: 4,itemBuilder: (context,index){
        return KSuperSubCategorGroupWidget(heading: 'Grocery & Kitchen', imageLink: 'assets/atta.png', title: 'Atta, Rice & dal',);
      }),
    );
  }
}

class KSuperSubCategorGroupWidget extends StatelessWidget {
  const KSuperSubCategorGroupWidget({
    super.key, required this.title, required this.imageLink, required this.heading,
  });
final String heading,title;
final String imageLink;

  @override
  Widget build(BuildContext context) {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KHeadingWidget(
          title: heading,
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
            childAspectRatio: 0.7, // Adjust aspect ratio for better fit
          ),
          itemBuilder: (context, index) {
            return KCategoryCardWidget(imageLink: imageLink, title: title,);
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
    super.key, required this.imageLink, required this.title,
  });
final String imageLink,title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryScreen())),

      child: Column(
        children: [
          Expanded(
              child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                imageLink,
                fit: BoxFit.cover,
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.indigo,
            ),
          )),
          Text(title,textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}

class KHeadingWidget extends StatelessWidget {
  const KHeadingWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }
}
