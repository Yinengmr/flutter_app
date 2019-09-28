import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // 屏幕适配

import './car_page.dart';
import './category_page.dart';
import './home_page.dart';
import './member_page.dart';


// class IndexPage extends StatelessWidget {
//   @override
  // Widget build(BuildContext content) {
  //   return Scaffold(
  //     appBar: AppBar(title: Text('百姓生活+')),
  //     body:Center(
  //       child:  Text('百姓生活'),
  //     )
  //   );
  // }
  // }
  // stful
  class IndexPage extends StatefulWidget {
    @override
    _IndexPageState createState() => _IndexPageState();
  }
  
  class _IndexPageState extends State<IndexPage> {
    final List<BottomNavigationBarItem> bottomTabs = [
      BottomNavigationBarItem(
        icon:Icon(CupertinoIcons.home),
        title:Text('首页')
      ),
      BottomNavigationBarItem(
        icon:Icon(CupertinoIcons.search),
        title:Text('分类')
      ),
      BottomNavigationBarItem(
        icon:Icon(CupertinoIcons.shopping_cart),
        title:Text('购物车')
      ),
      BottomNavigationBarItem(
        icon:Icon(CupertinoIcons.profile_circled),
        title:Text('会员中心')
      )
    ];

    final List tabBoies = [
      HomePage(),
      CategoryPage(),
      CarPage(),
      MemberPage(),
    ];

    int currentIndex = 0;
    var currentPage;
    
  @override
    void initState() {
      currentPage = tabBoies[currentIndex];
      super.initState();
    }
    @override
    Widget build(BuildContext context) {
      ScreenUtil.instance = ScreenUtil(width:750,height:1334)..init(context); // 设置屏幕尺寸
      return Scaffold(
        backgroundColor: Color.fromRGBO(244, 244, 245, 1.0),
        bottomNavigationBar: BottomNavigationBar(
          type:BottomNavigationBarType.fixed,
          currentIndex:currentIndex,
          items:bottomTabs,
          onTap:(index){
            setState(() {
             currentIndex=index;
             currentPage= tabBoies[currentIndex];
            });
          },
         
        ),
        // appBar: AppBar(title: Text('哈哈')),
        body:currentPage
      );
    }
  }
