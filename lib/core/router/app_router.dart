import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picsum_gallery/core/constants/strings.dart';
import 'package:picsum_gallery/core/exceptions/route_exception.dart';
import 'package:picsum_gallery/features/photo_gallery/presentation/bloc/photo_bloc.dart';
import 'package:picsum_gallery/features/photo_gallery/presentation/pages/photo_details_page.dart';
import 'package:picsum_gallery/features/photo_gallery/presentation/pages/photo_gallery_page.dart';
import 'package:picsum_gallery/injection_container.dart';

class AppRouter {
  static const String photoListScreen = '/';
  static const String photoFullScreen = '/photoFullScreenRoute';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case photoListScreen:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider(
                create: (context){
                  final photoBloc = sl<PhotoGalleryBloc>();
                  final photoState = photoBloc.state;
                  if(photoState.status != PhotoStatus.success){
                    photoBloc.add(PhotoFetched(page: 0));
                  }
                  return photoBloc;
                },
                child: const PhotoGalleryPage(
                  title: Strings.homeScreenTitle,
                ),
              ),
        );
      case photoFullScreen:
        final arguments = settings.arguments as String;
        return CupertinoPageRoute(
            builder: (BuildContext context) =>
                PhotoDetailsPage(
                  imageUrl: arguments,
                ));
      default:
        throw const RouteException('Route not found!');
    }
  }
}
