import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picsum_gallery/data/repositories/photo_repository.dart';
import 'package:picsum_gallery/logic/bloc/photo_bloc.dart';
import 'package:picsum_gallery/presentation/screens/photo_full_screen/photo_full_screen.dart';
import 'package:picsum_gallery/presentation/screens/photo_list_screen/photo_list_screen.dart';

import '../../core/constants/strings.dart';
import '../../core/exceptions/route_exception.dart';

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
                  final photoBloc = PhotoBloc(photoRepository: PhotoRepository());
                  final photoState = photoBloc.state;
                  print("state-> ${photoState.status}");
                  if(photoState.status != PhotoStatus.success){
                    photoBloc.add(PhotoFetched(page: 0));
                  }
                  return photoBloc;
                },
                child: const PhotoListScreen(
                  title: Strings.homeScreenTitle,
                ),
              ),
        );
      case photoFullScreen:
        final arguments = settings.arguments as String;
        return CupertinoPageRoute(
            builder: (BuildContext context) =>
                PhotoFullScreen(
                  imageUrl: arguments,
                ));
      default:
        throw const RouteException('Route not found!');
    }
  }
}
