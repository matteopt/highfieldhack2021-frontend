import 'package:flutter/material.dart';
import 'package:healthyapp/navbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  int _index = 0;
  List<Widget> _pages = [
    Container(color: Colors.blue),
    Container(color: Colors.white),
  ];

  PageController _pageController;
  ValueNotifier<double> _pageScrollNotifier;

  _pageJumpCallback(int index) {
    _pageController.animateToPage(index, duration: Duration(milliseconds: 1000), curve: Curves.fastLinearToSlowEaseIn);
  }

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: _index);
    _pageScrollNotifier = ValueNotifier<double>(0.0);

    _pageController.addListener(() {
      _pageScrollNotifier.value = _pageController.page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: _pages,
        controller: _pageController,
        onPageChanged: (index) {
            setState(() {
              _index = index;
            });
          },
      ),
      bottomNavigationBar: NavBar(
        pageJumpCallback: _pageJumpCallback,
        pageScrollNotifier: _pageScrollNotifier,
      ),
    );
  }
}