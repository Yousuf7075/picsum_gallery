import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:picsum_gallery/features/photo_gallery/data/models/models.dart';
import 'package:picsum_gallery/data/repositories/photo_repository.dart';

part 'photo_event.dart';

part 'photo_state.dart';

const _photoLimit = 20;

class PhotoGalleryBloc extends HydratedBloc<PhotoEvent, PhotoGalleryState> {
  PhotoGalleryBloc({required this.photoRepository}) : super(const PhotoGalleryState()) {
    on<PhotoFetched>(_onPhotoFetched);
  }

  final PhotoRepository photoRepository;

  Future<void> _onPhotoFetched(
    PhotoFetched event,
    Emitter<PhotoGalleryState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PhotoStatus.initial) {
        final photos = await photoRepository.getPhotos(
            page: event.page, limit: _photoLimit);
        return emit(state.copyWith(
          status: PhotoStatus.success,
          photos: photos,
          hasReachedMax: false,
          page: event.page
        ));
      }
      final photos =
          await photoRepository.getPhotos(page: event.page, limit: _photoLimit);
      photos!.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: PhotoStatus.success,
                photos: List.of(state.photos)..addAll(photos),
                hasReachedMax: false,
                  page: event.page
              ),
            );
    } catch (_) {
      return emit(state.copyWith(
          status: state.status,
          photos: state.photos,
          hasReachedMax: state.hasReachedMax,
          page: state.page
      ));
    }
  }

  @override
  PhotoGalleryState? fromJson(Map<String, dynamic> json) {
    return PhotoGalleryState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(PhotoGalleryState state) {
    return state.toJson();
  }
}
