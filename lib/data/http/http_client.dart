import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:picsum_gallery/data/models/models.dart';

class HttpClient {
  HttpClient({
    http.Client? httpClient,
    this.baseUrl = "https://picsum.photos/v2/list?",
  }) : httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final http.Client httpClient;

  Future<List<Photo>?> getPhotos(
      {required int page, required int limit}) async {
    final response =
        await httpClient.get(Uri.parse(baseUrl + "page=$page&limit=$limit"));
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        return Photo.fromJson(json);
      }).toList();
    } else {
      return null;
    }
  }
}
