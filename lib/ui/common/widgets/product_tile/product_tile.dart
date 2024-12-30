import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Image with "Add" button, background, left-bottom veg/nonveg tag
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .20,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  color: CupertinoColors.systemGrey3,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  'assets/atta.png',

                  height: 80,// Ensures the image covers the area
                ),
              ),
              Positioned(
                right: -12, // Position the button outside of the container
                bottom: -12, // Position the button at the bottom-right
                child: ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(),side:BorderSide(color: Colors.green),backgroundColor: Colors.white,),onPressed: (){}, child: Text("Add",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.green),))
              ),
            ],
          ),

          /// Weight tag and Title
          SizedBox(height: 10),
          Text(
            "gjhkagkjhgkjhgkjhgkjhgkjhjhkgkjyhgkjhgjkhgkhjgjkhghjkgkhjgkjhgkjhgkjhgkhjgkjhgkjhgkjhgkjhgkjhgkjhg", // You can replace with actual product title
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),
          ),

          /// Rating, Time, Off, Price
          SizedBox(height: 2),
          Text("⭐⭐⭐⭐(562679)",style: TextStyle(fontSize: 9),),
          SizedBox(height: 2),
          Text("9mins",style: TextStyle(fontSize: 9),),
          SizedBox(height: 5),
          Text("25% OFF",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
          SizedBox(height: 2),
          Row(
            children: [
              Text(
                "\$667", // Discounted price
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.red, // For discounted price
                ),
              ),
              SizedBox(width: 10,),
              Text(
                "\$999", // Original price
                style: TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.lineThrough, // Strikethrough original price
                  color: Colors.grey, // For original price
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
