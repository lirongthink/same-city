
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:same_city/utils/navigator_util.dart';


class MineSell extends StatelessWidget {
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "我的成就",
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
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              shrinkWrap: true,
              childAspectRatio: 1.6,
              padding: EdgeInsets.all(0),
              children: <Widget>[
                Column(
                  children: <Widget>[
                    IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: Icon(Icons.local_mall),
                      onPressed: (){
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '我发布的',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 9
                      )
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: Icon(Icons.monetization_on),
                      onPressed: (){
                        NavigatorUtil.goOrderListBuyPage(context);
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '我买到的',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 9
                      )
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: Icon(Icons.shopping_cart),
                      onPressed: (){
                        NavigatorUtil.goOrderListPage(context);
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '我卖出的',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 9
                      )
                    )
                  ],
                )
              ],
            ),

            // tip 
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            //   decoration: BoxDecoration(
            //     color: Colors.blue[50],
            //     borderRadius: BorderRadius.circular(10)
            //   ),
            //   child: Row(
            //     children: <Widget>[
            //       Container(
            //         width: 30,
            //         height: 30,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(4),
            //           color: Colors.blue[200],
            //           image: DecorationImage(
            //             image: CachedNetworkImageProvider("https://cataas.com/cat"),
            //             fit: BoxFit.cover
            //           )
            //         ),
            //       ),

            //       SizedBox(
            //         width: 8,
            //       ),

            //       Expanded(
            //         child: Text(
            //           "卖家已发货",
            //           style: TextStyle(
            //             color: Colors.blue,
            //             fontSize: 14
            //           )
            //         ),
            //       ),

            //       Container(
            //         height: 30,
            //         padding: EdgeInsets.symmetric(horizontal: 10),
            //         decoration: BoxDecoration(
            //           color: Colors.white24,
            //           borderRadius: BorderRadius.circular(15),
            //           border: Border.all(color: Colors.blue[400], width: 0.5)
            //         ),
            //         child: Center(
            //           child: Text(
            //             "去看看",
            //             style: TextStyle(
            //               color: Colors.blue,
            //               fontSize: 14,
            //               fontWeight: FontWeight.w400
            //             )
            //           ),
            //         ),
            //       )

            //     ],
            //   ),
            // )

          ],
        ),
      ),
    );
  }
}
