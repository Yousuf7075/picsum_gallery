import 'package:dartz/dartz.dart';
import 'package:picsum_gallery/core/error/failures.dart';
import 'package:picsum_gallery/features/photo_gallery/domain/entities/photo_entity.dart';

abstract class PhotoGalleryRepository{
  Future<Either<Failure, List<PhotoEntity>>> getPhotoGalleryPhotos(int page);
}