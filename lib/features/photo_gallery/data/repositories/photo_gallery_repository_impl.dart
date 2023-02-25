import 'package:dartz/dartz.dart';
import 'package:picsum_gallery/core/error/exceptions.dart';
import 'package:picsum_gallery/core/error/failures.dart';
import 'package:picsum_gallery/features/photo_gallery/data/data_sources/photo_gallery_remote_data_source.dart';
import 'package:picsum_gallery/features/photo_gallery/domain/entities/photo_entity.dart';
import 'package:picsum_gallery/features/photo_gallery/domain/repository/photo_gallery_repository.dart';

class PhotoGalleryRepositoryImpl implements PhotoGalleryRepository {
  final PhotoGalleryRemoteDataSource remoteDataSource;

  PhotoGalleryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<PhotoEntity>>> getPhotoGalleryPhotos(
      int page) async {
    try {
      final galleryPhotos = await remoteDataSource.getPhotos(page);
      return right(galleryPhotos);
    } on ServerException {
      return left(ServerFailure());
    }
  }
}
