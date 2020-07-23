import 'package:flutter/material.dart';
import 'package:same_city/pages/home/body.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      titleSpacing: 0,
      title: buildSearchBar(),
      backgroundColor: Colors.yellow
    );
  }

  Widget buildSearchBar() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 10,
        ),
        Row(
          children: <Widget>[
            Text(
              '唐山',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: (){},
            )
          ],
        ),
        Expanded(//弹性布局
          child: Container(
            height: 30,
            padding: EdgeInsets.only(left: 10,right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.search,
                  size: 18,
                  color: Colors.grey[400],
                ),

                SizedBox(width: 5),

                Text(
                  'XBox one',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w300
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildBody() {
    return Scrollbar(
      child: HomeBody(),
    );
  }
}
