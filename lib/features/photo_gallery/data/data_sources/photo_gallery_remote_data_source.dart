import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:picsum_gallery/core/error/exceptions.dart';
import 'package:picsum_gallery/features/photo_gallery/domain/entities/photo.dart';

abstract class PhotoGalleryRemoteDataSource {
  Future<List<Photo>> getPhotos(int page);
}

class PhotoGalleryRemoteDataSourceImpl implements PhotoGalleryRemoteDataSource {
  final http.Client client;

  PhotoGalleryRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Photo>> getPhotos(int page) async {
    final response = await client.get(Uri.parse(
      "https://picsum.photos/v2/list?page=$page&limit=20",
    ));
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        return Photo.fromJson(json);
      }).toList();
    } else {
      throw ServerException();
    }
  }
}
