  import 'dart:convert';
  import 'package:flutter/material.dart';
  import 'package:flutter_xampp_app/addpost.dart';
  import 'package:http/http.dart' as http;

  class LoginScreen extends StatefulWidget {
    @override
    _LoginScreenState createState() => _LoginScreenState();
  }

  class _LoginScreenState extends State<LoginScreen> {
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    Future<void> _login() async {
      final String username = _usernameController.text;
      final String password = _passwordController.text;

      final url = Uri.parse('http://localhost/flutter_api/login.php');
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({
        'username': username,
        'password': password,
      });

      try {
        final response = await http.post(url, headers: headers, body: body);

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login successful.')),
          );
          // Navigate to add post screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => addpost()),
          );
        } else if (response.statusCode == 401) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invalid password.')),
          );
        } else if (response.statusCode == 404) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User not found.')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed: ${response.body}')),
          );
        }
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        backgroundColor: Colors.blueGrey[50], // Background color
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade200, Colors.purple.shade50],// Gradient colors
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.account_circle,
                    size: 100,
                    color: Colors.deepPurple,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _login();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
