import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:picsum_gallery/data/models/models.dart';
import 'package:picsum_gallery/data/repositories/photo_repository.dart';

part 'photo_event.dart';

part 'photo_state.dart';

const _photoLimit = 20;

class PhotoBloc extends HydratedBloc<PhotoEvent, PhotoState> {
  PhotoBloc({required this.photoRepository}) : super(const PhotoState()) {
    on<PhotoFetched>(_onPhotoFetched);
  }

  final PhotoRepository photoRepository;

  Future<void> _onPhotoFetched(
    PhotoFetched event,
    Emitter<PhotoState> emit,
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
  PhotoState? fromJson(Map<String, dynamic> json) {
    return PhotoState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(PhotoState state) {
    return state.toJson();
  }
}
