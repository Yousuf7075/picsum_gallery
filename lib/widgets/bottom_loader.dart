import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomLoader extends StatelessWidget {
  const BottomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(strokeWidth: 1.5),
      ),
    );
  }
}
