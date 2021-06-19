import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

import 'package:material_kit_flutter/constants/Theme.dart';
import 'package:material_kit_flutter/screens/videoStatus.dart';

import 'package:video_player/video_player.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class VideoPreview extends StatefulWidget {
  const VideoPreview({this.imgPath});
  final imgPath;
  @override
  _VideoPreviewState createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  @override
  void initState() {
    super.initState();
    print('Video file you are looking for:' + widget.imgPath);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onLoading(bool t, String str) {
    if (t) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return SimpleDialog(
              children: <Widget>[
                Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            );
          });
    } else {
      Navigator.pop(context);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SimpleDialog(
                children: <Widget>[
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: <Widget>[
                          const Text(
                            'Great, Saved in Gallary',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                          Text(str,
                              style: const TextStyle(
                                fontSize: 16.0,
                              )),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                          MaterialButton(
                            child: const Text('Close'),
                            color: Colors.teal,
                            textColor: Colors.white,
                            onPressed: () => Navigator.pop(context),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
    }
  }

  _save() async {
    _onLoading(true, '');

    GallerySaver.saveVideo(widget.imgPath, albumName: 'StatusSaver')
        .then((bool success) {
      _onLoading(
        false,
        'Video Saved',
      );
    });
  }

  _share() async {
    _onLoading(true, '');
    final myUri = Uri.parse(widget.imgPath);
    final originalImageFile = File.fromUri(myUri);
    Uint8List bytes;
    await originalImageFile.readAsBytes().then((value) {
      bytes = Uint8List.fromList(value);
      print('reading of bytes is completed');
    }).catchError((onError) {
      print('Exception Error while reading audio from path:' +
          onError.toString());
    });
    Navigator.pop(context);
    await WcFlutterShare.share(
        sharePopupTitle: 'share',
        fileName: 'share.mp4',
        mimeType: 'video/mp4',
        bytesOfFile: bytes.buffer.asUint8List());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 10,
            child: Container(
              child: StatusVideo(
                videoPlayerController:
                    VideoPlayerController.file(File(widget.imgPath)),
                looping: true,
                videoSrc: widget.imgPath,
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: MaterialButton(
                        onPressed: _save,
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
                        onPressed: _share,
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
                ),
              ))
        ],
      ),
    );
  }
}
