import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:same_city/pages/goods/index.dart';
import 'model.dart';

class HomeBodyItem extends StatelessWidget {
  HomeBodyItem({Key key, this.model}) : super(key: key);

  final HomeGoodModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
   		//单击事件响应
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context)=>Goods(goodId: model.id),
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
            buildGoodImage(),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: buildGoodTitle(),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: buildGoodPrice(),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: buildUserInfo(),
            )
          ],
        ),
        
      )
    );
  }

  Widget buildGoodImage(){
    return Container(
      height: model.imageHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4)
        ),

        image: DecorationImage(
          image: CachedNetworkImageProvider(model.imageUrl),
          fit: BoxFit.cover
        )
      ),
    );
  }

  Widget buildGoodTitle() {
    return RichText(
      maxLines: 2,
      overflow: TextOverflow.clip,
      text: TextSpan(
        children: [
          goodDetail()
        ]
      ),
    );
  }
  
  Widget buildGoodPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "￥ ${model.price}",
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w600,
            fontSize: 16
            ),
        ),
        SizedBox(width: 4)
      ],
    );
  }

  Widget buildUserInfo() {
    return Row(
      children: <Widget>[
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            image: DecorationImage(
              image: CachedNetworkImageProvider(model.avatarUrl),
              fit: BoxFit.cover,
            )
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Text(
            model.userName,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14
            ),
          ),
        )
      ],
    );
  }

  TextSpan goodDetail() {
    return TextSpan(
      text: " ${model.describe}",
      style: TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w500
      )
    );
  }
}
