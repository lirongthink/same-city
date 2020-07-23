import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:same_city/application.dart';
import 'package:same_city/route/routes.dart';

class NavigatorUtil {
  static _navigateTo(BuildContext context, String path,{
    bool replace = false,
    bool clearStack = false,
    Duration transitionDuration = const Duration(milliseconds: 250),
    RouteTransitionsBuilder transitionBuilder}){
      Application.router.navigateTo(context, path,
        replace: replace, //替代，为true时调用的是Navigator.pushReplacement
        clearStack: clearStack, //清空路由栈，为true时调用的是Navigator.pushAndRemoveUntil方法
        transitionDuration: transitionDuration, //转换的持续时间
        transitionBuilder: transitionBuilder, //转换生成器
        transition: TransitionType.material,  //转换类型
      );
  }

  //路由导航到TwoPage页面
  static goPushPre(BuildContext context){
    _navigateTo(context, Routes.pushPre);
  }

  static goPush(BuildContext context){
    _navigateTo(context, Routes.push);
  }

  static goGoodsDetail(BuildContext context){
    _navigateTo(context, Routes.goodsDetail);
  }

  static goPlace(BuildContext context){
    _navigateTo(context, Routes.place);
  }

  static goBuyOrder(BuildContext context){
    _navigateTo(context, Routes.buyOrder);
  }

  static goLogin(BuildContext context){
    _navigateTo(context, Routes.login,clearStack: true);
  }

  static goRegister(BuildContext context){
    _navigateTo(context, Routes.register);
  }

  static goGoods(BuildContext context){
    _navigateTo(context, Routes.goods);
  }

  static goOrderListPage(BuildContext context){
    _navigateTo(context, Routes.orderListPage);
  }

  static goOrderListBuyPage(BuildContext context){
    _navigateTo(context, Routes.orderListBuyPage);
  }

  static goHomePage(BuildContext context){
    _navigateTo(context, Routes.homePage,clearStack: true);
  }

  static gominePage(BuildContext context){
    _navigateTo(context, Routes.minePage,clearStack: true);
  }

  static gouserEditPage(BuildContext context){
    _navigateTo(context, Routes.userEditPage);
  }

  static goeditPage(BuildContext context){
    _navigateTo(context, Routes.editPage);
  }
  
  static goBack(BuildContext context){
    Navigator.pop(context);
  }
}
