import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picsum_gallery/logic/bloc/photo_bloc.dart';

class PhotoListScreen extends StatelessWidget {
  const PhotoListScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocBuilder<PhotoBloc, PhotoState>(
        builder: (context, state) {
          switch (state.status) {
            case PostStatus.initial:
              return const SizedBox();
            case PostStatus.loading:
              return const SizedBox();
            case PostStatus.success:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      state.photos.length.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
              );
            case PostStatus.failure:
              return const Text('something went wrong!');
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
