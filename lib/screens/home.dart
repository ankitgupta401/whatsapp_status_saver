import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapp_status_saver/utils/GetStatusfiles.dart';
import 'package:whatsapp_status_saver/widgets/drawer.dart';

import 'package:whatsapp_status_saver/widgets/imagesList.dart';
import 'package:whatsapp_status_saver/widgets/videoList.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp_status_saver/constants/Theme.dart';

//widgets
import 'package:whatsapp_status_saver/widgets/navbar.dart';

class Home extends StatelessWidget {
  // final GlobalKey _scaffoldKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return PermissionsChecker();
  }
}

class PermissionsChecker extends StatefulWidget {
  const PermissionsChecker({Key key}) : super(key: key);

  @override
  _PermissionsCheckerState createState() => _PermissionsCheckerState();
}

class _PermissionsCheckerState extends State<PermissionsChecker> {
  int _storagePermissionCheck;
  Future<int> _storagePermissionChecker;
  Future<Directory> getDir;
  Future<int> checkStoragePermission() async {
    /// bool result = await
    /// SimplePermissions.checkPermission(Permission.ReadExternalStorage);
    final result = await Permission.storage.status;
    // final result2 = await Permission.manageExternalStorage.status;
    print('Checking Storage Permission ' + result.toString());
    setState(() {
      _storagePermissionCheck = 1;
    });
    if (result.isDenied
        // || result2.isDenied
        ) {
      await requestStoragePermission();
      setState(() {});
      return 1;
    } else if (result.isGranted) {
      return 1;
    } else {
      int res = 0;
      do {
        res = await requestStoragePermission();
      } while (res == 0);
      if (res == 1) {
        setState(() {});
        return 1;
      }
    }
  }

  Future<int> requestStoragePermission() async {
    final result = await [Permission.storage].request();

    setState(() {});
    if (result[Permission.storage].isDenied) {
      return 0;
    } else if (result[Permission.storage].isGranted) {
      return 1;
    } else {
      return 0;
    }
  }

  @override
  void initState() {
    super.initState();

    _storagePermissionChecker = (() async {
      int storagePermissionCheckInt;
      int finalPermission;

      print('Initial Values of $_storagePermissionCheck');
      if (_storagePermissionCheck == null || _storagePermissionCheck == 0) {
        _storagePermissionCheck = await checkStoragePermission();
      } else {
        _storagePermissionCheck = 1;
      }
      if (_storagePermissionCheck == 1) {
        storagePermissionCheckInt = 1;
      } else {
        storagePermissionCheckInt = 0;
      }

      if (storagePermissionCheckInt == 1) {
        finalPermission = 1;
      } else {
        finalPermission = 0;
      }

      return finalPermission;
    })();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MaterialColors.bgColorScreen,
      // key: _scaffoldKey,

      body: DefaultTabController(
        length: 2,
        child: FutureBuilder(
          future: _storagePermissionChecker,
          builder: (context, status) {
            if (status.connectionState == ConnectionState.done) {
              if (status.hasData) {
                if (status.data == 1) {
                  return MyApp();
                } else {
                  return Scaffold(
                    body: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Colors.lightBlue[100],
                          Colors.lightBlue[200],
                          Colors.lightBlue[300],
                          Colors.lightBlue[200],
                          Colors.lightBlue[100],
                        ],
                      )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              'Storage Permission Required',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                          MaterialButton(
                            padding: const EdgeInsets.all(15.0),
                            child: const Text(
                              'Allow Storage Permission',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            color: Colors.indigo,
                            textColor: Colors.white,
                            onPressed: () {
                              _storagePermissionChecker =
                                  requestStoragePermission();
                              setState(() {});
                            },
                          )
                        ],
                      ),
                    ),
                  );
                }
              } else {
                return Scaffold(
                  body: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Colors.lightBlue[100],
                        Colors.lightBlue[200],
                        Colors.lightBlue[300],
                        Colors.lightBlue[200],
                        Colors.lightBlue[100],
                      ],
                    )),
                    child: const Center(
                      child: Text(
                        '''
                        Something went wrong.. Please uninstall and Install Again.''',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                );
              }
            } else {
              return const Scaffold(
                body: SizedBox(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String ext = '.jpg';
  Directory dir = Directory("/");
  final PageController controller = PageController(initialPage: 0);
  String pageName = "WhatsApp Status Saver";
  void changeExt(ext) {
    print(ext);
    if (ext != this.ext) {
      setState(() {
        this.ext = ext;

        controller.jumpToPage(ext == '.jpg' ? 0 : 1);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // getDir();
    Map fil = GetStatusFiles().getPageName();
    print(fil);
    setState(() {
      dir = fil["dir"];
      pageName = fil["pageName"];
    });
  }

  getDir() async {
    Directory fil = await GetStatusFiles().getStatusURI(pageName);

    setState(() {
      dir = fil;
    });
  }

  changePage(page) {
    setState(() {
      pageName = page;
      getDir();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: pageName,
        categoryOne: "Photos",
        categoryTwo: "Videos",
        onCatChange: changeExt,
        photos: ext == '.jpg' ? true : false,
      ),
      drawer: MaterialDrawer(currentPage: pageName, changePage: changePage),
      backgroundColor: MaterialColors.bgColorScreen,
      // key: _scaffoldKey,

      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: controller,
        onPageChanged: (val) {
          if (val == 0) {
            changeExt('.jpg');
          } else {
            changeExt('.mp4');
          }
        },
        children: <Widget>[
          ImageSaverBody(photoDir: dir, pageName: pageName),
          VideoSaverBody(photoDir: dir, pageName: pageName)
        ],
      ),
    );
  }
}
