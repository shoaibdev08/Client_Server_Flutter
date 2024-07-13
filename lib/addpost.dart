import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_xampp_app/display2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'homescreen.dart';


class addpost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<addpost> {
  final String apiUrl = "http://localhost/flutter_api/get_posts.php";
  List<dynamic> _posts = [];

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    var result = await http.get(Uri.parse(apiUrl));
    setState(() {
      _posts = json.decode(result.body);
    });
  }

  Future<void> addPost(String title, String body) async {
    var result = await http.post(
      Uri.parse('http://localhost/flutter_api/add_post.php'),
      body: {
        'title': title,
        'body': body,
      },
    );
    if (result.statusCode == 200) {
      fetchPosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController bodyController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
      ),
      backgroundColor: Colors.grey[200], // Background color
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Write Your Post",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: bodyController,
              decoration: InputDecoration(
                labelText: "Body",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                addPost(titleController.text, bodyController.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DisplayPosts()), // Navigate to Display screen after adding post
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
              ),
              child: Text(
                "Add Post",
                style: TextStyle(fontSize: 18,color: Colors.blueGrey )
                ,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
