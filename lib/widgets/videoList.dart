import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:material_kit_flutter/screens/videoPreview.dart';
import 'package:thumbnails/thumbnails.dart';

class VideoSaverBody extends StatelessWidget {
  final Directory _photoDir =
      new Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');
  Future<String> _getImage(videoPathUrl) async {
    //await Future.delayed(Duration(milliseconds: 500));
    final thumb = await Thumbnails.getThumbnail(
        videoFile: videoPathUrl,
        imageType:
            ThumbFormat.PNG, //this image will store in created folderpath
        quality: 10);

    return thumb;
  }

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
      var videoList = _photoDir
          .listSync()
          .map((item) => item.path)
          .where((item) => item.endsWith('.mp4'))
          .toList(growable: false);
      if (videoList.length > 0) {
        return Container(
          padding: EdgeInsets.only(bottom: 00.0),
          child: StaggeredGridView.countBuilder(
            padding: EdgeInsets.all(8.0),
            itemCount: videoList.length,
            crossAxisCount: 4,
            itemBuilder: (context, index) {
              return Material(
                elevation: 8.0,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) =>
                                VideoPreview(imgPath: videoList[index])));
                  },
                  child: FutureBuilder(
                      future: _getImage(videoList[index]),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            return Hero(
                              tag: videoList[index],
                              child: Image.file(
                                File(snapshot.data),
                                fit: BoxFit.cover,
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        } else {
                          return Hero(
                            tag: videoList[index],
                            child: SizedBox(
                              height: 280.0,
                              child: Image.asset('assets/img/loader.gif'),
                            ),
                          );
                        }
                      }),
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
                  'No Video Found!',
                  style: TextStyle(fontSize: 18.0),
                )),
          ),
        );
      }
    }
  }
}
