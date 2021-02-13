import 'package:flutter/material.dart';

class FriendRequest extends StatelessWidget {

  FriendRequest({Key key, @required this.refreshCallback});

  final VoidCallback refreshCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blue,
              backgroundImage: NetworkImage("https://i.redd.it/3h830ttao8341.jpg"),
            ),
            SizedBox(width: 10,),
            Text("Cute doggo 420", style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 40,
                height: 40,
                child: MaterialButton(
                  onPressed: () {
                    this.refreshCallback();
                  },
                  shape: CircleBorder(),
                  child: Icon(Icons.check, color: Colors.white,),
                  color: Colors.blue,
                  padding: EdgeInsets.all(5),
                ),
              ),
              SizedBox(width: 10,),
              SizedBox(
                width: 40,
                height: 40,
                child: MaterialButton(
                  elevation: 1,
                  highlightElevation: 5,
                  onPressed: () {
                    this.refreshCallback();
                  },
                  shape: CircleBorder(),
                  child: Icon(Icons.clear, color: Colors.grey,),
                  color: Colors.white,
                  padding: EdgeInsets.all(5),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class SocialPage extends StatefulWidget {
  @override
  _SocialPageState createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {

  void refresh() {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, size: 25,),
      ),
      body: Container(
        color: Colors.white,
        child: RefreshIndicator(
          strokeWidth: 2.5,
          onRefresh: () {  return Future<void>(null); },
          child: CustomScrollView(
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            slivers: <Widget>[
              
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 40,),
                      Text(
                        "Your friend requests",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              ),

              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index < 3)
                      return Column(
                        children: <Widget>[
                          FriendRequest(refreshCallback: refresh,),
                          if (index < 2)
                            Divider(indent: 40, endIndent: 40, height: 1, thickness: 1,),
                        ],
                      );
                    return null;
                  }
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10,),
                      Text(
                        "Your friends",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}