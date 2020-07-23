
import 'package:flutter/material.dart';
import 'package:same_city/utils/navigator_util.dart';


class PublicPre extends StatefulWidget  {

  PublicPre({Key key}) : super(key: key);

  _PublicPreState createState() => _PublicPreState();
}



class _PublicPreState extends State<PublicPre> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('发布闲置'),
      ),
      body: buildBody(),
    );
  }

  void goToBack() {
    NavigatorUtil.goBack(context);
  }

  void goToPush() {
    NavigatorUtil.goPush(context);
  }

  Widget buildBody() {
    return Stack(
      alignment:Alignment.center ,
      fit: StackFit.expand,
      children: <Widget>[
        SizedBox(),
        Positioned(
          bottom: 0.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:<Widget>[
              Padding(
                padding: EdgeInsets.all(4.0),
                child: FlatButton.icon(
                  label: Text('发布闲置'),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  color: Colors.yellow,
                  icon: Icon(Icons.camera_alt),
                  onPressed: (){
                    goToPush();
                  },
                  
                ),
              ),
              IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Icon(Icons.close),
                onPressed: (){
                  goToBack();
                },
              ),
            ]
          ),
        ),
      ]
    );
  }
}
