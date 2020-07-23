import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:same_city/common/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:same_city/pages/home/item.dart';
import 'package:same_city/pages/home/model.dart';
import 'package:same_city/pages/order/model.dart';
import 'dart:convert' as JSON;

import 'package:same_city/pages/order/orderItem.dart';
import 'package:same_city/pages/order/orderSellItem.dart';
import 'package:same_city/store/model.dart';

enum LoadingState {
  nona,
  loading,
  noMore
}
class OrderListBody extends StatefulWidget {
  OrderListBody({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OrderListBodyState();
}

class _OrderListBodyState extends State<OrderListBody> with AutomaticKeepAliveClientMixin {

  int page = 1;
  LoadingState loadingState = LoadingState.nona;
  bool isPerformingRequest = false;
  List <OrderModel> data = [];

  @override
  bool get wantKeepAlive => true;


  @override
  void initState() {
    super.initState();
    fetchMoreData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext context) {
          return NotificationListener<ScrollEndNotification>(
            onNotification: (ScrollEndNotification scroll){
              if (scroll.metrics.pixels == scroll.metrics.maxScrollExtent) {
                fetchMoreData();
              }
              return false;
            },
            child: Container(
              color: Colors.grey[100],
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context,index){
                  return Container(
                    margin: EdgeInsets.all(ScreenUtil().setWidth(20)),
                    child: Card(
                      child: OrderSellItem(model:data[index]),
                    ),
                  );
                }
              )
              
              // CustomScrollView(
              //   slivers: <Widget>[
              //     SliverPadding(
              //       padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
              //       sliver: SliverStaggeredGrid.countBuilder(
              //         crossAxisCount: 4,
              //         crossAxisSpacing: 10,
              //         mainAxisSpacing: 10,
              //         itemCount: data.length,
              //         itemBuilder: (BuildContext context, int index){
              //           return OrderItem(model:data[index]);
              //         },
              //         staggeredTileBuilder: (int index) {
              //           return StaggeredTile.fit(2);
              //         },
              //       ),
              //     ),
              //     buildLoading(),
              //   ],
              // )
            ),
          );
        },
      ),
    );
  }

  Widget buildLoading() {
    Widget tipWidget;
    if (loadingState == LoadingState.loading) {
      tipWidget = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(),
          ),
          SizedBox(width: 20,),
          Text('加载中')
        ],
      );
    }

    if (loadingState == LoadingState.noMore) {
      tipWidget = Text("暂时没有更多数据...");
    }

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 30),
          child: tipWidget,
        ),
      )
    );
  }

  
  Widget noMoreData() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 18, bottom: 30),
          child: Text(
            "no more data",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey
            ),
          ),
        ),
      ],
    );
  }

  Future<void> fetchMoreData() async {
    if (loadingState != LoadingState.loading) { 
      setState(() {
        loadingState = LoadingState.loading;
      });
      Map<String,dynamic> obj = {
        'currentPage':this.page,
        'seller':Provider.of<UserIdModel>(context,listen: false).userId
      };
      
      var res = await https('get','order/getSellOrder',obj);
      print(res.data);
      List<OrderModel> orders = [];
      res.data['data']['data'].forEach( (data) {
        print(data);
        orders.add(OrderModel.fromJSON(data));
      });
      
      Future.delayed(Duration(seconds: 2), () {
        if (!mounted){
          return;
        }

        setState(() {
          data.addAll(orders);
          loadingState = LoadingState.nona;
          page++;
        });
      });
    }
  }
}
