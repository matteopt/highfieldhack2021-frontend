import 'package:flutter/material.dart';

class FriendRequest extends StatelessWidget {

  FriendRequest({Key key, @required this.refreshCallback, @required this.myOwn});

  final VoidCallback refreshCallback;
  final bool myOwn;

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
              if (myOwn)
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
              if (!myOwn)
              Text(
                "PENDING",
                style: TextStyle(
                  color: Colors.black45
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

class FriendTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blue,
              backgroundImage: NetworkImage("https://yt3.ggpht.com/EdjnobpzppDl5pSVU2s2AUIiFS0qBfT8Jdodw-FHMhugJK5zmzWDLkpqDVtpnaLSP66M5F8nqINImLKGtQ=s900-nd-c-c0xffffffff-rj-k-no"),
            ),
            SizedBox(width: 10,),
            Text("69HEALTHYDOGE69", style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          FlatButton(
            onPressed: () {},
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Text(
              "CHALLENGE",
              style: TextStyle(
                color: Colors.blue
              ),
            ),
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
                          FriendRequest(refreshCallback: refresh, myOwn: true,),
                          Divider(indent: 40, endIndent: 40, height: 1, thickness: 1,),
                        ],
                      );
                    if (index >= 3 && index < 5)
                      return Column(
                        children: <Widget>[
                          FriendRequest(refreshCallback: refresh, myOwn: false,),
                          if (index < 4)
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

              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index < 3)
                      return Column(
                        children: <Widget>[
                          FriendTile(),
                          if (index < 2)
                            Divider(indent: 40, endIndent: 40, height: 1, thickness: 1,),
                        ],
                      );
                    return null;
                  }
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}