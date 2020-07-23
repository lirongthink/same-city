import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:same_city/common/http.dart';
import 'package:same_city/pages/order/model.dart';
import 'package:same_city/store/model.dart';
import 'package:same_city/utils/toast.dart';
import 'package:intl/intl.dart';

class SellOrderDetial extends StatefulWidget {
  SellOrderDetial({Key key, this.orderId}) : super(key: key);

  final String orderId;

  @override
  _SellOrderDetialState createState() => _SellOrderDetialState(orderId);
}

class _SellOrderDetialState extends State<SellOrderDetial> {
  
  _SellOrderDetialState(this.orderId);
  final String orderId;
  OrderModel orderModel;
  
  @override
  void initState() { 
    super.initState();
    _getOrderInfo();
  }

  _getOrderInfo() async{
      var orders = await https('get','order/$orderId',{});
      setState(() {
        orderModel = OrderModel.fromJSON(orders.data['data']);
      });
    
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
                  '￥${orderModel.goodPrice}',
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
            child: bottomButton(),
          )
         ],
       ),
    );
  }

  Widget bottomButton() {
    if(orderModel.status == '已下单'){
      return FlatButton(
        child: Text(
          '我要付款',
          style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(20)),
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        color: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        onPressed: ()async{
          Map<String,dynamic> obj = {
              '_id':orderModel.id,
              'status':'已付款'
          };

          var orderRes = await https('get','order/changeOrderStatus',obj);
          if (orderRes.data['errno'] == 1000) {
            Map<String,dynamic> moneyObj = {
                'fromId':Provider.of<UserIdModel>(context,listen: false).userId,
                'toId':'5f05de3c3c13423de03a05e6',
                'money':orderModel.goodPrice
            };
            var moneyRes = await https('post','user/transferAccounts',moneyObj);
            print(moneyRes);
            setState(() {
              orderModel.status = '已付款';
            });
          } else {
            Toast.toast(context,msg: orderRes.data['errmsg'],position: ToastPostion.center);
          }
        },
      );
    }else if(orderModel.status == '已付款') {
      return FlatButton(
        child: Text(
          '确认收货',
          style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(20)),
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        color: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        onPressed: ()async{
          Map<String,dynamic> obj = {
              '_id':orderModel.id,
              'status':'交易完成'
          };

          var orderRes = await https('get','order/changeOrderStatus',obj);
          if (orderRes.data['errno'] == 1000) {
            Map<String,dynamic> moneyObj = {
                'fromId':'5f05de3c3c13423de03a05e6',
                'toId':orderModel.sellerId,
                'money':orderModel.goodPrice
            };
            var moneyRes = await https('post','user/transferAccounts',moneyObj);
            print(moneyRes);
            setState(() {
              orderModel.status = '交易完成';
            });
          } else {
            Toast.toast(context,msg: orderRes.data['errmsg'],position: ToastPostion.center);
          }
        },
      );
    }else{
      return SizedBox(width: 10);
    }
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
              Container(
                width: ScreenUtil().setHeight(800),
                height: ScreenUtil().setHeight(200),
                padding: EdgeInsets.all(8.0),
                // alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey[200]
                ),
                child: Card(
                  child:Padding(
                  padding: EdgeInsets.fromLTRB(20, 25, 0, 0),
                    child:Text(
                      orderModel.status,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(30),
                      ),
                    ),
                  ),
                )
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child:Image.network(
                            orderModel.goodImage,
                            width:ScreenUtil().setWidth(150),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          width: ScreenUtil().setWidth(200),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: <Widget>[
                              Text(
                                orderModel.goodDescrip,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(30),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(20),
                        ),
                        Container(
                          width: ScreenUtil().setWidth(300),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.topRight,
                          child: Column(
                            children: <Widget>[
                              Text(
                                '￥${orderModel.goodPrice}',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.grey[300],
                                  fontSize: ScreenUtil().setSp(30)
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: ScreenUtil().setHeight(30),bottom: ScreenUtil().setHeight(20),left: ScreenUtil().setWidth(30)),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '实付款',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(40)
                            ),
                          ),
                          SizedBox(
                            width: ScreenUtil().setHeight(430),
                          ),
                          Text(
                            '￥${orderModel.goodPrice}',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(30)
                            ),
                          )
                        ],
                      )
                    )
                  ],
                ),
              ),
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
                            '交易地址:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(30),
                            ),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(10),
                          ),
                          Text(
                            '${orderModel.buyerName} ${orderModel.buyerPhone}',
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
                                orderModel.buyerAddress,
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
              ),
              Container(
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                        child:Row(
                          children: <Widget>[
                            Text(
                            '订单信息:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(30),
                            ),
                          ),
                        ]
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20),ScreenUtil().setWidth(20),0,0),
                      child:Row(
                        children: <Widget>[
                          Text(
                            '买家昵称:${orderModel.buyerNickname}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: ScreenUtil().setSp(23)
                            ),
                          ),
                        ]
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20),ScreenUtil().setWidth(20),0,0),
                      child:Row(
                        children: <Widget>[
                          Text(
                            '订单编号:${orderModel.id}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: ScreenUtil().setSp(23)
                            ),
                          )
                        ]
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20),ScreenUtil().setWidth(20),0,ScreenUtil().setWidth(20)),
                      child:Row(
                        children: <Widget>[
                          Text(
                            '交易时间:${DateFormat("yyyy-MM-dd HH:mm:ss").format(orderModel.date)}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: ScreenUtil().setSp(23)
                            ),
                          ),
                        ]
                      )
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        // Positioned(
        //   bottom: 0,
        //   left: 0,
        //   child: DetailsBottom()
        // )
      ]
    );
  }

}
