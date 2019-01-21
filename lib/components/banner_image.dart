import 'package:flutter/material.dart';

// *** this was what it looked like as a widget inside location_list.dart
//Widget _tileImage(String url, double width, double height) {
//  Image image;
//  try {
//    image = Image.network(url, fit: BoxFit.cover);
//  } catch (e) {
//    print("could not load image $url");
//  }
//  return Container(
//    constraints: BoxConstraints.expand(),
//    child: image,
//  );
//}

class BannerImage extends StatelessWidget {
  final String url;
  final double height;

  BannerImage({this.url, this.height});

  @override
  Widget build(BuildContext context) {
    Image image;
    try {
      image = Image.network(url, fit: BoxFit.cover);
    } catch (e) {
      print("could not load image $url");
    }
    return Container(
      constraints: BoxConstraints.expand(height: height),
      child: image,
    );
  }
}
