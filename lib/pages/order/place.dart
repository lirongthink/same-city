import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:same_city/common/http.dart';
import 'package:same_city/pages/home/model.dart';
import 'package:same_city/pages/mine/model.dart';
import 'package:same_city/pages/order/createOrder.dart';
import 'package:same_city/store/model.dart';

class Place extends StatefulWidget {
  Place({Key key, this.goodId}) : super(key: key);
  final String goodId;
  @override
  _PlaceState createState() => _PlaceState(goodId);
}

class _PlaceState extends State<Place> {

  _PlaceState(this.goodId);

  final String goodId;
  HomeGoodModel model;
  UserModel userModel;

  @override
  void initState() { 
    super.initState();
    _getOrderInfo();
  }

  _getOrderInfo() async{
    var res = await https('get','goods/$goodId',{});
    var userId = Provider.of<UserIdModel>(context,listen: false).userId;
    var userRes = await https('get','user/$userId',{});
    setState(() {
      model = HomeGoodModel.fromJSON(res.data['data']);
      userModel = UserModel.fromJSON(userRes.data['data']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('购买宝贝'),
      ),
      body: buildBody(),
    );
  }

  Widget _cartImage(item){

    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1,color:Colors.black12)
      ),
      child: Image.network(item.images),
    );
  }
  
  //商品名称
  Widget _cartGoodsName(item){
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(item.goodsName)
        ],
      ),
    );
  }

  //商品价格
  Widget _cartPrice(item){

    return Container(
        width:ScreenUtil().setWidth(150) ,
        alignment: Alignment.centerRight,

        child: Column(
          children: <Widget>[
            Text('￥${item.price}'),
            Container(
              child: InkWell(
                onTap: (){},
                child: Icon(
                  Icons.delete_forever,
                  color: Colors.black26,
                  size: 30,
                ),
              ),
            )
          ],
        ),
      );
  }

  Widget DetailsBottom() {
    return Container(
       width:ScreenUtil().setWidth(750),
       color: Colors.white,
       height: ScreenUtil().setHeight(90),
       child: Row(
         children: <Widget>[
          SizedBox(
            width: ScreenUtil().setWidth(300),
          ),
          Container(
            margin: EdgeInsets.only(right: ScreenUtil().setWidth(50)),
            child: Row(
              children: <Widget>[
                Text(
                  '实付款:',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(25)
                    ),
                ),
                Text(
                  '￥${model.price}',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil().setSp(30)
                    ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
            child: FlatButton(
              child: Text(
                '确认购买',
                style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(20)),
              ),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              color: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>CreateOrder(goodId: model.id),
                ));
              },
            ),
          )
         ],
       ),
    );
  }

  Widget buildBody() {
    return 
    Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.grey[200]
          ),
          child: Column(
            children: <Widget>[
              Card(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child:Image.network(
                        model.imageUrl,
                        width:ScreenUtil().setWidth(200),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 5.0),
                    //   child: 
                      Column(
                        children: <Widget>[
                          Container(
                            width: ScreenUtil().setWidth(470),
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.topLeft,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  model.describe,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(30),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            width: ScreenUtil().setWidth(470),
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.bottomRight,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  '￥${model.price}',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: ScreenUtil().setSp(30),
                                    fontWeight: FontWeight.w600
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    // )
                  ],
                ),
              ),
              Card(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        '交易地址',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(30),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: ScreenUtil().setWidth(470),
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.bottomRight,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  '${userModel.name} ${userModel.phone}',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(30),
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: ScreenUtil().setWidth(470),
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.topRight,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  userModel.address,
                                  maxLines: 2,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: ScreenUtil().setSp(28)
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: DetailsBottom()
        )
      ]
    );
  }
}
