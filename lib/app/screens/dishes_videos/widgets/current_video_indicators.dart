import 'package:flutter/material.dart';

class CurrentVideoIndicators extends StatelessWidget {
  final int quantity;
  final int selectedIndex;
  const CurrentVideoIndicators(
      {super.key, required this.quantity, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          quantity,
          (index) => Icon(
                Icons.coffee,
                color: index == selectedIndex ? Colors.orange : Colors.grey,
              )),
    );
  }
}
