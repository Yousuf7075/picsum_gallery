import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picsum_gallery/data/repositories/photo_repository.dart';
import 'package:picsum_gallery/logic/bloc/photo_bloc.dart';
import 'package:picsum_gallery/presentation/screens/photo_list_screen/photo_list_screen.dart';

import '../../core/constants/strings.dart';
import '../../core/exceptions/route_exception.dart';

class AppRouter {
  static const String photoListScreen = '/';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case photoListScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => PhotoBloc(photoRepository: PhotoRepository())..add(PhotoFetched(page: 0)),
            child: const PhotoListScreen(
              title: Strings.homeScreenTitle,
            ),
          ),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}
