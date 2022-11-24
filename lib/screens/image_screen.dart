import 'dart:io';

import 'package:editpoto/widgets/edit_image_view_model.dart';
import 'package:editpoto/widgets/image_text.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class ImageScreen extends StatefulWidget {
  final String imageScreen;
  const ImageScreen({Key? key, required this.imageScreen}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends EditImageViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      //fungsi screenshot akan mengambil gambar sesuai dengan child yang ada didalmnya dan
      //sesuai ukuran width dan height dari child tersebut
      body: Screenshot(
        controller: screenshotController,
        child: SafeArea(
            child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Stack(
            children: [
              _selectedImage,
              for (int i = 0; i < texts.length; i++)
                Positioned(
                  left: texts[i].left,
                  top: texts[i].top,
                  child: GestureDetector(
                    onLongPress: () {
                      setState(() {
                        currentIndex = i;
                        removeText(context);
                      });
                    },
                    onTap: () => setCurrentIndex(context, i),
                    //fungsi untuk drag text di gambar
                    child: Draggable(
                      //imagetext widget untuk dekalarasi text dalam gambar
                      feedback: ImageText(textInfo: texts[i]),
                      child: ImageText(textInfo: texts[i]),
                      onDragEnd: (drag) {
                        final renderBox =
                            context.findRenderObject() as RenderBox;
                        //fungsi dari global to local yaitu mengubah koordinat yang bersifat global
                        //menjadi koordinat lokal box
                        Offset offset = renderBox.globalToLocal(drag.offset);
                        setState(() {
                          texts[i].top = offset.dy - 96;
                          texts[i].left = offset.dx;
                        });
                      },
                    ),
                  ),
                ),
              creatorText.text.isNotEmpty
                  ? Positioned(
                      left: 0,
                      bottom: 0,
                      child: Text(
                        creatorText.text,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.3)),
                      ))
                  : const SizedBox.shrink()
            ],
          ),
        )),
      ),
      floatingActionButton: _addnewTextFAB,
    );
  }

  AppBar get _appBar => AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              IconButton(
                  onPressed: () => saveToGalerry(context),
                  tooltip: 'save image',
                  icon: const Icon(
                    Icons.save,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: increaseFontSize,
                  tooltip: 'Increase font size',
                  icon: const Icon(
                    Icons.add,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: decreaseFontSize,
                  tooltip: 'decrease font size',
                  icon: const Icon(
                    Icons.remove,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: alignleft,
                  tooltip: 'Align left',
                  icon: const Icon(
                    Icons.format_align_left,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: aligncenter,
                  tooltip: 'Align Center',
                  icon: const Icon(
                    Icons.format_align_center,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: alignright,
                  tooltip: 'Align Right',
                  icon: const Icon(
                    Icons.format_align_right,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: boldText,
                  tooltip: 'Bold',
                  icon: const Icon(
                    Icons.format_bold,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: italicText,
                  tooltip: 'itallic',
                  icon: const Icon(
                    Icons.format_italic,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: addLinesToText,
                  tooltip: 'add new line image',
                  icon: const Icon(
                    Icons.space_bar,
                    color: Colors.black,
                  )),
              Tooltip(
                message: 'Red',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.red),
                  child: const CircleAvatar(
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: 'White',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.white),
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: 'Black',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.black),
                  child: const CircleAvatar(
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: 'Blue',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.blue),
                  child: const CircleAvatar(
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: 'yellow',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.yellow),
                  child: const CircleAvatar(
                    backgroundColor: Colors.yellow,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: 'green',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.green),
                  child: const CircleAvatar(
                    backgroundColor: Colors.green,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: 'orange',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.orange),
                  child: const CircleAvatar(
                    backgroundColor: Colors.orange,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Tooltip(
                message: 'pink',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.pink),
                  child: const CircleAvatar(
                    backgroundColor: Colors.pink,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
      );
  //widget get gambar
  Widget get _selectedImage => Center(
        child: Image.file(
          File(widget.imageScreen),
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
        ),
      );
      
  Widget get _addnewTextFAB => FloatingActionButton(
        onPressed: () => addNewDialog(context),
        backgroundColor: Colors.white,
        tooltip: "Add New Text",
        child: const Icon(Icons.edit, color: Colors.black),
      );
}
