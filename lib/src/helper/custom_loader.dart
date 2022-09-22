import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CustomLoader extends StatelessWidget {
  final bool loader;
  final Widget child;

   const CustomLoader({Key? key, this.loader = false, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(child: Stack(children: [child, loaderView(context)]));
  }

  loaderView(context) {
    return Visibility(
        visible: loader,
        child: Stack(children: [
          BackdropFilter(filter: ui.ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
            child: Container(decoration: BoxDecoration(color: Colors.white.withOpacity(0.1)))),
          Positioned.fill(child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.transparent,
            child: const Center(
                child: CircularProgressIndicator()),
          ))
        ],));
  }
}
