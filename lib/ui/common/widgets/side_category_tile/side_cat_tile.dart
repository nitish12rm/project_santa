import 'package:flutter/material.dart';

class SideCatTile extends StatelessWidget {
  const SideCatTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.yellow,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/atta.png',
                height: 35,  // Adjust height to make the image smaller
                width: 35,
                cacheWidth: 250,
                cacheHeight: 250,// Adjust width to make the image smaller
                fit: BoxFit.cover,  // Maintains aspect ratio
              ),
            ),
          ),
        ),
        // TEXT
        Padding(
          padding: const EdgeInsets.only(left: 8.0,right: 8,top: 8),
          child: Text("All",style: TextStyle(fontSize: 10),),
        ),
      ],
    );
  }
}
