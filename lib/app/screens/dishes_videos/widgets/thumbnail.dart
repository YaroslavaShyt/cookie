import 'package:flutter/material.dart';

class Thumbnail extends StatelessWidget {
  final String imageUrl;
  const Thumbnail({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.purple, width: 5),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            )));
  }
}
