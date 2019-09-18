import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/config/httpHeader.dart';

import '../config/httpHeader.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String showText = '还没有请求数据';
  @override
  Widget build(BuildContext context) {
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
  void _jike(){
    print('开始请求数据');
    getHttp().then((val){
      setState(() {
        showText=val['data'].toString();
      });
    });
  }

  Future getHttp()async{
    try{
      Response response;
      Dio dio = new Dio();
      dio.options.headers = httpHeader;
      response = await dio.get("https://time.geekbang.org/serv/v1/column/newAll");
      print(response.data);
      return response.data;
    }catch(e){
      print(e);
    }
  }
}