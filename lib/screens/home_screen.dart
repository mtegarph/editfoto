// ignore_for_file: use_build_context_synchronously

import 'package:editpoto/screens/image_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: IconButton(
                onPressed: () async {
                  //fungsi get gambar via gallery
                  XFile? data = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (data != null) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ImageScreen(imageScreen: data.path),
                    ));
                  } else {}
                },
                icon: const Icon(Icons.upload_file)),
          ),
          Center(
            child: IconButton(
                onPressed: () async {
                  //fungsi get gambar via gallery
                  XFile? data = await ImagePicker()
                      .pickImage(source: ImageSource.camera);
                  if (data != null) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ImageScreen(imageScreen: data.path),
                    ));
                  } else {}
                },
                icon: const Icon(Icons.camera)),
          ),
        ],
      ),
    );
  }
}
