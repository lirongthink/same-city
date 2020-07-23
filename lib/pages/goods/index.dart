import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:same_city/common/http.dart';
import 'package:same_city/pages/home/model.dart';
import 'package:same_city/pages/order/place.dart';
import 'package:same_city/store/model.dart';
import 'package:same_city/utils/navigator_util.dart';

class Goods extends StatefulWidget {
  Goods({Key key, this.goodId}) : super(key: key);

  final String goodId;
  
  @override
  _GoodsState createState() => _GoodsState(goodId);
}

class _GoodsState extends State<Goods> {

  _GoodsState(this.goodId);

  HomeGoodModel model;
  final String goodId;

  @override
  void initState() { 
    super.initState();
    _getGoodInfo();
  }

  Widget _bottomButton(){
    if(model.userId != Provider.of<UserIdModel>(context,listen: false).userId){
      return FlatButton(
        child: Text(
          '立即购买',
          style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(20)),
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        color: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context)=>Place(goodId: model.id),
          ));
        },
      );
    }else {
      return SizedBox(width: 10);
    }
  }

  void _getGoodInfo() async {
    var res = await https('get','goods/$goodId',{});
    print(res.data);
    setState(() {
      model = HomeGoodModel.fromJSON(res.data['data']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(''),
      ),
      body: buildBody(),
    );
  }
  //商品图片
  Widget _goodsImage(url){
    return  Container(
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(50)
        ),
        child: Image.network(
        url,
        width:ScreenUtil().setWidth(740),
        fit: BoxFit.cover,
      )
    );
  }
   //商品名称
  Widget _goodsName(name){

      return Container(
        width: ScreenUtil().setWidth(730),
        padding: EdgeInsets.only(left:15.0),
        child: Text(
          name,
          maxLines: 10,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(30)
          ),
        ),
      );
  }
  //商品价格方法

  Widget _goodsPrice(presentPrice){

    return  Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left:15.0),
      margin: EdgeInsets.only(top:8.0),
      child: Row(
        children: <Widget>[
          Text(
            '￥$presentPrice',
            style: TextStyle(
              color:Colors.red,
              fontSize: ScreenUtil().setSp(40),

            ),

          )
        ],
      ),
    );

  }

  Widget _userInfo(url,userName){
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Image.network(
            url,
            width:ScreenUtil().setWidth(100),
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.0),
            child: Column(
              children: <Widget>[
                Text(
                  userName,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(30),
                    fontWeight: FontWeight.w500
                  ),
                ),
                Text(
                  '发布于唐山',
                  style: TextStyle(
                    color: Colors.blue[300],
                    fontSize: ScreenUtil().setSp(20),
                    fontWeight: FontWeight.w400
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }

  Widget DetailsBottom() {
    return Container(
       width:ScreenUtil().setWidth(750),
       color: Colors.white,
       height: ScreenUtil().setHeight(80),
       child: Row(
         children: <Widget>[
          SizedBox(
            width: ScreenUtil().setWidth(550),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
            child: _bottomButton(),
          )
         ],
       ),
    );
  }

  Widget buildBody() {
    
    return Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
              _userInfo(model.avatarUrl,model.userName),
              _goodsPrice(model.price),
              _goodsName(model.describe),
              _goodsImage(model.imageUrl),
            ],
          ),
        Positioned(
          bottom: 0,
          left: 0,
          child: DetailsBottom()
        )
      ],
    );
  }
  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(DiagnosticsProperty('goodId', goodId));
  // }
}
// class _GoodsState extends State<Goods> {
//   @override
  
  //    Widget buildBody() {
  //   Container(
  //     child: Column(
  //       children: <Widget>[
  //         Flexible(
  //           child: SingleChildScrollView(
  //             child: Column(
  //               children: <Widget>[
  //                 Container(
  //                   child: Row(
  //                     children: <Widget>[
  //                       Image(
  //                         image: CachedNetworkImageProvider(''),
  //                         width: 35,
  //                         height: 35,
  //                         fit: BoxFit.cover,
  //                       ),
  //                       // Text('asdasdasd')
  //                     ],
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
  //                   child: Container(
  //                     child: Text(
  //                       '￥1561',
  //                       style: TextStyle(
  //                         color: Colors.red,
  //                         fontSize: 25,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 Container(
  //                   child: Text(
  //                     'fadfasdfs',
  //                     maxLines: 10,
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
  //                   child: Image(
  //                     image: CachedNetworkImageProvider(''),
  //                     width: 35,
  //                     height: 35,
  //                     fit: BoxFit.cover,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           )
  //         ),
  //         Container(
  //           child: Container(
  //             alignment: Alignment.topRight,
  //             child: Padding(
  //               padding: EdgeInsets.all(10.0),
  //               child: FlatButton(
  //                 child: Text('立即购买'),
  //                 splashColor: Colors.transparent,
  //                 highlightColor: Colors.transparent,
  //                 color: Colors.red,
  //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
  //                 onPressed: (){},
  //               ),
  //             ),
  //           )
  //         )
  //       ],
  //     )
  //   );
  // }
// }
