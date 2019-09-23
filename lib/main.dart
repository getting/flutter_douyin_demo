import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:marquee_flutter/marquee_flutter.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "某音",
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: Colors.black),
          child: Stack(children: [
            VideoBack(),
            Home(),
          ]),
        ),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(color: Colors.black),
            child: SafeArea(
                child: BottomAppBar(
              child: Container(
                decoration: BoxDecoration(color: Colors.black),
                height: 60,
                // decoration: BoxDecoration(color: Colors.black),
                child: BtmBar(),
              ),
            ))),
      ),
    );
  }
}

class VideoBack extends StatefulWidget {
  VideoBack({Key key}) : super(key: key);

  _VideoBackState createState() => _VideoBackState();
}

class _VideoBackState extends State<VideoBack> {
  VideoPlayerController _controller;
  bool _isPlaying = false;
  String url =
      "https://www.guojio.com/video/07a7faa1-3696-4af7-aeac-2d6cf6bf25f9.mp4";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.network(this.url)
      // 播放状态
      ..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      })
      // 在初始化完成后必须更新界面
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _controller.value.initialized
          // 加载成功
          ? new AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : new Container(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(children: [
      Positioned(
        top: 0,
        // height: 120,
        width: screenWidth,
        child: SafeArea(
            child: Container(
          // decoration: BoxDecoration(color: Colors.pinkAccent),
          child: TopTab(),
        )),
      ),
      Positioned(
        bottom: 0,
        width: 0.70 * screenWidth,
        height: 140,
        child: Container(
          // decoration: BoxDecoration(color: Colors.redAccent),
          child: BtnContent(),
        ),
      ),
      Positioned(
        right: 0,
        width: 0.2 * screenWidth,
        height: 0.37 * screenHeight,
        top: 0.4 * screenHeight,
        child: Container(
          // decoration: BoxDecoration(color: Colors.orangeAccent),
          child: getButtonList(),
        ),
      ),
      Positioned(
        bottom: 10,
        right: 0,
        width: 0.2 * screenWidth,
        height: 0.2 * screenWidth,
        child: Container(
          width: 20,
          height: 20,
          // decoration: BoxDecoration(color: Colors.purpleAccent),
          child: RotateAlbum(),
        ),
      )
    ]);
  }
}

class TopTab extends StatefulWidget {
  TopTab({Key key}) : super(key: key);

  _TopTabState createState() => _TopTabState();
}

class _TopTabState extends State<TopTab> with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(vsync: this, length: 2, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 10,
        ),
        Icon(
          Icons.search,
          size: 30,
          color: Colors.white,
        ),
        Container(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 50),
                width: 280,
                child: TabBar(
                  indicatorColor: Colors.white,
                  labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                  indicatorPadding: EdgeInsets.symmetric(horizontal: 30),
                  unselectedLabelStyle:
                      TextStyle(color: Colors.grey[700], fontSize: 18),
                  controller: _controller,
                  tabs: <Widget>[Text("关注"), Text("推荐")],
                ))),
        Icon(
          Icons.live_tv,
          size: 30,
          color: Colors.white,
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
}

class BtmBar extends StatelessWidget {
  const BtmBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          getBtmTextWidget("首页", true),
          getBtmTextWidget("同城", false),
          AddIcon(),
          getBtmTextWidget("消息", false),
          getBtmTextWidget("我", false),
        ],
      ),
    );
  }
}

getBtmTextWidget(String content, bool ifSelected) {
  return Text("$content",
      style: ifSelected
          ? TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold)
          : TextStyle(fontSize: 16, color: Colors.grey[600],fontWeight: FontWeight.bold));
}

class AddIcon extends StatelessWidget {
  const AddIcon({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double iconHeight=30;
    double totalWidth=50;
    double eachSide=3;
    return Container(
      // decoration: BoxDecoration(),
      height: iconHeight,
      width: 50,
      child: Stack(
        children: <Widget>[
          Positioned(
            height: iconHeight,
            width: totalWidth-eachSide,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.cyan, borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Positioned(
            height: iconHeight,
            width: totalWidth-eachSide,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Positioned(
            height: iconHeight,
            width: totalWidth-eachSide*2,
            right: eachSide,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

class BtnContent extends StatelessWidget {
  const BtnContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(
              "@人民日报",
              style: TextStyle(color: Colors.white,fontSize: 16),
            ),
            subtitle: Text(
              "奥斯卡答复哈士大夫哈师大发输电和健康阿萨德鸿福路口氨基酸的鸿福路口啊,奥斯卡答复哈士大夫哈师大发输电和健康阿萨德鸿福路口氨基酸的鸿福路口啊",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Icon(Icons.music_note,color: Colors.white,),
              // Marquee(text: "",),
              
                Container(
                  width: 200,
                  height: 20,
                  child: MarqueeWidget(
                    text: '人民日报创作的一些比较有意思的东西',
                    textStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16),
                    // scrollAxis: Axis.horizontal,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // blankSpace: 20.0,
                    // velocity: 100.0,
                    // pauseAfterRound: Duration(seconds: 1),
                    // startPadding: 10.0,
                    // accelerationDuration: Duration(seconds: 1),
                    // accelerationCurve: Curves.linear,
                    // decelerationDuration: Duration(milliseconds: 500),
                    // decelerationCurve: Curves.easeOut,
                  )
                )
              
            ],
          )
        ],
      ),
    );
  }
}

class RotateAlbum extends StatefulWidget {
  RotateAlbum({Key key}) : super(key: key);

  _RotateAlbumState createState() => _RotateAlbumState();
}

class _RotateAlbumState extends State<RotateAlbum>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  var animation;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    animation = RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller)
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            // _controller.forward(from: 0.0);
          }
        }),
      child: Container(
          child: CircleAvatar(
        backgroundImage: NetworkImage(
            "https://gss1.bdstatic.com/9vo3dSag_xI4khGkpoWK1HF6hhy/baike/s%3D500/sign=dde475320ee9390152028d3e4bec54f9/d009b3de9c82d1586d8294a38f0a19d8bc3e42a4.jpg"),
      )),
    );
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      child: animation,
    );
  }
}

getButtonList() {
  double iconSize=40;
  return Column(

    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      Container(
          width: 60,
          height: 70,
          child: Stack(
            children: <Widget>[
              Container(
                  width: 60,
                  height: 60,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://pic2.zhimg.com/v2-a88cd7618933272ca681f86398e6240d_xll.jpg"),
                  )),
              Positioned(
                bottom: 0,
                left: 17.5,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(25)),
                  child: Icon(
                    Icons.add,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          )),
      IconText(
        text: "999w",
        icon: Icon(
          Icons.favorite,
          size: iconSize,
          color: Colors.redAccent,
        ),
      ),
      IconText(
        text: "999w",
        icon: Icon(
          Icons.feedback,
          size: iconSize,
          color: Colors.white,
        ),
      ),
      IconText(
        text: "999w",
        icon: Icon(
          Icons.reply,
          size: iconSize,
          color: Colors.white,
        ),
      ),
    ],
  );
}

class IconText extends StatelessWidget {
  const IconText({Key key, this.icon, this.text}) : super(key: key);
  final Icon icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          icon,
          Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
