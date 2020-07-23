import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:same_city/common/http.dart';
import 'package:same_city/common/pictureBed.dart';
import 'package:same_city/pages/mine/model.dart';
import 'package:same_city/pages/mine/navibar.dart';
import 'package:same_city/pages/mine/sell.dart';
import 'package:same_city/store/model.dart';
import 'package:same_city/utils/Screen.dart';
import 'package:same_city/utils/navigator_util.dart';
import 'dart:convert' as JSON;

import 'package:same_city/utils/toast.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MinePageState();
  }
}

class _MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin {
  double naviAlpha = 0;
  ScrollController _scrollController;
  UserModel userModel;
  String avatarUrl;
  final _picker = ImagePicker();

  @override
  bool get wantKeepAlive => true;
  
  @override
  void initState() {
    super.initState();
    initForm();
  }

  void initForm()async{
    var userId = Provider.of<UserIdModel>(context,listen: false).userId;
    var userRes = await https('get','user/$userId',{});
print(userRes);
    setState(() {
      userModel = UserModel.fromJSON(userRes.data['data']);
    });
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      var offset = _scrollController.offset;
      if (offset < 0) {
        setState(() {
          naviAlpha = 0;
        });
      } else if (offset < 50) {
        setState(() {
          naviAlpha = 1 - (50 - offset) / 50;
        });
      } else if (naviAlpha != 1) {
        setState(() {
          naviAlpha = 1;
        });
      }
    });
  }

  void _EditInfoForm() {

      Map<String,dynamic> obj = {
        'avatarUrl':this.avatarUrl
      };
      Map<String,dynamic> objParams = {
        'id':Provider.of<UserIdModel>(context,listen: false).userId,
        'data':obj
      };
      https('post', 'user/updateUserInfo', objParams).then((res){
        dynamic json = res.data;
        if (json['errno'] == 1000) {
          Toast.toast(context,msg: "头像修改成功",position: ToastPostion.center);
          NavigatorUtil.gominePage(context);
        } else {
          Toast.toast(context,msg: json['errmsg'] ,position: ToastPostion.center);
        }
      });
  }

  Future _getImageFromGallery() async {
    PickedFile image = await _picker.getImage(source: ImageSource.gallery);
    _upLoadImage(File(image.path));
  }
  _upLoadImage(File image) async {

    String path = image.path;
 
    FormData obj = FormData.fromMap({
      "multipartFile": await MultipartFile.fromFile(path, filename:'upload.png',),
      'key':'a5e229103832d7d6c7aca880e',
      'action':'upload'
    });
    var respone = await pictureBed('post','item/photo/upload',obj);
    Map<String, dynamic> res = JSON.jsonDecode(respone.data);
    if (res['code'] == 200) {
      setState(() {
        avatarUrl = res['data'];
        userModel.avatarUrl = res['data'];
      });
      Toast.toast(context,msg: "图片上传成功",position: ToastPostion.center);
      _EditInfoForm();
    } else {
      Toast.toast(context,msg: "图片上传失败,请重试",position: ToastPostion.center);
    }
  }

  void logOut() async{
    var res = await https('get','logout',{});
    print(res.data);
    if (res.data['errno'] == 1000) {
      NavigatorUtil.goLogin(context);
      Toast.toast(context,msg: "已成功登出",position: ToastPostion.center);
    }else {
      Toast.toast(context,msg: res.data['errmsg'],position: ToastPostion.center);
    }
  }

  Widget MineHeader() {
    return Stack(
      children: <Widget>[
        buildBottomWrap(),
        Padding(
          padding: EdgeInsets.only(top: 30),
          child: Column(
            children: <Widget>[
              buildProfile()
            ],
          ),
        )
      ],
    );
  }

  Widget MineBuy(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "我的地址",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16
                  )
                ),
                // SizedBox(
                //   width: 4,
                // ),
                // Text(
                //   "在闲鱼赚了1867.00元",
                //   style: TextStyle(
                //     color: Colors.grey,
                //     fontSize: 14
                //   )
                // ),
              ],
            ),
            
            SizedBox(
              height: 16,
            ),

            // grid 
            Container(
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '${userModel.name} ${userModel.phone}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(30),
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15.0,10.0,0,10.0),
                      // child:Container(
                      //   width: ScreenUtil().setWidth(470),
                      //   padding: EdgeInsets.all(10),
                        child:
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: ScreenUtil().setWidth(600),
                              child: Text(
                                userModel.address,
                                maxLines: 2,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: ScreenUtil().setSp(28)
                                ),
                              ),
                            ),
                          ]
                        )
                      // )
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget buildProfile() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // avatar 
          InkWell(
            onTap: () {
              _getImageFromGallery();
            },
            child:Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(userModel.avatarUrl),
                  fit: BoxFit.cover
                )
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          // context 
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  userModel.nickname,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  )
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "账户余额：￥${userModel.money}",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14
                  )
                ),
                SizedBox(
                  height: 4,
                ),
                InkWell(
                  onTap: () {
                    NavigatorUtil.gouserEditPage(context);
                  },
                  child:Container(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    height: 20,
                    width: 108,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "编辑个人资料",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 10,
                          color: Colors.black,
                        )
                      ],
                    ),
                  )
                )
              ],
            ),
          ),

          GestureDetector(
            onTap: () {
              logOut();
            }, 
            child: Container(
              child: Icon(
                Icons.directions,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildBottomWrap() {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10)
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 80),
            height: Screen.height(context),
            color: Colors.grey[100],
          ),
          ListView(
            controller: _scrollController,
            children: <Widget>[
              MineHeader(),
              SizedBox(height: 10,),
              MineSell(),
              SizedBox(height: 10,),
              MineBuy(),
              SizedBox(height: 10,),
            ],
          ),

          MineNavibar(naviAlpha),
        ],
      )
    );
  }
}
