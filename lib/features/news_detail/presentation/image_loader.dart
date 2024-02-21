import 'package:flutter/widgets.dart';

class ImageLoader extends StatelessWidget {
  final String imageUrl;

  const ImageLoader({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.fill,
    );
  }
}
