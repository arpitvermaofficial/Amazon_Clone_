import 'package:amazon/Constant/global_variable.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CrouselImage extends StatelessWidget {
  const CrouselImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: Globalariables.carouselImages.map((i) {
          return Builder(
            builder: (BuildContext context) => Image.network(
              i,
              fit: BoxFit.cover,
              height: 200,
            ),
          );
        }).toList(),
        options: CarouselOptions(viewportFraction: 1, height: 200));
  }
}
