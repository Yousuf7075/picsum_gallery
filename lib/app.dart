import 'package:flutter/material.dart';
import 'package:picsum_gallery/core/constants/strings.dart';
import 'package:picsum_gallery/core/router/app_router.dart';
import 'package:picsum_gallery/core/themes/app_theme.dart';

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
