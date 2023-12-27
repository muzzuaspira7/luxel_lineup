import '../reusablewidget/reusable.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class carousel extends StatefulWidget {
  const carousel({super.key});

  @override
  State<carousel> createState() => _carouselState();
}

class _carouselState extends State<carousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 224, 223, 223),
      width: double.infinity,
      height: 200,
      child: ListView(
        shrinkWrap: true,
        children: [
          CarouselSlider(
            items: [
              reusableWidget().ReusableCursoleContainer(
                  "assets/images/banner1.png",
                  "BALMAIN  PARIS",
                  "Luxury with an Edge"),
              reusableWidget().ReusableCursoleContainer(
                  "assets/images/banner3.png",
                  "PETER  ENGLAND",
                  "Tailored for Every Moment"),
              reusableWidget().ReusableCursoleContainer(
                  "assets/images/banner2.png",
                  "ALLEN  SOLLY",
                  "Innovate Your Style")
            ],
            options: CarouselOptions(
                height: 200,
                aspectRatio: 16 / 9,
                autoPlay: true,
                enlargeCenterPage: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(seconds: 2),
                viewportFraction: 0.8),
          )
        ],
      ),
    );
  }
}
