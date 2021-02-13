import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();

  double progress = 36.2;
  int goal = 50;
}

class _TaskPageState extends State<TaskPage> {

  double _iconRadius = 40.0;
  String _title = "Run 50 miles.";
  String _iconUrl = "https://files.catbox.moe/mukn0p.png";
  Size _progressSize;

  @override
  Widget build(BuildContext context) {

    _progressSize = (TextPainter(
        text: TextSpan(text: widget.progress.toString(), style: TextStyle(fontWeight: FontWeight.w600)),
        maxLines: 1,
        textScaleFactor: MediaQuery.of(context).textScaleFactor,
        textDirection: TextDirection.ltr)
      ..layout())
    .size;

    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            SizedBox(height: 100,),
            Hero(
              tag: "hemlo",
              child: Material(
                color: Colors.transparent,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        backgroundImage: NetworkImage(_iconUrl),
                        radius: _iconRadius,
                      ),
                      SizedBox(width: 20),
                      Container(
                        height: _iconRadius * 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _title,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "Ends on 25/02/2021",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Colors.black45
                              ),
                            ),
                            SizedBox(height: 10),
                            Stack(
                              children: <Widget>[
                                Container(
                                  height: 10,
                                  width: MediaQuery.of(context).size.width - 40 - _iconRadius * 2 - 20,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.grey[300]),
                                ),
                                Container(
                                  height: 10,
                                  width: widget.progress * (MediaQuery.of(context).size.width - 40 - _iconRadius * 2 - 20) / widget.goal,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.blue[300]),
                                ),
                              ],
                            ),
                            Container(
                              height: 20,
                              width: MediaQuery.of(context).size.width - 40 - _iconRadius * 2 - 20,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    left: widget.progress * (MediaQuery.of(context).size.width - 40 - _iconRadius * 2 - 20 - _progressSize.width) / widget.goal,
                                    child: Text(widget.progress.toString(), style: TextStyle(fontWeight: FontWeight.w600)),
                                  )
                                  //Text("0", style: TextStyle(fontWeight: FontWeight.w600),),
                                  //Align(alignment: Alignment.centerRight, child: Text(widget.amount.toString(), style: TextStyle(fontWeight: FontWeight.w600),),)
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }
}