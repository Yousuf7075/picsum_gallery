import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:picsum_gallery/features/photo_gallery/domain/entities/photo.dart';
import 'package:picsum_gallery/features/photo_gallery/domain/use_cases/fetch_photos_use_case.dart';

part 'photo_event.dart';

part 'photo_state.dart';

class PhotoGalleryBloc extends Bloc<PhotoEvent, PhotoGalleryState> {
  PhotoGalleryBloc({required this.fetchPhotosUseCase})
      : super(const PhotoGalleryState()) {
    on<PhotoFetched>(_onPhotoFetched);
  }

  final FetchPhotosUseCase fetchPhotosUseCase;

  Future<void> _onPhotoFetched(
    PhotoFetched event,
    Emitter<PhotoGalleryState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PhotoStatus.initial) {
        final photos = await fetchPhotosUseCase.call(Params(page: event.page));
        photos.fold(
            (failure) => emit(state.copyWith(
                status: PhotoStatus.failure,
                hasReachedMax: false,
                page: event.page)),
            (photos) => emit(state.copyWith(
                status: PhotoStatus.success,
                photos: photos,
                hasReachedMax: false,
                page: event.page)));
      }
      final photos = await fetchPhotosUseCase.call(Params(page: event.page));
      photos.fold(
          (failure) => emit(state.copyWith(
              status: PhotoStatus.failure,
              hasReachedMax: false,
              page: event.page)),
          (photos) => photos.isEmpty
              ? emit(state.copyWith(hasReachedMax: true))
              : emit(
                  state.copyWith(
                      status: PhotoStatus.success,
                      photos: List.of(state.photos)..addAll(photos),
                      hasReachedMax: false,
                      page: event.page),
                ));
    } catch (_) {
      return emit(state.copyWith(
          status: state.status,
          photos: state.photos,
          hasReachedMax: state.hasReachedMax,
          page: state.page));
    }
  }
}
