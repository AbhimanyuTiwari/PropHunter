import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../../size_config.dart';

class PropertyImage extends StatefulWidget {
  const PropertyImage({Key? key, required this.images}) : super(key: key);

  final List<String> images;

  @override
  State<PropertyImage> createState() => _PropertyImageState();
}

class _PropertyImageState extends State<PropertyImage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: SizeConfig.screenHeight * .40,
            child: CarouselSlider(
              carouselController: _controller,
              options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                  height: SizeConfig.screenHeight * .40,
                  viewportFraction: 1.0,
                  // enlargeCenterPage: true,
                  enableInfiniteScroll: widget.images.length > 1,
                  disableCenter: false),
              items: List.generate(
                widget.images.length,
                (index) => CachedNetworkImage(
                  imageUrl: widget.images[index],
                  fit: BoxFit.fill,
                  placeholder: (con, str) {
                    return Center(
                      child: Image.asset(
                        'assets/images/transparent_logo.png',
                        width: SizeConfig.screenWidth * .50,
                      ),
                    );
                  },
                ),
              ),
            )),
        if (widget.images.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.images.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: AnimatedContainer(
                  duration: defaultDuration,
                  width: 7.0,
                  height: 7.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}
