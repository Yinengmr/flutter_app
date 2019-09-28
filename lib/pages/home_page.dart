import 'package:flutter/material.dart';
import 'package:flutter_app/service/service_method.dart';  // http方法
import 'package:flutter_swiper/flutter_swiper.dart';  // 轮播插件
import 'dart:convert'; // json支持
import 'package:flutter_screenutil/flutter_screenutil.dart'; // 屏幕适配
import 'package:url_launcher/url_launcher.dart';


class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print('第一次获取数据');
  }

  String homePageContent = '正在获取数据';

  // @override 
  // void initState() {
  //   getHomePageContent().then((val){
  //     setState(() {
  //       homePageContent=val.toString(); 
  //     });
  //     print('=====>>>>> ok');
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('百姓生活+'),),
      body:FutureBuilder( // 解决异步渲染
        future: getHomePageContent(),
        builder: (context,snapshot){
          if(snapshot.hasData){ // .hasDate判断是否有值
            var data = json.decode(snapshot.data.toString());

            List<Map> swiper = (data['data']['slides'] as List).cast();
            List<Map> navigatorList = (data['data']['category'] as List).cast();

            String adPicture = data['data']['advertesPicture']['PICTURE_ADDRESS'];
            String leaderImage = data['data']['shopInfo']['leaderImage'];
            String leaderPhone = data['data']['shopInfo']['leaderPhone'];
            List<Map> recommendList = (data['data']['recommend'] as List).cast();

            return SingleChildScrollView(
              child:Column(
                children: <Widget>[
                  // 放入组件（部件）
                  SwiperDiy(swiperDataList: swiper),
                  TopNavigator(navigatorList:navigatorList),
                  AdBanner(adPicture:adPicture),
                  
                  LeaderPhone(leaderImage:leaderImage,leaderPhone:leaderPhone),
                  Recommend(recommendList:recommendList),
                ],
                
              ),
            );
            
            
          }else{
            return Center(
              child: Container(
                // 加载动画组件
                child: CircularProgressIndicator(
                  // strokeWidth: 4.0,
                  // backgroundColor: Color(0xffff0000),
                ),
              ),
            );
          }
        },
      )
    );
  }
}

// 首页轮播组件
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  // SwiperDiy({Key key,this.swiperDataList}):super(key:key); //写法一（官方实例）
  SwiperDiy({this.swiperDataList});  // 写法二
  @override
  Widget build(BuildContext context) {
    // ScreenUtil.instance = ScreenUtil(width:750,height:1334)..init(context); // 设置屏幕尺寸 
    // print('设备像素密度:${ScreenUtil.pixelRatio}');
    // print('设备高:${ScreenUtil.screenHeight}');
    // print('设备宽:${ScreenUtil.screenWidth}');
    return Container(
      height:ScreenUtil().setHeight(333),
      width:ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          return Image.network(
            "${swiperDataList[index]['image']}",
            fit: BoxFit.fill,  // 高度填充
          );
        },
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      )
    );
  }
}

// 导航栏部件
class TopNavigator extends StatelessWidget {
  final List navigatorList;

  TopNavigator({this.navigatorList});

  Widget _gridViewItemUI(BuildContext content,item){
    return InkWell(
      onTap: (){print('点击了导航');},
      child: Column(
        children: <Widget>[
          Image.network(item['image'],width:ScreenUtil().setWidth(95)),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 只显示10个导航item
    if(this.navigatorList.length>10){
      this.navigatorList.removeRange(10, this.navigatorList.length);
    }
    return Container(
      height:ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children:navigatorList.map((item){
          return _gridViewItemUI(context,item);
        }).toList()
      ),
    );
  }
}

// 图片广告
class AdBanner extends StatelessWidget {

  final String adPicture;

  AdBanner({this.adPicture});
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Image.network(adPicture),
    );
  }
}

// 店长电话模块
class LeaderPhone extends StatelessWidget {
  final String leaderImage;
  final String leaderPhone;

  LeaderPhone({this.leaderImage,this.leaderPhone});
  @override
  Widget build(BuildContext context) {
    return Container(
      child:InkWell(
        onTap:_launchURL,
        child:Image.network(leaderImage)
      )
    );
  }
  // 打开URL 内部方法
  void _launchURL() async{
    String url = 'tel:'+leaderPhone;
    // String url = 'sms:13469943405';
    // String url = 'mailto:cyn.cheng@qq.com';
    if (await canLaunch(url)) {
      await launch(url);
    }else{
      throw 'url不能进行访问，异常';
    }
  }
}

// 商品推荐
class Recommend extends StatelessWidget {
  final List recommendList;

  Recommend({this.recommendList});

  // 标题
  Widget _titleWidget(){
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 5.0, 0, 5.0),
      decoration: BoxDecoration(
        color:Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.5,color:Colors.black12)
          )
      ),
      child: Text(
        '商品推荐',
        style: TextStyle(
          color: Colors.pink
        ),
      ),
    );
  }
 
  // 商品单独项方法
  Widget _item(index){
    return InkWell(
      onTap: (){
        print(index);
      },
      child:Container(
        height:ScreenUtil().setHeight(330),
        width:ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color:Colors.white,
          border: Border(
            left:BorderSide(width:0.5,color:Colors.black12)
          )
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥ ${recommendList[index]['mallPrice']}'),
            Text(
              '￥ ${recommendList[index]['price']}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 横向列表方法
  Widget _recommendList(){
    return Container(
      height:ScreenUtil().setHeight(330),
      child:ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (content,index){
          return _item(index);
        },
      )
    );
  }
  // Widget _ww(){
  //   return Column(
  //     children: <Widget>[
  //       _titleWidget(),
  //       _recommendList()
  //     ],
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Container(
      height:ScreenUtil().setHeight(390),
      margin: EdgeInsets.only(top:10.0),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommendList()
        ],
      ),
    );
  }
}