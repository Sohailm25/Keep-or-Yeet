import 'dart:async';
import 'dart:io';
import 'dart:math';
//import 'package:menu_test/RecyclePage/notrecycleable.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NotNetworkingPageHeader implements SliverPersistentHeaderDelegate {
  NotNetworkingPageHeader({
    this.minExtent,
    @required this.maxExtent,
    this.imageF,
  });
  final double minExtent;
  final double maxExtent;
  //final Future<File> image;
  final File imageF;

  @override
  Widget build(
    BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        //Image.file(
        //showImage(image),
        show(imageF),
        //fit: BoxFit.cover,
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black54],
              stops: [0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.repeated,
            ),
          ),
        ),
        Positioned(
            //top:310,
            left: -5,
            right: -5,
            bottom: -24.0,
            child: SizedBox(
                height: 130,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 11, 0, 0), //remove
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27.0),
                    ),
                    color: Colors.white,
                    elevation: 10,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          leading: Icon(Icons.cancel,
                              size: 55, color: Colors.red),
                          title: Text('Not Recycleable!',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 36.0,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ))
            ),
      ],
    );
  }

  double titleOpacity(double shrinkOffset) {
    // simple formula: fade out text as soon as shrinkOffset > 0
    return 1.0 - max(0.0, shrinkOffset) / maxExtent;
    // more complex formula: starts fading out text when shrinkOffset > minExtent
    //return 1.0 - max(0.0, (shrinkOffset - minExtent)) / (maxExtent - minExtent);
  }
  Widget show(File imageF)
  {
    return Image.file(imageF,
    fit:BoxFit.cover,
    //alignment: Alignment.topCenter,
    
    );
  }
  Widget showImage(Future<File> imageF) {
    return FutureBuilder<File>(
      future: imageF,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(
            snapshot.data,
            //width: BoxFit.contain,
            fit: BoxFit.fitWidth,
          );
        } else if (snapshot.error != null) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  //  implement stretchConfiguration
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;
}