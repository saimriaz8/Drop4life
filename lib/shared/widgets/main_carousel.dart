import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class FullscreenCarousel extends StatelessWidget {
  final double width;
  final double height;

  const FullscreenCarousel({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CarouselSlider(
        options: CarouselOptions(
          height: height,
          viewportFraction: 1.0,
          enlargeCenterPage: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
        ),
        items: [
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: width,
                  height: height * 0.5,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    image: DecorationImage(
                      image: AssetImage('assets/images/carousel_img_1.png'),
                      
                    ),
                  ),
                ),
                SizedBox(
                  width: width,
                  height: 10,
                ),
                SizedBox(
                  width: width * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Donate Blood, Save Lives',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Every drop counts.", textAlign: TextAlign.center,
                      ),
                      Text(
                        "Just one donation can save up to 3 lives.", textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: width,
                  height: height * 0.5,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    image: DecorationImage(
                      image: AssetImage('assets/images/carousel_img_2.png'),
                      
                    ),
                  ),
                ),
                SizedBox(
                  width: width,
                  height: 10,
                ),
                SizedBox(
                  width: width * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Why Donate?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Blood cannot be manufactured",
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Your donation helps accident victims, cancer patients, and more.",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: width,
                  height: height * 0.5,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    image: DecorationImage(
                      image: AssetImage('assets/images/carousel_img_3.png'),
                      
                    ),
                  ),
                ),
                SizedBox(
                  width: width,
                  height: 10,
                ),
                SizedBox(
                  width: width * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'It Only Takes 15 Minutes',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Donating blood not only helps others — it also stimulates your body’s natural healing",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
