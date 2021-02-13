import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthyapp/requests.dart';
import 'package:http/http.dart' as http;

class FriendRequest extends StatelessWidget {

  FriendRequest({Key key, @required this.username, @required this.refreshCallback, @required this.myOwn});

  final String username;
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
            Text(this.username, style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (!myOwn)
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
              if (myOwn)
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

  SocialPage({Key key, @required this.username});

  final String username;
}

class _SocialPageState extends State<SocialPage> {

  List<String> _requestsToMe = [];
  List<String> _requestsFromMe = [];

  Future<void> refresh() async {
    http.Response response1 = await getFriendRequestsReceived(widget.username);
    http.Response response2 = await getFriendRequestsSent(widget.username);

    print(response1.body);
    print(response2.body);

    if (response1.body == '518' || response1.body == '517') {
      setState(() {
        _requestsToMe = [];
      });
    } else {
      setState(() {
        _requestsToMe = response1.body.split(" ");
      });
    }

    if (response2.body == '519' || response2.body == '520') {
      setState(() {
        _requestsFromMe = [];
      });
    } else {
      setState(() {
        _requestsFromMe = response2.body.split(" ");
      });
    }

    return;
  }

  @override
  void initState() {
    super.initState();

    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          return showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              TextEditingController _tc = TextEditingController();
              return AlertDialog(
                title: Text("Enter a username"),
                content: TextField(
                  controller: _tc,
                  decoration: InputDecoration(
                    labelText: "Username",
                    contentPadding: EdgeInsets.fromLTRB(30,20,30,20),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide(color: Colors.grey)),
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("SEND REQUEST"),
                    onPressed: () async {
                      http.Response response = await addFriend(widget.username, _tc.text);
                      print(response.body);
                      Navigator.of(context).pop();
                      refresh();
                    },
                  )
                ],
              );
            }
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, size: 25,),
      ),
      body: Container(
        color: Colors.white,
        child: RefreshIndicator(
          strokeWidth: 2.5,
          onRefresh: () {  return refresh(); },
          child: CustomScrollView(
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            slivers: <Widget>[

              SliverToBoxAdapter(
                child: SizedBox(height: 30,),
              ),
              
              if (_requestsToMe.isNotEmpty || _requestsFromMe.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10,),
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

              if (_requestsToMe.isNotEmpty || _requestsFromMe.isNotEmpty)
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index < _requestsToMe.length) {
                        return Column(
                          children: <Widget>[
                            FriendRequest(
                              username: _requestsToMe[index],
                              refreshCallback: refresh,
                              myOwn: false
                            ),
                            if (index < _requestsToMe.length + _requestsFromMe.length - 1)
                              Divider(indent: 40, endIndent: 40, height: 1, thickness: 1),
                          ],
                        );
                      } else if (index < _requestsToMe.length + _requestsFromMe.length) {
                        return Column(
                          children: <Widget>[
                            FriendRequest(
                              username: _requestsFromMe[index - _requestsToMe.length],
                              refreshCallback: refresh,
                              myOwn: true
                            ),
                            if (index < _requestsToMe.length + _requestsFromMe.length - 1)
                              Divider(indent: 40, endIndent: 40, height: 1, thickness: 1),
                          ],
                        );
                      }
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