import 'package:flutter/material.dart';


class LeaderboardPage extends StatefulWidget {
  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {

  ScrollController _scrollController;
  ValueNotifier<double> _scrollNotifier;

  double _expandedHeight = 250;
  double _parallax = 0;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollNotifier = ValueNotifier<double>(0.0);
    _scrollController.addListener(() {
      _scrollNotifier.value = _scrollController.position.pixels;
      setState(() {
        if (_scrollController.position.pixels < 0) {
          _expandedHeight = 250 - _scrollController.position.pixels;
          _parallax = 0;
        } else {
          _expandedHeight = 250;
          _parallax = -(_scrollController.position.pixels * 0.5);
        }
      });
    });
  }

  @override
   Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              top: _parallax,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Image.network('https://image.freepik.com/free-vector/business-goal-achievement-illustration-success-people-cartoon-stage-place-podium-with-competition-trophy_109722-1941.jpg', fit: BoxFit.cover, color: Colors.black.withOpacity(0.5), colorBlendMode: BlendMode.srcATop,),
                height: _expandedHeight,
              ),
            ),
            RefreshIndicator(
              strokeWidth: 2.5,
              onRefresh: () {  return Future<void>(null); },
              child: CustomScrollView(
                physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                controller: _scrollController,
                slivers: <Widget>[

                  SliverToBoxAdapter(
                    child: Container(
                      color: Colors.transparent,
                      height: 250,
                      padding: EdgeInsets.fromLTRB(20, 60, 20, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            ' Leaderboards',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 15,)
                        ],
                      ),
                    ),
                  ),

                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Column(
                        children: [
                          SizedBox(height: 5),
                          Container(
                            height: 100,
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      backgroundImage: NetworkImage('https://pbs.twimg.com/media/D4SR_cEXkAA98D4.jpg'),
                                      radius: 30,
                                    ),
                                    SizedBox(width: 20,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Username",
                                          style: TextStyle(
                                            fontSize: 18
                                          ),
                                        ),
                                        Text(
                                          "Subtitle",
                                          style: TextStyle(
                                            color: Colors.black45
                                          )
                                        ),
                                      ],
                                    ),
                                  ]
                                ),
                                if (medal(index) != null)
                                  SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: Image(image: medal(index))
                                  )
                              ],
                            )
                          ),
                          SizedBox(height: 5),
                          Divider(indent: 40, endIndent: 40, height: 1, thickness: 1,),
                        ],
                      );
                    }),
                  )
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }

  NetworkImage medal(int index) {
    switch (index) {
      case 0:
        return NetworkImage('https://files.catbox.moe/e0bpox.png');
        break;
      case 1:
        return NetworkImage('https://files.catbox.moe/n1c2xh.png');
      case 2:
        return NetworkImage('https://files.catbox.moe/qoqno7.png');
      default:
        return null;
    }
  }
}
