import 'dart:io';

class GetStatusFiles {
  final Directory _photoDir =
      new Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');
  final Directory _photoDir2 = new Directory(
      '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses');

  Directory getStatusURI() {
    if (!Directory("${_photoDir.path}").existsSync()) {
      return _photoDir2;
    } else {
      if (!Directory("${_photoDir2.path}").existsSync()) {
        return _photoDir;
      } else {
        return null;
      }
    }
  }
}
