import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:picsum_gallery/logic/bloc/photo_bloc.dart';
import 'package:picsum_gallery/presentation/screens/photo_list_screen/widgets/photo_list_widget.dart';
import 'package:picsum_gallery/presentation/screens/photo_list_screen/widgets/shimmer_loader.dart';
import 'package:picsum_gallery/presentation/widgets/bottom_loader.dart';

class PhotoListScreen extends StatefulWidget {
  const PhotoListScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<PhotoListScreen> createState() => _PhotoListScreenState();
}

class _PhotoListScreenState extends State<PhotoListScreen> {
  int page = 0;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          widget.title,
          style: GoogleFonts.raleway(
            color: Colors.black
          )
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<PhotoBloc, PhotoState>(
        builder: (context, state) {
          switch (state.status) {
            case PhotoStatus.initial:
              return const ShimmerLoader();
            case PhotoStatus.loading:
              return const SizedBox();
            case PhotoStatus.success:
              return GridView.builder(
                padding: const EdgeInsets.all(5.0),
                  controller: _scrollController,
                  scrollDirection: Axis.vertical,
                  itemCount: state.hasReachedMax
                      ? state.photos.length
                      : state.photos.length + 1,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 250,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8),
                  itemBuilder: (BuildContext context, int index) {
                    return (index >= state.photos.length)
                        ? const BottomLoader()
                        : PhotoItem(
                            photo: state.photos[index],
                          );
                  });
            case PhotoStatus.failure:
              return const Text('something went wrong!');
            default:
              return const ShimmerLoader();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll == currentScroll) {
      page = page + 1;
      context.read<PhotoBloc>().add(PhotoFetched(page: page));
    }
  }
}
