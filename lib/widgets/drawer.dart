import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:whatsapp_status_saver/constants/Theme.dart';

import 'package:whatsapp_status_saver/widgets/drawer-tile.dart';

class MaterialDrawer extends StatelessWidget {
  final String currentPage;
  final Function changePage;
  MaterialDrawer({this.currentPage, this.changePage});

  @override
  Widget build(BuildContext context) {
    const PAGE_WA_SAVER = "WhatsApp Status Saver";
    const PAGE_WAB_SAVER = "WhatsApp Business Saver";
    const PAGE_GBWA_SAVER = "GB WhatsApp Saver";
    const MORE = "More Apps";
    return Drawer(
      child: Container(
          child: Column(children: [
        DrawerHeader(
            decoration: BoxDecoration(color: Colors.green),
            child: Container(
                // padding: EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: Image.asset(
                    "assets/img/logo_wa.png",
                    width: 60.0,
                  ).image,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
                  child: Text("WhatsApp Status Saver",
                      style: TextStyle(color: Colors.white, fontSize: 21)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: MaterialColors.label),
                            child: Text("v2.0",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16))),
                      ),
                    ],
                  ),
                )
              ],
            ))),
        Expanded(
            child: ListView(
          padding: EdgeInsets.only(top: 8, left: 8, right: 8),
          children: [
            DrawerTile(
                icon: Icons.chat_bubble,
                onTap: () {
                  if (currentPage != PAGE_WA_SAVER) changePage(PAGE_WA_SAVER);
                  Navigator.pop(context);
                },
                iconColor: Colors.black,
                title: PAGE_WA_SAVER,
                isSelected: currentPage == PAGE_WA_SAVER ? true : false),
            DrawerTile(
                icon: Icons.business_center,
                onTap: () {
                  if (currentPage != PAGE_WAB_SAVER) changePage(PAGE_WAB_SAVER);
                  Navigator.pop(context);
                },
                iconColor: Colors.black,
                title: PAGE_WAB_SAVER,
                isSelected: currentPage == PAGE_WAB_SAVER ? true : false),
            DrawerTile(
                icon: Icons.devices_other_outlined,
                onTap: () {
                  if (currentPage != PAGE_GBWA_SAVER)
                    changePage(PAGE_GBWA_SAVER);
                  Navigator.pop(context);
                },
                iconColor: Colors.black,
                title: PAGE_GBWA_SAVER,
                isSelected: currentPage == PAGE_GBWA_SAVER ? true : false),
            DrawerTile(
              icon: Icons.apps,
              onTap: () {
                launch(
                    "https://play.google.com/store/apps/dev?id=7867635880502827075");
                Navigator.pop(context);
              },
              iconColor: Colors.black,
              title: MORE,
            ),
          ],
        ))
      ])),
    );
  }
}
