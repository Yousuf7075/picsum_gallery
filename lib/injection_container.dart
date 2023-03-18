import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:picsum_gallery/features/photo_gallery/data/data_sources/photo_gallery_remote_data_source.dart';
import 'package:picsum_gallery/features/photo_gallery/data/repositories/photo_gallery_repository_impl.dart';
import 'package:picsum_gallery/features/photo_gallery/domain/repository/photo_gallery_repository.dart';
import 'package:picsum_gallery/features/photo_gallery/domain/use_cases/fetch_photos_use_case.dart';
import 'package:picsum_gallery/features/photo_gallery/presentation/bloc/photo_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Photo gallery
  // Bloc
  sl.registerFactory(
    () => PhotoGalleryBloc(fetchPhotosUseCase: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => FetchPhotosUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<PhotoGalleryRepository>(
    () => PhotoGalleryRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<PhotoGalleryRemoteDataSource>(
    () => PhotoGalleryRemoteDataSourceImpl(client: sl()),
  );

  //! External
  sl.registerLazySingleton(() => http.Client());
}
