import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_status_saver/screens/home.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () => Get.off(() => Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        // border: Border.all(color: Colors.lightGreen[100]),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Colors.green[800],
            Colors.green[700],
            Colors.green[600],
            Colors.green[400],
          ],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 200.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Hero(
                tag: "assets/img/logo_wa.png",
                child: Image.asset(
                  'assets/img/logo_wa.png',
                  width: 200.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Center(
            child: Text(
              "Whatsapp Status Saver",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Text(
              "Initializing...",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 10.0,
                decoration: TextDecoration.none,
              ),
            ),
          )
        ],
      )),
    );
  }
}
