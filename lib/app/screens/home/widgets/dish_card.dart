import 'package:flutter/material.dart';
import 'package:test_pr/domain/dish/idish.dart';

class DishCard extends StatelessWidget {
  final IDish dish;
  const DishCard({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.amber, borderRadius: BorderRadius.circular(30.0)),
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(dish.image)),
          Positioned(
            bottom: 0,
            right: 10,
            child: Text(dish.name,
                style: const TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
