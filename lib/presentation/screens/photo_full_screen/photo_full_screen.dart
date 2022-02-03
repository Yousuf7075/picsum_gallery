import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';

class PhotoFullScreen extends StatelessWidget {
  const PhotoFullScreen({Key? key, required this.imageUrl}) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: InteractiveViewer(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Image.asset(
                  "assets/images/loading.gif",
                  fit: BoxFit.fitHeight,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 50,
            child: Container(
              height: 45,
              width: 45,
              decoration: const BoxDecoration(
                  color: Colors.blueGrey, shape: BoxShape.circle),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomButton(
                    btnName: 'Share',
                    iconData: Icons.share,
                    onTap: () {
                      Share.share(imageUrl);
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  CustomButton(
                    btnName: 'Set As Wallpaper',
                    iconData: Icons.download,
                    onTap: () {},
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.btnName,
    required this.iconData,
    required this.onTap,
  }) : super(key: key);

  final String btnName;
  final IconData iconData;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: IconButton(
            onPressed: onTap,
            icon: Icon(
              iconData,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          btnName,
          style: GoogleFonts.raleway(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
