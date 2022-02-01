import 'package:flutter/material.dart';
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
          builder: (_) => PhotoListScreen(
            title: Strings.homeScreenTitle,
          ),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}
