import 'package:flutter/cupertino.dart';

class UserIdModel with ChangeNotifier {
  String userId;
  UserIdModel(this.userId);
  /*修改名字*/
  void change(String a){
    this.userId = a;
    notifyListeners();//通知所有监听的页面，如果写在runapp中那么通知所有页面重新加载
  }
  String get theUserId => userId;
}
