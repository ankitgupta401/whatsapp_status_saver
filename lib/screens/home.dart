import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapp_status_saver/utils/GetStatusfiles.dart';

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
    /// PermissionStatus result = await
    /// SimplePermissions.requestPermission(Permission.ReadExternalStorage);
    final result = await [Permission.storage].request();
    // final result2 = await [Permission.accessMediaLocation].request();
    // final result2 = await [Permission.manageExternalStorage].request();
    // print(result2);
    // print(result3);
    setState(() {});
    if (result[Permission.storage].isDenied
        // ||    result2[Permission.accessMediaLocation].isDenied
        ) {
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
  void changeExt(ext) {
    print(ext);
    if (ext != this.ext) {
      setState(() {
        this.ext = ext;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getDir();
  }

  getDir() async {
    Directory fil = await GetStatusFiles().getStatusURI();

    setState(() {
      dir = fil;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
          title: "Whatsapp Status Saver",
          categoryOne: "Photos",
          categoryTwo: "Videos",
          onCatChange: changeExt),
      backgroundColor: MaterialColors.bgColorScreen,
      // key: _scaffoldKey,

      body: CheckAndRender(ext: ext, dir: dir),
    );
  }
}

class CheckAndRender extends StatelessWidget {
  CheckAndRender({this.ext, this.dir});
  final ext;
  final dir;
  @override
  Widget build(BuildContext context) {
    if (ext == '.jpg')
      return ImageSaverBody(photoDir: dir);
    else
      return VideoSaverBody(photoDir: dir);
  }
}
