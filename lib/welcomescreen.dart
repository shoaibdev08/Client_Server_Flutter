import 'package:flutter/material.dart';
import 'package:flutter_xampp_app/signupscreen.dart';
import 'package:flutter_xampp_app/loginscreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE0EAFC), Color(0xFFF5E9F7)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.deepPurpleAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    elevation: 5,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    padding: EdgeInsets.all(0),
                    textStyle: TextStyle(fontSize: 20),
                    animationDuration: Duration(milliseconds: 200),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      gradient: LinearGradient(
                        colors: [Colors.deepPurpleAccent.withOpacity(0.8), Colors.deepPurple],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Login',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    elevation: 5,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    padding: EdgeInsets.all(0),
                    textStyle: TextStyle(fontSize: 20),
                    animationDuration: Duration(milliseconds: 200),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      gradient: LinearGradient(
                        colors: [Colors.deepPurple.withOpacity(0.8), Colors.deepPurpleAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Sign Up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
