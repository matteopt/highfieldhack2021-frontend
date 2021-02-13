import 'package:flutter/material.dart';

class NavBarItem extends StatefulWidget {
  final int index;
  final ValueNotifier<double> pageScrollNotifier;
  final Function(int) pageJumpCallback;
  final String labelText;
  final IconData icon;
  final Color color;

  NavBarItem({
    Key key,
    @required this.index,
    @required this.pageScrollNotifier,
    @required this.pageJumpCallback,
    @required this.labelText,
    @required this.icon,
    @required this.color,
  });

  @override
  NavBarItemState createState() => NavBarItemState();
}

class NavBarItemState extends State<NavBarItem> {
  
  bool _selected = true;
  double _width = 125.0;
  double _opacity = 0.25;
  double _iconOpacity = 1.00;
  double _textOpacity = 1.00;
  double _leftPadding = 25.0;

  void _onPageScroll() {
    double offset = (widget.pageScrollNotifier.value - widget.index).abs();

    if (offset > 1.0) offset = 1.0;

    setState(() {
      _selected = offset < 0.5;
      _width = 125.0 - (offset * 75.0);
      _opacity = 0.25 - (offset * 0.25);
      _iconOpacity = 1.00 - (offset);

      _textOpacity = 1.00 - (offset * 4.0);
      if (_textOpacity < 0.0) _textOpacity = 0.0;

      _leftPadding = 25.0 - (offset * 12.5);
    });
  }

  @override
  void initState() {
    super.initState();

    _onPageScroll();

    widget.pageScrollNotifier.addListener(() {
      _onPageScroll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      clipBehavior: Clip.antiAlias,
      color: widget.color.withOpacity(_opacity),
      child: InkWell(
        highlightColor: _selected
            ? widget.color.withOpacity(0.25)
            : Colors.black.withOpacity(0.1),
        splashColor: _selected
            ? widget.color.withOpacity(0.5)
            : Colors.black.withOpacity(0.25),
        onTap: () {
          widget.pageJumpCallback(widget.index);
        },
        child: Container(
          width: _width,
          height: 50,
          padding: EdgeInsets.only(left: _leftPadding, right: 25),
          child: Stack(
            overflow: Overflow.clip,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Stack(
                  children: <Widget>[
                    Icon(
                      widget.icon,
                      size: 25,
                    ),
                    Icon(
                      widget.icon,
                      color: widget.color.withOpacity(_iconOpacity),
                      size: 25,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  widget.labelText,
                  style: TextStyle(
                    color: widget.color.withOpacity(_textOpacity),
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          clipBehavior: Clip.antiAlias,
        ),
      ),
    );
  }
}

class NavBar extends StatefulWidget {
  final ValueNotifier<double> pageScrollNotifier;
  final Function(int) pageJumpCallback;
  NavBar({
    Key key,
    @required this.pageScrollNotifier,
    @required this.pageJumpCallback,
  });

  @override
  NavBarState createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  
  double _rightPadding = 0.0;

  void _onPageScroll() {
    double tmp = widget.pageScrollNotifier.value;
    if (tmp > 1) tmp = 1;

    // setState(() {
    //   _rightPadding = 75.0 - (tmp * 75.0);
    // });
  }

  @override
  void initState() {
    super.initState();

    _onPageScroll();

    widget.pageScrollNotifier.addListener(() {
      _onPageScroll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 10,
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.only(right: _rightPadding),
        color: Colors.transparent,
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            NavBarItem(
              index: 0,
              pageScrollNotifier: widget.pageScrollNotifier,
              pageJumpCallback: widget.pageJumpCallback,
              icon: Icons.graphic_eq,
              labelText: 'Stats',
              color: Colors.blue,
            ),
            NavBarItem(
              index: 1,
              pageScrollNotifier: widget.pageScrollNotifier,
              pageJumpCallback: widget.pageJumpCallback,
              icon: Icons.people,
              labelText: 'Social',
              color: Colors.blue,
            ),
            NavBarItem(
              index: 2,
              pageScrollNotifier: widget.pageScrollNotifier,
              pageJumpCallback: widget.pageJumpCallback,
              icon: Icons.leaderboard_rounded,
              labelText: 'Ranks',
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
