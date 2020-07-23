import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:same_city/common/cookie.dart';
import 'package:same_city/common/http.dart';
import 'package:same_city/store/model.dart';
import 'package:same_city/utils/navigator_util.dart';
import 'package:same_city/utils/toast.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final loginFormKey = GlobalKey<FormState>();
  String username,password;

  void loginForm() {
    loginFormKey.currentState.save();
    var flag = loginFormKey.currentState.validate();
if (flag) {
      Map<String,dynamic> obj = {
        'accout':this.username,
        'password':this.password
      };
      https('post', 'userLogin', obj).then((res){
        dynamic json = res.data;
        if (json['errno'] == 1000) {
          Toast.toast(context,msg: "登录成功",position: ToastPostion.center);
          List<Cookie> cookies = [
            new Cookie('token',json['data']['token'])
          ];
          Api.saveCookie(cookies);
          Provider.of<UserIdModel>(context, listen: false).change(json['data']['res'][0]['_id']);
          NavigatorUtil.goeditPage(context);
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
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Icon(Icons.close),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      //   title: Text('登录页面'),
      //   actions: <Widget>[
      //     FlatButton(
      //       child: Text('客服'),
      //       onPressed: () {},
      //     )
      //   ],
      // ),
      body: Container(
        padding: EdgeInsets.all(ScreenUtil().setWidth(50)),
        child: ListView(
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 30),
                height: ScreenUtil().setWidth(100),
                width: ScreenUtil().setWidth(200),
                // child: Image.asset('images/login.pn g'),
                child: Text(
                  '同城购',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(50),
                    fontWeight: FontWeight.bold
                  ),
                )
              ),
            ),
            Form(
              key: loginFormKey, //设置globalKey，用于后面获取FormState
              autovalidate: true,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    autofocus: true,
                    // autovalidate: true,
                    decoration: InputDecoration(
                        labelText: "账号",
                        hintText: "请输入账号",
                        prefixIcon: Icon(Icons.person)
                    ),
                    onSaved: (value) {
                      this.username = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "账号不能为空";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "密码",
                      hintText: "请输入密码",
                      prefixIcon: Icon(Icons.lock)
                  ),onSaved: (value) {
                    this.password = value;
                  },
                  // autovalidate: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "密码不能为空";
                    }
                    return null;
                  },
                  obscureText: true,
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(ScreenUtil().setWidth(50)),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("忘记密码"),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child:InkWell(
                            onTap: (){
                              NavigatorUtil.goRegister(context);
                            },
                            child: Text("新用户注册"),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  FlatButton(
                    child: Text("登录"),
                    color: Colors.red,
                    onPressed: (){
                      loginForm();
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
