import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:material_kit_flutter/screens/imagePreview.dart';

class ImageSaverBody extends StatelessWidget {
  final Directory _photoDir =
      new Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');

  @override
  Widget build(BuildContext context) {
    if (!Directory("${_photoDir.path}").existsSync()) {
      return Container(
        padding: EdgeInsets.only(bottom: 60.0),
        child: Center(
          child: Text(
            "Install WhatsApp\nYour Friend's Status Will Show Here",
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      );
    } else {
      var imageList = _photoDir
          .listSync()
          .map((item) => item.path)
          .where((item) => item.endsWith('.jpg'))
          .toList(growable: false);
      if (imageList.length > 0) {
        return Container(
          padding: EdgeInsets.only(bottom: 00.0),
          child: StaggeredGridView.countBuilder(
            padding: EdgeInsets.all(8.0),
            itemCount: imageList.length,
            crossAxisCount: 4,
            itemBuilder: (context, index) {
              String imgPath = imageList[index];
              return Material(
                elevation: 8.0,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) =>
                                ImagePreview(imgPath: imgPath)));
                  },
                  child: Hero(
                    tag: imgPath,
                    child: Image.file(
                      File(imgPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
            staggeredTileBuilder: (i) =>
                StaggeredTile.count(2, i.isEven ? 2 : 3),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
        );
      } else {
        return Scaffold(
          body: Center(
            child: new Container(
                padding: EdgeInsets.only(bottom: 60.0),
                child: Text(
                  'No Image Found!',
                  style: TextStyle(fontSize: 18.0),
                )),
          ),
        );
      }
    }
  }
}
