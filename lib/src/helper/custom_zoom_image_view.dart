import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class CustomZoomImageView extends StatelessWidget {
  const CustomZoomImageView({Key? key,this.url,this.fileImage}) : super(key: key);

  final String? fileImage;
  final String? url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,body: Stack(children: [
      photoView(),
       close(context)
    ],),);
  }

  photoView(){
    return PhotoView(
        imageProvider: getImage(),
        initialScale: PhotoViewComputedScale.contained * 0.8,minScale: PhotoViewComputedScale.contained * 0.8,
        backgroundDecoration: const BoxDecoration(color: Colors.black),loadingBuilder: (context,event){
      return loader();
    });
  }

  close(BuildContext context){
    return Positioned(child: InkWell(child: const Icon(Icons.cancel,color: Colors.white,size: 35,),onTap: (){
      Navigator.of(context).pop();
    }),top: 35,right: 20);
  }

  getImage(){
   return url!=null && url!.isNotEmpty?CachedNetworkImageProvider(url!):FileImage(File(fileImage!));
  }

  loader(){
    return const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)));
  }
}
