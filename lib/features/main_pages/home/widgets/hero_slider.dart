import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HeroSlider extends StatelessWidget {
  const HeroSlider({super.key});

  static const List<String> _bannerItems = [
    'https://eksmly.com/storage/728/IMG_2099.png',
    'https://eksmly.com/storage/726/IMG_2097.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: _bannerItems.length,
      itemBuilder: (context, index, realIndex) {
        return _buildBannerItem(context, _bannerItems[index]);
      },
      options: CarouselOptions(
        autoPlay: true,
        height: MediaQuery.of(context).size.height * 0.25,
        viewportFraction: 0.8,
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.scale,
        enlargeFactor: 0.2,
      ),
    );
  }

  Widget _buildBannerItem(BuildContext context, String imagePath) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[300],
        image: DecorationImage(
          image: NetworkImage(imagePath),
          fit: BoxFit.cover,
          onError: (_, __) {},
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.8,
    );
  }

}
