import 'package:carousel_slider/carousel_slider.dart';
import 'package:drop4life/core/imports/all_imports.dart';

class CarouselWidget extends StatelessWidget {
  final double width;
  final double height;
  final List<Widget> items;
  const CarouselWidget({super.key, required this.height, required this.width, required this.items});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(items: items, options: CarouselOptions(
      height: height * 0.2,
          viewportFraction: 1.0,
          enlargeCenterPage: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
    ));
  }
}
