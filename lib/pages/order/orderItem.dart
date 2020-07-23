import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:same_city/pages/order/buyOrderDetial.dart';
import 'model.dart';

class OrderItem extends StatelessWidget {
  OrderItem({Key key, this.model}) : super(key: key);

  final OrderModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
   		//单击事件响应
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context)=>BuyOrderDetial(orderId: model.id),
            ));
        },
        child:Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child:Image.network(
                      model.sellerAvatarUrl,
                      width:ScreenUtil().setWidth(50),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    '${model.sellerName}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(30),
                      fontWeight: FontWeight.w500
                    ),
                  )
                ],
              )
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child:
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(5.0),
                    child:Image.network(
                      model.goodImage,
                      width:ScreenUtil().setWidth(100),
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
                          model.goodDescrip,
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
                          '￥${model.goodPrice}',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: ScreenUtil().setSp(30)
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
    );
  }
}
