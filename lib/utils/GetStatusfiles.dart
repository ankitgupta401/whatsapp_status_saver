import 'dart:io';

Map<String, String> pages = {
  "wa_normal": '/storage/emulated/0/WhatsApp/Media/.Statuses',
  "wa_normal_10":
      '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses',
  "wab_normal": '/storage/emulated/0/WhatsApp Business/Media/.Statuses',
  "wab_normal_10":
      '/storage/emulated/0/Android/media/com.whatsapp.w4b/WhatsApp Business/Media/.Statuses',
  "gwa_normal": '/storage/emulated/0/GBWhatsApp/Media/.Statuses',
  "gwa_normal_10":
      '/storage/emulated/0/Android/media/com.gbwhatsapp/GBWhatsApp/Media/.Statuses',
};

const PAGE_WA_SAVER = "WhatsApp Status Saver";
const PAGE_WAB_SAVER = "WhatsApp Business Saver";
const PAGE_GBWA_SAVER = "GB WhatsApp Saver";

class GetStatusFiles {
  Future<Directory> getStatusURI(String name) async {
    Directory _photoDir;
    Directory _photoDir2;
    if (name == PAGE_WA_SAVER) {
      _photoDir = new Directory(pages["wa_normal"]);
      _photoDir2 = new Directory(pages["wa_normal_10"]);
    } else if (name == PAGE_WAB_SAVER) {
      _photoDir = new Directory(pages["wab_normal"]);
      _photoDir2 = new Directory(pages["wab_normal_10"]);
    } else if (name == PAGE_GBWA_SAVER) {
      _photoDir = new Directory(pages["gwa_normal"]);
      _photoDir2 = new Directory(pages["gwa_normal_10"]);
    }
    print(_photoDir.path);
    if (Directory("${_photoDir.path}").existsSync()) {
      return _photoDir;
    } else {
      if (Directory("${_photoDir2.path}").existsSync()) {
        return _photoDir2;
      } else {
        print("returned null");
        return null;
      }
    }
  }

  Map<String, dynamic> getPageName() {
    String pageName = PAGE_WA_SAVER;
    Directory dir = new Directory(pages["wa_normal"]);
    for (String items in pages.values) {
      print(items);
      if (Directory(items).existsSync()) {
        dir = new Directory(items);
        if (items == pages["wa_normal"] || items == pages["wa_normal_10"]) {
          pageName = PAGE_WA_SAVER;
        } else if (items == pages["wab_normal"] ||
            items == pages["wab_normal_10"]) {
          pageName = PAGE_WAB_SAVER;
        } else if (items == pages["gwa_normal"] ||
            items == pages["gwa_normal_10"]) {
          pageName = PAGE_GBWA_SAVER;
        }
        break;
      }
    }
    return {"pageName": pageName, "dir": dir};
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
