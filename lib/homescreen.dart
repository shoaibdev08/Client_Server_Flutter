import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class display extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<display> {
  final String apiUrl = "http://localhost/flutter_api/get_posts.php";
  List<dynamic> _posts = [];

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          _posts = json.decode(response.body);
        });
      } else {
        print('Failed to load posts: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading posts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ALL Posts'),
      ),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_posts[index]['title']),
            subtitle: Text(_posts[index]['body']),
          );
        },
      ),
    );
  }
}
