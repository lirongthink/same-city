import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:same_city/pages/home/index.dart';
import 'package:same_city/pages/news/idnex.dart';
import 'package:same_city/pages/order/index.dart';
import 'package:same_city/pages/mine/index.dart';
import 'package:same_city/utils/navigator_util.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  final List<Widget> bottomBars = [
    HomePage(),
    MinePage()
  ];


  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title:Text('首页'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.assignment),
      title:Text('订单'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.add),
      title:Text('卖二手'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sms),
      title:Text('消息'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title:Text('我的'),
    )
  ];

  final List tabBodies = [
    HomePage(),
    OrderPage(),
    (){},
    NewsPage(),
    MinePage()
  ];

  int currentIndex = 0;
  var currentPage;

  void goToPre() {
    NavigatorUtil.goPushPre(context);
    // NavigatorUtil.goGoodsDetail(context);
    // NavigatorUtil.goPlace(context);
    // NavigatorUtil.goBuyOrder(context);
  }

  @override
  void initState() {
    currentIndex = 0;
    currentPage = tabBodies[currentIndex];
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return buildBar();
  }

  Widget buildBar(){
    return Scaffold(
        body: bottomBars[currentIndex],
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            goToPre();
          },
          tooltip: 'publish',
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
       bottomNavigationBar: BottomAppBar(
         color:Colors.lightBlue,
         shape:CircularNotchedRectangle(),
         child: Row(
           mainAxisSize: MainAxisSize.max,
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: <Widget>[
             IconButton(
               icon:Icon(Icons.home),
               color:Colors.white,
               onPressed:(){
                 setState(() {
                  currentIndex = 0; 
                 });
               }
             ),
             IconButton(
               icon:Icon(Icons.person),
               color:Colors.white,
               onPressed:(){
                 setState(() {
                  currentIndex = 1; 
                 });
               }
             ),
           ],
         ),
       )
     );
  }

  // Widget buildLong(){
  //   Scaffold(
  //     bottomNavigationBar: Stack(
  //       children: <Widget>[
  //         Align(
  //           alignment: Alignment.bottomCenter,
  //           child: BottomNavigationBar(
  //             type:BottomNavigationBarType.fixed,
  //             currentIndex: currentIndex,
  //             items: bottomTabs,
  //             onTap: (index){
  //               setState(() {
  //                 if(index != 2){
  //                   currentIndex = index;
  //                   currentPage = tabBodies[currentIndex];
  //                 }
  //               });
  //             },
  //           ),
  //         ),
  //         Align(
  //           alignment: Alignment.bottomCenter,
  //           child: Padding(
  //             padding: const EdgeInsets.only(bottom: 30.0),
  //             child: InkWell( //去掉水波纹点击效果
  //               child: new Container(
  //                 width: 80.0,
  //                 height: 80.0,
  //                 padding: const EdgeInsets.all(5.0),
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(100),
  //                   color: Colors.white
  //                 ),
  //                 child: new Container(
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(100),
  //                     color: Colors.blue[500]
  //                   ),
  //                   child: new Icon(Icons.add,size: 50.0,color: Colors.white)
  //                 ),
  //               ),
  //             ),
  //           ),
  //         )
  //       ]
  //     )
  //   );
  // }
}

