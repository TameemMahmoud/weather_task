import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weather_task/utils/resources/app_assets.dart';


class CachedImageWidget extends StatelessWidget {
  const CachedImageWidget({
    Key? key,
    required this.image,
    this.height = 80,
  }) : super(key: key);

  final String image;
  final double height;


  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: image,
      // height: height,
      placeholder: (context, url) => Image.asset(AppAssets.mainLogo, height: height, color: Colors.black,),
      errorWidget: (context, url, error) => Image.asset(AppAssets.mainLogo, height: height,),
    );
  }
}
