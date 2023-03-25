import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picsum_gallery/app.dart';
import 'package:picsum_gallery/app_bloc_observer.dart';
import 'package:picsum_gallery/http_overrides.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await di.init();
  Bloc.observer = AppBlocObserver();
  runApp(const PicsumGalleryApp());
}
