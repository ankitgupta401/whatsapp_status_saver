import 'package:flutter/material.dart';

// screens
import 'package:material_kit_flutter/screens/home.dart';

void main() => runApp(MaterialKitPROFlutter());

class MaterialKitPROFlutter extends StatefulWidget {
  @override
  _MaterialKitPROFlutterState createState() => _MaterialKitPROFlutterState();
}

class _MaterialKitPROFlutterState extends State<MaterialKitPROFlutter> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Whatsapp Status Saver",
        debugShowCheckedModeBanner: false,
        initialRoute: "/home",
        routes: <String, WidgetBuilder>{
          "/home": (BuildContext context) => new Home(),
        });
  }
}
