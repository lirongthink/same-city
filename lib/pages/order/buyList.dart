import 'package:flutter/material.dart';
import 'package:same_city/pages/order/body.dart';
import 'package:same_city/pages/order/buyBody.dart';

class BuyOrderListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('订单列表'),
      ),
      body: OrderListBuyBody(),
    );
  }
}
