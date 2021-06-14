import 'dart:io';
import 'package:flutter/material.dart';
import 'package:material_kit_flutter/constants/Theme.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreview extends StatelessWidget {
  ImagePreview({this.imgPath});
  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 10,
            child: Container(
              child: PhotoView.customChild(
                heroAttributes: PhotoViewHeroAttributes(tag: imgPath),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.file(
                        File(imgPath),
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                ),
                initialScale: 1.0,
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          SizedBox(
                            width: 40.0,
                          ),
                          Icon(Icons.save),
                          Text(" Save")
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: MaterialColors.caption,
                    height: 25,
                    width: 0.3,
                  ),
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          SizedBox(
                            width: 40.0,
                          ),
                          Icon(Icons.share),
                          Text(" Share")
                        ],
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
