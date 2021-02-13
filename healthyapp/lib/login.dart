import 'package:flutter/material.dart';
import 'package:healthyapp/home.dart';
import 'package:healthyapp/register.dart';
import 'package:healthyapp/requests.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {

  final _usernameFocusNode = FocusNode();
  final _usernameController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  final _passwordController = TextEditingController();

  AnimationController _animationController;
  Animation _animation;
  double _height = 130.0;

  bool _loading = false;

  void _focusHandler() {
    if (_usernameFocusNode.hasFocus || _passwordFocusNode.hasFocus) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("I'm a new user. ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
              GestureDetector(
                child: Text("Sign up.", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue),),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                }
              )
            ],
          )
        ),
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[

          Padding(
            padding: EdgeInsets.only(left: 25, right: 25, top: 100),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome,",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Sign in to Healthy App!",
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
                    onPressed: () async {
                      String username = _usernameController.text;
                      String password = _passwordController.text;
                      
                      setState(() {
                        _loading = true;
                      });
                      
                      http.Response response = await loginUser(username, password);
                      
                      setState(() {
                        _loading = false;
                      });

                      if (response.body == '1') {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
                      } else if (response.body == '0') {
                        return showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("The details used are incorrect."),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          }
                        );
                      }
                    },
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

          if (_loading)
            Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            ),

        ],
      ),
    );
  }
}
