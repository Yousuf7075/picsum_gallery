import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:picsum_gallery/core/router/app_router.dart';
import 'package:picsum_gallery/features/photo_gallery/domain/entities/photo.dart';

class PhotoListItem extends StatelessWidget {
  const PhotoListItem({Key? key, required this.photo}) : super(key: key);

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRouter.photoFullScreen,
            arguments: photo.downloadUrl);
      },
      child: CachedNetworkImage(
        imageUrl: photo.downloadUrl!,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          height: double.infinity,
          color: Colors.grey.shade300,
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
