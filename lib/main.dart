import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get/get.dart';
import 'package:material_kit_flutter/screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(MaterialKitPROFlutter());
}

class MaterialKitPROFlutter extends StatefulWidget {
  @override
  _MaterialKitPROFlutterState createState() => _MaterialKitPROFlutterState();
}

class _MaterialKitPROFlutterState extends State<MaterialKitPROFlutter> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Whatsapp Status Saver",
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
