import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
          padding: const EdgeInsets.all(5.0),
          scrollDirection: Axis.vertical,
          itemCount: 6,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 250,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8),
          itemBuilder: (BuildContext context, int index) {
            return const ImageItemShade();
          }),
    );
  }
}

class ImageItemShade extends StatelessWidget {
  const ImageItemShade({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 250,
      decoration: BoxDecoration(
          color: Colors.blueGrey[100],
          borderRadius: const BorderRadius.all(Radius.circular(10))),
    );
  }
}
