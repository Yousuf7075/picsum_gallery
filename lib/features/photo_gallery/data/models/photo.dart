import 'package:picsum_gallery/features/photo_gallery/domain/entities/photo_entity.dart';

class Photo extends PhotoEntity {
  Photo({
    required String id,
    required String author,
    required int width,
    required int height,
    required String url,
    required String downloadUrl,
  }) : super(
            id: id,
            author: author,
            width: width,
            height: height,
            url: url,
            downloadUrl: downloadUrl);

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"],
        author: json["author"],
        width: json["width"],
        height: json["height"],
        url: json["url"],
        downloadUrl: json["download_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "author": author,
        "width": width,
        "height": height,
        "url": url,
        "download_url": downloadUrl,
      };
}
