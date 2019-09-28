import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CarPage extends StatefulWidget {
  _CarPageState createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  // const HomePage({Key key}) : super(key: key);
  bool _loading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_childLayout()
    );
  }
  Widget _childLayout() {
    if (_loading) {
       return Center(
        child: Container(
          child:CircularProgressIndicator(),
          // Text('显示加载动画'),
        )
      );
    } else {
     return Center(
        child: RaisedButton(
          onPressed: () => _onRefresh(),
          child: Text('显示加载动画'),
        ),
      );
    }
  }

  Future<Null> _onRefresh() async {
    setState(() {
      _loading = !_loading;
    });
    await Future.delayed(Duration(seconds: 2), () {
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