import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_app/features/home/models/banner_model.dart';
import 'package:my_app/features/home/controllers/banner_slider_controller.dart';
import 'package:my_app/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BannerSliderView extends StatefulWidget {
  const BannerSliderView({super.key});

  @override
  BannerSliderViewState createState() => BannerSliderViewState();
}

class BannerSliderViewState extends State<BannerSliderView> {
  final BannerController _controller = BannerController();

  @override
  void initState() {
    super.initState();
    _controller.fetchBanners();
  }

  Future<void> refreshBanners() async {
    await _controller.fetchBanners();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _controller,
      child: Consumer<BannerController>(
        builder: (context, controller, _) {
          return Padding(
            padding: const EdgeInsets.only(top: 40),
            child: _bannerCarousel(context, controller),
          );
        },
      ),
    );
  }

  Widget _bannerCarousel(BuildContext context, BannerController controller) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double bannerHeight = screenWidth / 2.2;

    // تحديد الحالة العامة
    final bool isLoading = controller.isLoading;
    final bool isError = controller.success == false;
    final bool isEmpty =
        controller.success == true && controller.banners.isEmpty;
    final bool hasData =
        controller.success == true && controller.banners.isNotEmpty;

    // تحديد عدد العناصر
    final int itemCount = isLoading
        ? 3
        : isError || isEmpty
        ? 1
        : controller.banners.length;

    return CarouselSlider.builder(
      itemCount: itemCount,
      itemBuilder: (context, index, int realIndex) {
        if (isLoading) return Skeletonizer(child: _skeletonItem());
        if (isError) return _errorItem();
        if (isEmpty) return _emptyItem();

        // نجاح مع بيانات
        final banner = controller.banners[index];
        return _bannerItem(banner);
      },
      options: CarouselOptions(
        autoPlay: hasData,
        pauseAutoPlayOnTouch: true,
        height: bannerHeight,
        viewportFraction: 0.8,
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.scale,
        enlargeFactor: 0.2,
      ),
    );
  }

  Widget _skeletonItem() {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ColoredBox(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _bannerItem(BannerModel banner) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image.network(banner.image, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _emptyItem() {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: Colors.grey.shade100,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
                const SizedBox(height: 8),
                Text(
                  S.of(context).banner_no_banners,
                  style: TextStyle(color: Colors.black54, fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _errorItem() {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.grey.shade200,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline, color: Colors.red, size: 40),
                const SizedBox(height: 8),
                Text(
                  S.of(context).banner_error_loading,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  S.of(context).banner_error_subtitle,
                  style: TextStyle(color: Colors.black54, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
