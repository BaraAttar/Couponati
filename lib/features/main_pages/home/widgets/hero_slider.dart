import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_app/features/main_pages/home/widgets/hero_slider_logic.dart';

class HeroSlider extends StatelessWidget {
  HeroSlider({super.key});

  final BannerController controller = BannerController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BannerModel>>(
      future: controller.fetchBanners(),
      builder: (context, snapshot) {
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return SizedBox(
        //     height: MediaQuery.of(context).size.height * 0.25,
        //     child: const Center(child: CircularProgressIndicator()),
        //   );
        // }

        List<BannerModel> banners = snapshot.data ?? [];
        if (banners.isEmpty) {
          banners = [BannerModel(id: "", name: "", image: "", active: true)];
        }

        return CarouselSlider.builder(
          itemCount: banners.length,
          itemBuilder: (context, index, realIndex) {
            return _buildBannerItem(context, banners[index].image);
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
      },
    );
  }

  Widget _buildBannerItem(BuildContext context, String imagePath) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          color: Colors.grey[300],
          child: _buildImageWithFallback(imagePath),
        ),
      ),
    );
  }

  Widget _imageNotFound() {
    return Container(
      color: Colors.grey.shade100,
      width: double.infinity,
      height: double.infinity,
      child: Image.asset(
        "assets/images/404-page-not-found-1-24.png",
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildImageWithFallback(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return _imageNotFound();
    }

    return Image.network(
      imagePath,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        return _imageNotFound();
      },
    );
  }
}
