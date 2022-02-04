import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:picsum_gallery/logic/debug/app_bloc_observer.dart';
import 'core/constants/strings.dart';
import 'core/themes/app_theme.dart';
import 'presentation/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  HydratedBlocOverrides.runZoned(
      () => runApp(const PicsumGalleryApp()),
      blocObserver: AppBlocObserver(),
      storage: storage);
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
