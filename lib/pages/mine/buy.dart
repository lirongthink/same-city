
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MineBuy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "我的地址",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16
                  )
                ),
                // SizedBox(
                //   width: 4,
                // ),
                // Text(
                //   "在闲鱼赚了1867.00元",
                //   style: TextStyle(
                //     color: Colors.grey,
                //     fontSize: 14
                //   )
                // ),
              ],
            ),
            
            SizedBox(
              height: 16,
            ),

            // grid 
            Container(
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '李荣想 1883207755',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(30),
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15.0,10.0,0,10.0),
                      // child:Container(
                      //   width: ScreenUtil().setWidth(470),
                      //   padding: EdgeInsets.all(10),
                        child:
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: ScreenUtil().setWidth(600),
                              child: Text(
                                '河北省唐山市路北区果园乡马驹桥村马驹桥天桥东马路边',
                                maxLines: 2,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: ScreenUtil().setSp(28)
                                ),
                              ),
                            ),
                          ]
                        )
                      // )
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
