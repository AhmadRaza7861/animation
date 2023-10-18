import 'dart:typed_data';

import 'package:flutter/material.dart';
class GifScreen extends StatelessWidget {
  Uint8List gifBites;
   GifScreen({Key? key,required this.gifBites}) : super(key: key);
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.memory(gifBites)
        ],
      ),
    );
  }
}
