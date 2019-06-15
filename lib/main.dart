import 'package:flutter/material.dart';

//主函数（入口函数），下面我会简单说说Dart的函数
void main() => runApp(MyApp());

// 声明MyApp类
class MyApp extends StatelessWidget {
  //重写build方法
  @override
  Widget build(BuildContext context) {
    //返回一个Material风格的组件
    return MaterialApp(
      title: 'Welcome to Flutteraa',
      home: Scaffold(
        //创建一个Bar，并添加文本
        appBar: AppBar(
          title: Text('Flutter APP'),
        ),
        //在主体的中间区域，添加一个hello world 的文本
        body: Center(
          child: Text(
            'Hello World，this is Danny\'s app '
            '\n JSPang 非常喜欢前端，并且愿意为此奋斗一生。'
            '他希望可以出1000集免费教程。 ',
            textAlign: TextAlign.left, // 左对齐
            maxLines: 3, // 最多显示的行数
            style: TextStyle(
              fontSize: 18.0,
              color: Color.fromARGB(255, 255, 150, 150),
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.solid,
            ),
          ),
        ),
      ),
    );
  }
}
