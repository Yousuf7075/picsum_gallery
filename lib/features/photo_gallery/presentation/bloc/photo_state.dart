part of 'photo_bloc.dart';

enum PhotoStatus { initial, loading, success, failure }

class PhotoGalleryState extends Equatable {
  const PhotoGalleryState({
    this.status = PhotoStatus.initial,
    this.photos = const <Photo>[],
    this.hasReachedMax = false,
    this.page = 0
  });

  final PhotoStatus status;
  final List<Photo> photos;
  final bool hasReachedMax;
  final int page;

  PhotoGalleryState copyWith({
    PhotoStatus? status,
    List<Photo>? photos,
    bool? hasReachedMax,
    int? page
  }) {
    return PhotoGalleryState(
      status: status ?? this.status,
      photos: photos ?? this.photos,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page
    );
  }

  @override
  String toString() {
    return '''PhotoState { status: $status, hasReachedMax: $hasReachedMax, photos: ${photos.length} }''';
  }

  factory PhotoGalleryState.fromJson(Map<String, dynamic> json) {
    List<Photo> photos = [];
    jsonDecode(json['photos']).forEach((v) {
      photos.add(Photo.fromJson(v));
    });
    return PhotoGalleryState(
      status: json["status"] == "PhotoStatus.success"
          ? PhotoStatus.success
          : PhotoStatus.initial,
      photos: photos,
      hasReachedMax: json["hasReachedMax"] as bool,
      page: json["page"] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status.toString(),
      "photos": jsonEncode(photos),
      "hasReachedMax": hasReachedMax,
      "page": page,
    };
  }

  @override
  List<Object> get props => [status, photos, hasReachedMax];
}
