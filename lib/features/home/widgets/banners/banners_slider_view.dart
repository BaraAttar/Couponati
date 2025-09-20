import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_app/features/home/widgets/banners/banners_slider_logic.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

// ====================== BannerSlider (StatefulWidget) ======================
class BannerSliderView extends StatefulWidget {
  const BannerSliderView({super.key});

  @override
  State<BannerSliderView> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSliderView> {
  late final Future<List<BannerModel>> _bannersFuture;
  final BannerController controller = BannerController();

  @override
  void initState() {
    super.initState();
    _bannersFuture = controller.fetchBanners();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BannerModel>>(
      future: _bannersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Error loading banners'));
        }

        final banners = (snapshot.data != null && snapshot.data!.isNotEmpty)
            ? snapshot.data!
            : [
                BannerModel(
                  id: "",
                  name: "",
                  image: "",
                  link: "",
                  active: true,
                ),
              ];

        return BannerCarousel(banners: banners);
      },
    );
  }
}

// ====================== BannerCarousel ======================
class BannerCarousel extends StatelessWidget {
  final List<BannerModel> banners;

  const BannerCarousel({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
     final double screenWidth = MediaQuery.of(context).size.width;
    final double bannerHeight = screenWidth * 9 / 16; // نسبة 16:9 (1080x1920)

    return CarouselSlider.builder(
      itemCount: banners.length,
      itemBuilder: (context, index, realIndex) {
        return BannerItem(banner: banners[index]);
      },
      options: CarouselOptions(
        autoPlay: true,
        height: bannerHeight,
        viewportFraction: 0.9,
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.scale,
        enlargeFactor: 0.2,
      ),
    );
  }
}

// ====================== BannerItem ======================
class BannerItem extends StatelessWidget {
  final BannerModel? banner;

  const BannerItem({super.key, required this.banner});

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {},
      duration: const Duration(milliseconds: 200),
      child: Container(
        margin: const EdgeInsets.only(top: 50),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            color: Colors.grey[300],
            child: _buildImageWithFallback(banner?.image),
          ),
        ),
      ),
    );
  }

  Widget _buildImageWithFallback(String? path) {
    if (path == null || path.isEmpty) return _imageNotFound();

    return Image.network(
      path,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) => _imageNotFound(),
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
}
