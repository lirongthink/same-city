import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuyOrder extends StatefulWidget {
  BuyOrder({Key key}) : super(key: key);

  @override
  _BuyOrderState createState() => _BuyOrderState();
}

class _BuyOrderState extends State<BuyOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(''),
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
                  '￥10.00',
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
              onPressed: (){},
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
                      '已下单',
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
                            'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1594021425551&di=d622aa280caaff0bfcbffd314b4affda&imgtype=0&src=http%3A%2F%2Fec4.images-amazon.com%2Fimages%2FI%2F51vAhpEt8pL.jpg',
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
                                'sereresrasdsadsaddsadasdasdasdsaasdasdasdasdasdas',
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
                                '￥10.0',
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
                            '￥70.00',
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
                            '卖家昵称:adsfsadfdfas',
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
                            '订单编号:16546546516545646546464',
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
                            '交易时间:2019-1-30 19:50:30',
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
