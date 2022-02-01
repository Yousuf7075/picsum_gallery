
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picsum_gallery/logic/debug/app_bloc_observer.dart';

import 'core/constants/strings.dart';
import 'core/themes/app_theme.dart';
import 'presentation/router/app_router.dart';

void main() {
  BlocOverrides.runZoned(
        () => runApp(const PicsumGalleryApp()),
    blocObserver: AppBlocObserver(),
  );
}

class PicsumGalleryApp extends StatelessWidget {
  const PicsumGalleryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appTitle,
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouter.photoListScreen,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
