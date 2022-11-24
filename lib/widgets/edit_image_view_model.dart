import 'dart:typed_data';

import 'package:editpoto/models/text_info.dart';
import 'package:editpoto/screens/image_screen.dart';
import 'package:editpoto/utils/utils.dart';
import 'package:editpoto/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

//untuk fungsi edit foto membuat abstract class dan extends ke stf edit image
abstract class EditImageViewModel extends State<ImageScreen> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController creatorText = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();
  List<TextInfo> texts = [];
  int currentIndex = 0;
  //fungsi save to gallery
  saveToGalerry(BuildContext context) {
    if (texts.isNotEmpty) {
      screenshotController.capture().then((Uint8List? image) {
        saveImage(image!);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          "picture saved",
          style: TextStyle(fontSize: 16.0),
        )));
      }).catchError((err) => print(err));
    }
  }

  //fyungsi request akses to gallery and save image
  saveImage(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = "screenshot_$time";
    await requestPermission(Permission.storage);
    await ImageGallerySaver.saveImage(bytes, name: name);
  }

  //fungsi menghilangkan text sesuai index
  removeText(BuildContext context) {
    setState(() {
      texts.removeAt(currentIndex);
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
      "Remove text",
      style: TextStyle(fontSize: 16.0),
    )));
  }

  //untuk get current text yang dipilih
  setCurrentIndex(BuildContext context, index) {
    setState(() {
      currentIndex = index;
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
      "Select for styling",
      style: TextStyle(fontSize: 16.0),
    )));
  }

  //fungsi change color text sesuai index teks yang dipilih
  changeTextColor(Color color) {
    setState(() {
      texts[currentIndex].color = color;
    });
  }

  //fungsi tambah font size
  increaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize = texts[currentIndex].fontSize += 2;
    });
  }

//fungsi kurang font size
  decreaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize = texts[currentIndex].fontSize -= 2;
    });
  }

  alignleft() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.left;
    });
  }

  aligncenter() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.center;
    });
  }

  alignright() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.right;
    });
  }

//fungsi bold text
  boldText() {
    setState(() {
      if (texts[currentIndex].fontWeight == FontWeight.normal) {
        texts[currentIndex].fontWeight = FontWeight.bold;
      } else {
        texts[currentIndex].fontWeight = FontWeight.normal;
      }
    });
  }

  //fungsi italic text
  italicText() {
    setState(() {
      if (texts[currentIndex].fontStyle == FontStyle.normal) {
        texts[currentIndex].fontStyle = FontStyle.italic;
      } else {
        texts[currentIndex].fontStyle = FontStyle.normal;
      }
    });
  }

  //fungsi menghilangkan spasi atau paragraf baru
  addLinesToText() {
    setState(() {
      if (texts[currentIndex].text.contains('\n')) {
        texts[currentIndex].text =
            texts[currentIndex].text.replaceAll('\n', ' ');
      } else {
        texts[currentIndex].text =
            texts[currentIndex].text.replaceAll(' ', '\n');
      }
    });
  }

  //inisial fungsi untuk add text di gambar
  addNewText(BuildContext context) {
    setState(() {
      texts.add(TextInfo(
          text: textEditingController.text,
          top: 0,
          left: 0,
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          fontSize: 20,
          textAlign: TextAlign.left));
    });
    Navigator.of(context).pop();
  }

  addNewDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Add New Text"),
        content: TextField(
          controller: textEditingController,
          maxLines: 5,
          decoration: const InputDecoration(
              suffixIcon: Icon(Icons.edit),
              filled: true,
              hintText: "YOur Text Here"),
        ),
        actions: <Widget>[
          DefaultButton(
              onPressed: () => Navigator.of(context).pop(),
              color: Colors.white,
              textColor: Colors.black,
              child: const Text("Back")),
          DefaultButton(
              onPressed: () => addNewText(context),
              color: Colors.red,
              textColor: Colors.white,
              child: const Text("Add Text"))
        ],
      ),
    );
  }
}
