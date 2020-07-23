import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:same_city/common/cookie.dart';
import 'package:same_city/common/http.dart';
import 'package:same_city/store/model.dart';
import 'package:same_city/utils/navigator_util.dart';
import 'package:same_city/utils/toast.dart';


class UserEditInfo extends StatefulWidget {
  UserEditInfo({Key key}) : super(key: key);

  _UserEditInfoState createState() => _UserEditInfoState();
}

class _UserEditInfoState extends State<UserEditInfo> {

  final UserEditInfoFormKey = GlobalKey<FormState>();
  String nickname,name,phone,address;

  @override
  void initState(){
    super.initState();
    initForm();
  }

  void initForm() async{
    var userId = Provider.of<UserIdModel>(context,listen: false).userId;
    var userRes = await https('get','user/$userId',{});
    print(userRes.data);
    setState(() {
      nickname = userRes.data['data']['nickname'];
      name = userRes.data['data']['name'];
      phone = userRes.data['data']['phone'];
      address = userRes.data['data']['address'];
    });
  }

  void UserEditInfoForm() {
    UserEditInfoFormKey.currentState.save();
    var flag = UserEditInfoFormKey.currentState.validate();
if (flag) {
      Map<String,dynamic> obj = {
        'nickname':this.nickname,
        'name':this.name,
        'phone':this.phone,
        'address':this.address,
      };
      Map<String,dynamic> objParams = {
        'id':Provider.of<UserIdModel>(context,listen: false).userId,
        'data':obj
      };
      https('post', 'user/updateUserInfo', objParams).then((res){
        dynamic json = res.data;
        if (json['errno'] == 1000) {
          Toast.toast(context,msg: "修改成功",position: ToastPostion.center);
          NavigatorUtil.goHomePage(context);
        } else {
          Toast.toast(context,msg: json['errmsg'] ,position: ToastPostion.center);
        }
      });
    } else {
      Toast.toast(context,msg: "请正确填写信息 ",position: ToastPostion.center);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('编辑个人资料'),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenUtil().setWidth(50)),
        child: ListView(
          children: <Widget>[
            Form(
              key: UserEditInfoFormKey, //设置globalKey，用于后面获取FormState
              autovalidate: true,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    autofocus: true,
                    // autovalidate: true,
                    decoration: InputDecoration(
                        labelText: "昵称",
                        hintText: "请输入昵称",
                        prefixIcon: Icon(Icons.person)
                    ),
                    onSaved: (value) {
                      this.nickname = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "昵称不能为空";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    autofocus: true,
                    // autovalidate: true,
                    decoration: InputDecoration(
                        labelText: "姓名",
                        hintText: "请输入姓名",
                        prefixIcon: Icon(Icons.person)
                    ),
                    onSaved: (value) {
                      this.name = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "姓名不能为空";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    autofocus: true,
                    // autovalidate: true,
                    decoration: InputDecoration(
                        labelText: "电话",
                        hintText: "请输入电话",
                        prefixIcon: Icon(Icons.person)
                    ),
                    onSaved: (value) {
                      this.phone = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "电话不能为空";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    autofocus: true,
                    // autovalidate: true,
                    decoration: InputDecoration(
                        labelText: "交易地址",
                        hintText: "请输入交易地址",
                        prefixIcon: Icon(Icons.person)
                    ),
                    onSaved: (value) {
                      this.address = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "交易地址不能为空";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  FlatButton(
                    child: Text("提交更改"),
                    color: Colors.red,
                    onPressed: (){
                      UserEditInfoForm();
                    },
                  )
                ]
              )
            )
          ],
        ),
      ),
    );
  }
}
