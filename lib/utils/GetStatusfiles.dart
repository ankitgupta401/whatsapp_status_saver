import 'dart:io';

import 'package:ext_storage/ext_storage.dart';

class GetStatusFiles {
  Future<Directory> getStatusURI() async {
    final Directory _photoDir =
        new Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');

    final Directory _photoDir2 = new Directory(
        await ExtStorage.getExternalStorageDirectory() +
            '/Android/media/com.whatsapp/WhatsApp/Media/.Statuses');
    print(_photoDir2.listSync(recursive: true).toList());
    if (Directory("${_photoDir.path}").existsSync()) {
      return _photoDir;
    } else {
      if (Directory("${_photoDir2.path}").existsSync()) {
        return _photoDir2;
      } else {
        print("returned null");
        return Directory("/");
      }
    }
  }

  // Future<void> copyDirectory(Directory source, Directory destination) async {
  //   await for (var entity in source.list(recursive: false)) {
  //     if (entity is Directory) {
  //       var newDirectory = Directory(
  //           p.join(destination.absolute.path, p.basename(entity.path)));
  //       await newDirectory.create();
  //       await copyDirectory(entity.absolute, newDirectory);
  //     } else if (entity is File) {
  //       await entity.copy(p.join(destination.path, p.basename(entity.path)));
  //     }
  //   }
  // }
}
