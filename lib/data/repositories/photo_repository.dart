import 'package:picsum_gallery/data/http/http_client.dart';
import 'package:picsum_gallery/features/photo_gallery/data/models/models.dart';

class PhotoRepository {
  PhotoRepository({HttpClient? httpClient})
      : _httpClient = httpClient ?? HttpClient();

  final HttpClient _httpClient;

  Future<List<Photo>?> getPhotos(
      {required int page, required int limit}) async {
    final photos = await _httpClient.getPhotos(page: page, limit: limit);
    return photos;
  }
}
