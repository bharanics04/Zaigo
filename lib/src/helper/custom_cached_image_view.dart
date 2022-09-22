import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedImageView extends StatelessWidget {
  const CustomCachedImageView({Key? key,required this.url}) : super(key: key);

  final String url;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      height: 55,
      width: 55,
      placeholder: (context, url) => Container(height: 55,width: 55,color: Colors.grey,),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
