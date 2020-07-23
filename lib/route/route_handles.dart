//twoPage路由的handler
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:same_city/pages/goods/index.dart';
import 'package:same_city/pages/index/index.dart';
import 'package:same_city/pages/mine/edit.dart';
import 'package:same_city/pages/mine/index.dart';
import 'package:same_city/pages/mine/userEdit.dart';
import 'package:same_city/pages/order/buyList.dart';
import 'package:same_city/pages/order/buyOrder.dart';
import 'package:same_city/pages/order/list.dart';
import 'package:same_city/pages/order/place.dart';
import 'package:same_city/pages/publish/index.dart';
import 'package:same_city/pages/publish/pre.dart';
import 'package:same_city/pages/userActions/login.dart';
import 'package:same_city/pages/userActions/register.dart';

var pushPreHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> parameters){
    return PublicPre(); //返回的是个Widget
  });
var pushHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> parameters){
    return Publish(); //返回的是个Widget
  });
var goodsDetailHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> parameters){
    return Goods(); //返回的是个Widget
  });
var placeHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> parameters){
    return Place(); //返回的是个Widget
  });
var buyOrderHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> parameters){
    return BuyOrder(); //返回的是个Widget
  });
var loginHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> parameters){
    return LoginPage(); //返回的是个Widget
  });
var registerHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> parameters){
    return RegisterPage(); //返回的是个Widget
  });
var homePageHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> parameters){
    return IndexPage(); //返回的是个Widget
  });

var goodsHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> parameters){
    return Goods(goodId: parameters['goodId'][0],); //返回的是个Widget
  });
var minePageHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> parameters){
    return MinePage(); //返回的是个Widget
  });
var editPageHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> parameters){
    return EditInfo(); //返回的是个Widget
  });
var orderListPageHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> parameters){
    return OrderListPage(); //返回的是个Widget
  });
  var orderListBuyPageHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> parameters){
    return BuyOrderListPage(); //返回的是个Widget
  });
var userEditPageHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> parameters){
    return UserEditInfo(); //返回的是个Widget
  });
