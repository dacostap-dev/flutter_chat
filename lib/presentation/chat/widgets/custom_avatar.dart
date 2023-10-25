import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final String avatarUrl;
  final double avatarHeight;
  final double avatarWidth;

  const CustomAvatar({
    super.key,
    required this.avatarUrl,
    required this.avatarHeight,
    required this.avatarWidth,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: avatarUrl,
      imageBuilder: (context, imageProvider) => Container(
        height: avatarHeight,
        width: avatarWidth,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.contain,
            alignment: Alignment.topCenter,
          ),
        ),
      ),
      progressIndicatorBuilder: (context, url, progress) => SizedBox(
        height: avatarHeight,
        width: avatarWidth,
        child: const Center(
          child: CupertinoActivityIndicator(),
        ),
      ),
      errorWidget: (context, url, error) => SizedBox(
        height: avatarHeight,
        width: avatarWidth,
        child: const Icon(Icons.error),
      ),
    );
  }
}
