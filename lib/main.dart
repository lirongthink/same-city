import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:same_city/application.dart';
import 'package:same_city/pages/userActions/login.dart';
import 'package:same_city/route/routes.dart';
import 'package:same_city/store/model.dart';
import './pages/index/index.dart';

void main() {
  ScreenUtil.init(width: 750, height: 1334);  
  Router router = Router();
  Routes.configureRoutes(router);
  Application.router = router;

  
  runApp(MultiProvider(providers: [
      ChangeNotifierProvider<UserIdModel>.value(value: UserIdModel(''))
    ],child:MyApp()
  ));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '同城购',
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //   primaryColor: Colors.yellowAccent
        // ),
        home: LoginPage(),
      ),
    );
  }
}
