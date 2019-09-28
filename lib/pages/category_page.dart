import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/config/httpHeader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../config/httpHeader.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String showText = '还没有请求数据';
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Center(
        child: Container(
          child:CircularProgressIndicator(
            // strokeWidth: 4.0, // 圆环宽度
            // backgroundColor: Color(0xffff0000),  // 圆环背景颜色
            // valueColor: new AlwaysStoppedAnimation<Color>(Colors.indigo),  // 圆环颜色
          ),
          // Text('显示加载动画'),
        )
      );
    }else{
      return Container(
        child: Scaffold(
          appBar: AppBar(title: Text('请求数据'),),
          body:SingleChildScrollView(
            child: Column(
              children:<Widget>[
                RaisedButton(
                  onPressed: _jike,
                  child: Text('请求数据'),
                ),
                Text(showText)
              ]
            ),
          )
        ),
      );
    }
  }
  void _jike(){
    print('开始请求数据');
    setState(() {
      _loading = !_loading;
    });
    getHttp().then((val){
      setState(() {
        showText=val['data'].toString();
      });
      _onRefresh();
    });
  }

  Future getHttp()async{
    try{
      Response response;
      Dio dio = new Dio();
      dio.options.headers = httpHeader;
      response = await dio.get("https://time.geekbang.org/serv/v1/column/newAll");
      // print(response.data);
      return response.data;
    }catch(e){
      print(e);
    }
  }
  Future<Null> _onRefresh() async {
    await Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _loading = !_loading;
        Fluttertoast.showToast(
          msg: "加载完成！",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
        );
      });
    });
  }
}