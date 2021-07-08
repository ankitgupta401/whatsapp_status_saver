import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
// import 'package:material_kit_flutter/constants/Theme.dart';

// import 'package:material_kit_flutter/screens/categories.dart';
// import 'package:material_kit_flutter/screens/best-deals.dart';
// import 'package:material_kit_flutter/screens/search.dart';
// import 'package:material_kit_flutter/screens/cart.dart';
// import 'package:material_kit_flutter/screens/chat.dart';

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String categoryOne;
  final String categoryTwo;
  final bool searchBar;
  final bool backButton;
  final bool transparent;
  final bool rightOptions;
  final List<String> tags;
  final Function getCurrentPage;
  final bool isOnSearch;
  final TextEditingController searchController;
  final Function searchOnChanged;
  final bool searchAutofocus;
  final bool noShadow;
  final Color bgColor;
  final Function onCatChange;
  final bool photos;
  Navbar(
      {this.title = "Home",
      this.categoryOne = "",
      this.categoryTwo = "",
      this.tags,
      this.transparent = false,
      this.rightOptions = true,
      this.getCurrentPage,
      this.searchController,
      this.isOnSearch = false,
      this.searchOnChanged,
      this.searchAutofocus = false,
      this.backButton = false,
      this.noShadow = false,
      this.bgColor = Colors.white,
      this.searchBar = false,
      this.onCatChange,
      this.photos});

  final double _prefferedHeight = 180.0;

  @override
  _NavbarState createState() => _NavbarState();

  @override
  Size get preferredSize => Size.fromHeight(_prefferedHeight);
}

class _NavbarState extends State<Navbar> {
  String activeTag;

  // ItemScrollController _scrollController = ItemScrollController();

