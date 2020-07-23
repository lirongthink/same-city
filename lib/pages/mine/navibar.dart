import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:same_city/utils/Screen.dart';
import 'package:same_city/utils/navigator_util.dart';

class MineNavibar extends StatelessWidget {
  
  MineNavibar(this.opacity);

  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: opacity,
          child: Container(
            padding: EdgeInsets.fromLTRB(5, Screen.statusBarHeight(context), 0, 0),
            height: Screen.navigationBarHeight(context),
            color: opacity == 0 ? Colors.transparent : Colors.yellow,
            child: Center(
              child: Text(
                "专卖小铺子",
                style: TextStyle(
                  color: opacity == 0 ? Colors.transparent : Colors.black,
                  fontSize: 17
                ),
              ),
            ),
          ),
        ),

        // Positioned(
        //   right: 0,
        //   child: Opacity(
        //     opacity: opacity,
        //     child: Container(
        //       margin: EdgeInsets.fromLTRB(5, Screen.statusBarHeight(context), 0, 0),
        //       child: IconButton(
        //         onPressed: () {
        //           NavigatorUtil.goLogin(context);
        //         },
        //         padding: EdgeInsets.all(0),
        //         icon: Icon(Icons.directions),
        //         iconSize: 30,
        //         color: Colors.black,
        //       ),
        //     )
        //   )
        // ),
      ],
    );
  }
}
