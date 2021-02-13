import 'package:flutter/material.dart';
import 'package:healthyapp/login.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with TickerProviderStateMixin {

  final _usernameFocusNode = FocusNode();
  final _usernameController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _emailController = TextEditingController();

  AnimationController _animationController;
  Animation _animation;
  double _height = 130.0;

  void _focusHandler() {
    if (_usernameFocusNode.hasFocus || _passwordFocusNode.hasFocus || _emailFocusNode.hasFocus) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _animation = Tween<double>(begin: 0.0, end: 80.0).chain(CurveTween(curve: Curves.ease)).animate(_animationController)..addListener(() {
      setState(() {
        _height = 130.0 - _animation.value;
      });
    });
    _usernameFocusNode.addListener(_focusHandler);
    _passwordFocusNode.addListener(_focusHandler);
    _emailFocusNode.addListener(_focusHandler);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("I'm already a member. ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
              GestureDetector(
                child: Text("Sign in.", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue),),
                onTap: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                }
              )
            ],
          )
        ),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 25, right: 25, top: 100),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create Account,",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 30,
                color: Colors.black,
              ),
            ),
            Text(
              "Sign up to get started!",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 25,
                color: Colors.black45,
              ),
            ),
            SizedBox(
              height: _height,
            ),
            TextFormField(
              focusNode: _emailFocusNode,
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                contentPadding: EdgeInsets.fromLTRB(30,20,30,20),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide(color: Colors.grey)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              focusNode: _usernameFocusNode,
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: "Username",
                contentPadding: EdgeInsets.fromLTRB(30,20,30,20),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide(color: Colors.grey)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              focusNode: _passwordFocusNode,
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                contentPadding: EdgeInsets.fromLTRB(30,20,30,20),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide(color: Colors.grey)),
              ),
            ),
            SizedBox(
              height: 50,
            ),          
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                color: Colors.blue,
                onPressed: () {},
                elevation: 5,
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
              ),
            ),
          ],
        ),
      ),
    );
    
  }
}
