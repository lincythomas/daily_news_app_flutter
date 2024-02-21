import 'package:flutter/material.dart';

class WelcomeUser extends StatelessWidget {
  const WelcomeUser({super.key});
  final imageUrl =
      "https://newdpz.com/wp-content/uploads/2023/07/1690284145_997_30-Best-Turkish-actress-Dpz-HD-Images.jpeg";
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        const SizedBox(
          width: 20,
        ),
        const Text(
          "Hi, Handel Cerci",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
