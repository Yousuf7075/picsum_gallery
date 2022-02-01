part of 'photo_bloc.dart';

@immutable
abstract class PhotoEvent {}

class PhotoFetched extends PhotoEvent {
  final int page;

  PhotoFetched({required this.page});
}
