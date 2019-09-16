import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // const HomePage({Key key}) : super(key: key);
  final textController = TextEditingController();
  @override
  void dispose(){
    textController.dispose();
    super.dispose();
  }
  // 给输入框初始值 ok
  // @override
  // void initState(){
  //   super.initState();
  //   textController.text = 'hi';
  // }
  String showText = '欢迎您来到美好人间!';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('美好人间'),),
        body:SingleChildScrollView(
          child: Container(
            child:Column(
              children: <Widget>[
                TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    labelText:'类型',
                    helperText: '请输入类型'
                  ),
                  onChanged: (text) {//内容改变的回调
                    print('change $text');
                    // typeController.text=text;
                  },
                  onSubmitted: (text) {//内容提交(按回车)的回调
                    print('submit $text');
                  },
                  autofocus: false, // 关闭自动聚焦
                ),
                RaisedButton(
                  // 点击事件
                  onPressed:_choiceAction,
                  child:Text('选择完毕'),
                ),
                Text(
                  showText,
                  // 兼容性处理
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )
              ],
            )
          ),
        )
      )
    );
  }
  void _choiceAction(){
    print('开始选择你喜欢的类型............');
    if(textController.text.toString()==''){
      showDialog(
        context: context,
        builder: (context)=>AlertDialog(title:Text('类型不能为空'))
      );
    }else{
        getHttp(textController.text.toString()).then((val){
         setState(() {
           showText=val['data']['name'].toString();
         });
        });
    }

  }

  Future getHttp(String text)async{
    try{
      Response response;
      var data = {
        'name':text
         
      };
      response = await Dio().get("https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian",
        queryParameters: data
      );
      return response.data;
    }catch(e){
      print(e);
    }
  }
}