  void initState() {
    if (widget.tags != null && widget.tags.length != 0) {
      activeTag = widget.tags[0];
    }

    super.initState();
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    file.createSync(recursive: true);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  @override
  Widget build(BuildContext context) {
    final bool categories =
        widget.categoryOne.isNotEmpty && widget.categoryTwo.isNotEmpty;
    final bool tagsExist =
        widget.tags == null ? false : (widget.tags.length == 0 ? false : true);

    return Container(
        height: widget.searchBar
            ? (!categories
                ? (tagsExist ? 211.0 : 178.0)
                : (tagsExist ? 262.0 : 210.0))
            : (!categories
                ? (tagsExist ? 132.0 : 102.0)
                : (tagsExist ? 200.0 : 150.0)),
        decoration: BoxDecoration(
            color: !widget.transparent ? widget.bgColor : Colors.transparent,
            boxShadow: [
              BoxShadow(
                  color: !widget.transparent && !widget.noShadow
                      ? Colors.black.withOpacity(0.6)
                      : Colors.transparent,
                  spreadRadius: -10,
                  blurRadius: 12,
                  offset: Offset(0, 5))
            ]),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(
                          !widget.backButton
                              ? Icons.menu
                              : Icons.arrow_back_ios,
                          color: !widget.transparent
                              ? (widget.bgColor == Colors.white
                                  ? Colors.black
                                  : Colors.white)
                              : Colors.white,
                          size: 24.0),
                      onPressed: () {
                        if (!widget.backButton)
                          Scaffold.of(context).openDrawer();
                        else
                          Navigator.pop(context);
                      }),
                  Row(
                    children: [
                      Hero(
                        tag: "assets/img/logo_wa.png",
                        child: Image.asset(
                          "assets/img/logo_wa.png",
                          width: 60.0,
                        ),
                      ),
                      Text(widget.title,
                          style: TextStyle(
                              color: !widget.transparent
                                  ? (widget.bgColor == Colors.white
                                      ? Colors.black
                                      : Colors.white)
                                  : Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0)),
                    ],
                  ),
                  if (widget.rightOptions)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final originalImageFile =
                                await getImageFileFromAssets('img/share.png');
                            Uint8List bytes;
                            await originalImageFile.readAsBytes().then((value) {
                              bytes = Uint8List.fromList(value);
                              print('reading of bytes is completed');
                            }).catchError((onError) {
                              print(
                                  'Exception Error while reading audio from path:' +
                                      onError.toString());
                            });
                            // Navigator.pop(context);
                            await WcFlutterShare.share(
                                sharePopupTitle: 'share',
                                text:
                                    'WhatsApp Status Saver App Lets You Save Image And Video Status From Your WhatsApp Directly To Your Phone\'s Gallery! \n\nFeatures:\nThis App Lets You Save: \n1. WhatsApp Status \n2. WhatsApp Business Status \n3. GBWhatsApp Status \n\nAvailable On Google Play! \nDownload Now 👇 \nhttps://play.google.com/store/apps/details?id=com.Ankitist.whatsapp_status_saver',
                                fileName: 'share.png',
                                mimeType: 'image/png',
                                bytesOfFile: bytes.buffer.asUint8List());
                          },
                          child: IconButton(
                              icon: Icon(Icons.share,
                                  color: !widget.transparent
                                      ? (widget.bgColor == Colors.white
                                          ? Colors.black
                                          : Colors.white)
                                      : Colors.white,
                                  size: 22.0),
                              onPressed: null),
                        ),
                      ],
                    )
                ],
              ),
              // if (widget.searchBar)
              // Padding(
              //   padding: const EdgeInsets.only(
              //       top: 8, bottom: 4, left: 15, right: 15),
              // child: Input(
              //     placeholder: "What are you looking for?",
              //     controller: widget.searchController,
              //     onChanged: widget.searchOnChanged,
              //     autofocus: widget.searchAutofocus,
              //     outlineBorder: true,
              //     enabledBorderColor: Colors.black.withOpacity(0.2),
              //     focusedBorderColor: MaterialColors.muted,
              //     suffixIcon:
              //         Icon(Icons.zoom_in, color: MaterialColors.muted),
              //     onTap: () {
              //       // if (!widget.isOnSearch)
              //       // Navigator.push(
              //       //     context,
              //       //     MaterialPageRoute(
              //       //         builder: (context) => Search()));
              //     }),
              // ),
              SizedBox(
                height: tagsExist ? 0 : 8,
              ),
              if (categories)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          widget.onCatChange('.jpg');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: widget.photos ? Colors.green : Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(1.0, 0.0), //(x,y)
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          padding: EdgeInsets.only(bottom: 13.5, top: 13.5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.photo,
                                  color: Colors.black87, size: 25.0),
                              SizedBox(width: 10),
                              Text(widget.categoryOne,
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 16.0)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //   color: MaterialColors.muted,
                    //   height: 25,
                    //   width: 0.3,
                    // ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          widget.onCatChange('.mp4');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: !widget.photos ? Colors.green : Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(1.0, 0.0), //(x,y)
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          padding: EdgeInsets.only(bottom: 13.5, top: 13.5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.video_call,
                                  color: Colors.black87, size: 25.0),
                              SizedBox(width: 10),
                              Text(widget.categoryTwo,
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 16.0)),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              // if (tagsExist)
              //   Container(
              //     height: 40,
              //     child: ScrollablePositionedList.builder(
              //       itemScrollController: _scrollController,
              //       scrollDirection: Axis.horizontal,
              //       itemCount: widget.tags.length,
              //       itemBuilder: (BuildContext context, int index) {
              //         return GestureDetector(
              //           onTap: () {
              //             if (activeTag != widget.tags[index]) {
              //               setState(() => activeTag = widget.tags[index]);
              //               _scrollController.scrollTo(
              //                   index: index == widget.tags.length - 1 ? 1 : 0,
              //                   duration: Duration(milliseconds: 420),
              //                   curve: Curves.easeIn);
              //               if (widget.getCurrentPage != null)
              //                 widget.getCurrentPage(activeTag);
              //             }
              //           },
              //           child: Container(
              //               margin: EdgeInsets.only(
              //                   left: index == 0 ? 46 : 8, right: 8),
              //               padding: EdgeInsets.only(left: 20, right: 20),
              //               decoration: BoxDecoration(
              //                   border: Border(
              //                       bottom: BorderSide(
              //                           width: 2.0,
              //                           color: activeTag == widget.tags[index]
              //                               ? MaterialColors.primary
              //                               : Colors.transparent))),
              //               child: Center(
              //                 child: Text(widget.tags[index],
              //                     style: TextStyle(
              //                         color: activeTag == widget.tags[index]
              //                             ? MaterialColors.primary
              //                             : MaterialColors.placeholder,
              //                         fontWeight: FontWeight.w500,
              //                         fontSize: 14.0)),
              //               )),
              //         );
              //       },
              //     ),
              //   )
            ],
          ),
        ));
  }
}
