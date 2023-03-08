import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:picsum_gallery/core/error/failures.dart';
import 'package:picsum_gallery/core/use_cases/use_case.dart';
import 'package:picsum_gallery/features/photo_gallery/domain/entities/photo.dart';
import 'package:picsum_gallery/features/photo_gallery/domain/repository/photo_gallery_repository.dart';

class GetPhotoGalleryPhotos implements UseCase<List<Photo>, Params> {
  final PhotoGalleryRepository repository;

  GetPhotoGalleryPhotos({required this.repository});

  @override
  Future<Either<Failure, List<Photo>>> call(Params params) async {
    return await repository.getPhotoGalleryPhotos(params.page);
  }
}

class Params extends Equatable {
  final int page;

  const Params({required this.page});

  @override
  List<Object> get props => [page];
}
