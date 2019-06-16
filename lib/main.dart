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
            // 旧的 child
//          child: Text(
//            'Hello World，this is Danny\'s app '
//            '\n Danny 非常喜欢编程，并且愿意为此奋斗一生。'
//            '他希望可以出1000集免费教程。11111111111111111111222222222222222 ',
//            textAlign: TextAlign.left, // 左对齐
//            maxLines: 3, // 最多显示的行数
//            /*
//            * overflow属性
//              overflow属性是用来设置文本溢出时，如何处理,它有下面几个常用的值供我们选择。
//
//              clip：直接切断，剩下的文字就没有了，感觉不太友好，体验性不好。
//              ellipsis:在后边显示省略号，体验性较好，这个在工作中经常使用。
//              fade: 溢出的部分会进行一个渐变消失的效果，当然是上线的渐变，不是左右的哦
//            * */
//            overflow:TextOverflow.ellipsis,
//            style: TextStyle(
//              fontSize: 28.0,
//              color: Color.fromARGB(255, 255, 150, 150),
//              decoration: TextDecoration.underline,
//              decorationStyle: TextDecorationStyle.solid,  // 文字下滑线
//            ),
//          ),
          child:Container(
          //  child:new Text(
          //    'Hello 1                                       Danny',

          //    style: TextStyle(
          //        fontSize: 40.0,

          //        color: Color.fromARGB(255, 255, 250, 150),
          //    ),
          //  ),
          // //  alignment: Alignment.bottomCenter,  // 对齐
          //  alignment: Alignment.topLeft,  // 对齐

            child:new Image.network(
              'http://pic37.nipic.com/20140113/8800276_184927469000_2.png',
              scale:1.0,
              // 图片混合模式（colorBlendMode）和color属性配合使用，能让图片改变颜色
              color: Colors.greenAccent,
              colorBlendMode: BlendMode.darken,
              repeat: ImageRepeat.repeat,
            ),

//            
            // width:500.0,
            height:400.0,
            //  当 BoxDecoration设置有color时，外面不能进行 color设置
//            color:Colors.lightBlue,  
//            padding:const EdgeInsets.all(10.0),
            padding:EdgeInsets.fromLTRB(10,10,10,10),
           margin: const EdgeInsets.all(10.0),
            // margin:EdgeInsets.fromLTRB(30,10,30,10),
              // 背景色 边框
              decoration:new BoxDecoration(
                gradient:const LinearGradient(
                    colors:[Colors.lightBlue,Colors.greenAccent,Colors.purple]
                ),
                border:Border.all(width:2.0,color:Colors.red)
              ),

          ),
        ),
      ),
    );
  }
}
