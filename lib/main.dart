import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Flutter Demo',
      home:Scaffold(
        appBar:new AppBar(title: new Text('ListView Widget'),),
        body:new ListView(
          children: <Widget>[ //这里面可以放任何组件
            new ListTile(
              leading: new Icon(Icons.perm_camera_mic),
              title: new Text('camera_mic'),
            ),
            new ListTile(
              leading: new Icon(Icons.public),
              title: new Text('public'),
            ),
            new ListTile(
              leading: new Icon(Icons.phone_iphone),
              title: new Text('iphone'),
            ),
            new Image.network('http://blogimages.jspang.com/WechatIMG12.jpeg'),
            new Image.network('http://blogimages.jspang.com/Flutter%E7%A7%BB%E5%8A%A8%E7%94%B5%E5%95%86%E5%AE%9E%E6%88%98-%E7%9F%A5%E8%AF%86%E7%82%B9%E6%A2%B3%E7%90%86.png'),
            new Image.network('https://jspang.com/images/zhishixingqiu.png'),
          ],
        )

      )
    );
  }
}