import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:same_city/pages/home/index.dart';
import 'package:same_city/pages/userActions/login.dart';
import 'package:same_city/route/route_handles.dart';

class Routes{
  static String root = "/"; //根目录
  static String pushPre = "/pushPre";
  static String push = "/push";
  static String goodsDetail = "/goodsDetail";
  static String place = "/place";
  static String buyOrder = "/buyOrder";
  static String register = "/register";
  static String login = "/login";
  static String homePage = "/homePage";
  static String goods = "/goods";
  static String minePage = "/minePage";
  static String editPage = "/editPage";
  static String orderListPage = "/orderListPage";
  static String orderListBuyPage = "/orderListBuyPage";
  static String userEditPage = "/userEditPage";

  //设置路由
  static void configureRoutes(Router router){
    //定义未找到页面
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
      return LoginPage();
    });

    router.define(pushPre,handler: pushPreHandler);
    router.define(push,handler: pushHandler);
    router.define(goodsDetail,handler: goodsDetailHandler);
    router.define(place,handler: placeHandler);
    router.define(buyOrder,handler: buyOrderHandler);
    router.define(login,handler: loginHandler);
    router.define(register,handler: registerHandler);
    router.define(homePage,handler: homePageHandler);
    router.define(goods,handler: goodsHandler);
    router.define(minePage,handler: minePageHandler);
    router.define(editPage,handler: editPageHandler);
    router.define(orderListPage,handler: orderListPageHandler);
    router.define(orderListBuyPage,handler: orderListBuyPageHandler);
    router.define(userEditPage,handler: userEditPageHandler);

  }
}
