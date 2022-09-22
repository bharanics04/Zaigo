import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomImage extends StatelessWidget {
  final String? imageUrl;
  final String name;

  const CustomImage({Key? key,required this.imageUrl,required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return image();
  }

  image(){
    return CircleAvatar(
        child: imageUrl != null && imageUrl!.trim().isNotEmpty
            ? imageUrl!.contains(".svg")?svgImage():imageNetwork()
            : Text(name.isNotEmpty && name.length!=1?name.substring(0, 2):name));
  }

  imageNetwork(){
    return Image.network(imageUrl!,errorBuilder: (context, object, trace) {
      return Text(name.isNotEmpty && name.length!=1?name.substring(0, 2):name);
    },);
  }

  svgImage(){
    return SvgPicture.network(imageUrl!,);
  }

}
