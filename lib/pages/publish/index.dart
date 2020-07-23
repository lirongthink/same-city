import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:same_city/common/http.dart';
import 'package:same_city/common/pictureBed.dart';
import 'package:same_city/store/model.dart';
import 'package:same_city/utils/navigator_util.dart';
import 'package:same_city/utils/toast.dart';
import 'dart:convert' as JSON;

class Publish extends StatefulWidget  {

  Publish({Key key}) : super(key: key);

  _PublishState createState() => _PublishState();
}

class _PublishState extends State<Publish> {

  final publishFormKey = GlobalKey<FormState>();

  File _image;

  String describe;
  double price;
  String imageUrl;

  final _picker = ImagePicker();

  Future _getImageFromCamera() async {
    PickedFile image = await _picker.getImage(source: ImageSource.camera, maxWidth: 400);
    _upLoadImage(File(image.path));
    setState(() {
     _image = File(image.path); 
    });
  }

  Future _getImageFromGallery() async {
    PickedFile image = await _picker.getImage(source: ImageSource.gallery);
    print(image.path);
    _upLoadImage(File(image.path));
    setState(() {
     _image = File(image.path);
    });
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
        imageUrl = res['data']; 
      });
      Toast.toast(context,msg: "图片上传成功",position: ToastPostion.center);
    } else {
      Toast.toast(context,msg: "图片上传失败,请重试",position: ToastPostion.center);
    }
  }

  void publishForm() {
    publishFormKey.currentState.save();
    print(this.describe);
    var flag = publishFormKey.currentState.validate();
    if (flag) {
      Map<String,dynamic> obj = {
        'describe':this.describe,
        'price':this.price,
        'imageUrl':this.imageUrl,
        'user':Provider.of<UserIdModel>(context,listen: false).userId
      };
      https('post', 'goods', obj).then((res){
        dynamic json = res.data;
        print(json);
        if (json['errno'] == 1000) {
          Toast.toast(context,msg: "发布成功",position: ToastPostion.center);
          NavigatorUtil.goHomePage(context);
        } else {
          Toast.toast(context,msg: json['errmsg'] ,position: ToastPostion.center);
        }
      });
    } else {
      Toast.toast(context,msg: "请将信息填写完整 ",position: ToastPostion.center);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
          child: Text('取消'),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            NavigatorUtil.goBack(context);
          },
        ),
        title: Text('发布'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
              child: Text('发布'),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              color: Colors.yellow,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              onPressed: (){
                publishForm();
              },
            ),
          )
        ],
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      child: SingleChildScrollView(
        child:
        Form(
          key: publishFormKey, //设置globalKey，用于后面获取FormState
          autovalidate: true,
          child: Column(
            children: <Widget>[
              // Card(
                // child: 
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    maxLines: 7,
                    decoration: InputDecoration.collapsed(
                      hintText:'品牌型号,新旧程度,入手渠道,转手原因...'
                    ),
                    onSaved: (value){
                      this.describe = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "描述不能为空";
                      }
                      return null;
                    },
                  ),
                ),
              // ),
              Padding(
                padding: EdgeInsets.only(top: 10.0,left: 10.0),
                child: SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.grey[300],
                    ),
                    child: buildImage(),
                  ),
                ),
              ),
              Padding(
                padding:EdgeInsets.only(right: 10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.monetization_on),
                    hintText: '￥0.00',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0,)
                  ),
                  onSaved: (value){
                    this.price = double.parse(value);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return "金额不能为空";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.end,
                )
              )
            ],
          )
        )
      )
    );
  }

  Widget buildImage() {
    if(_image == null){
      return Container(
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.add_a_photo),
              onPressed: () {
                _getImageFromCamera();
              },
            ),
            IconButton(
              icon: Icon(Icons.add_photo_alternate),
              onPressed: () {
                _getImageFromGallery();
              },
            ),
          ],
        )
      );
    } else {
      return Container(
        child: Image.file(_image,fit: BoxFit.cover),
      );
    }
  }
}
