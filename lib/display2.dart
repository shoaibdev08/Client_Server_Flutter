import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DisplayPosts extends StatefulWidget {
  @override
  _DisplayPostsState createState() => _DisplayPostsState();
}

class _DisplayPostsState extends State<DisplayPosts> {
  final String apiUrl = "http://localhost/flutter_api/get_posts.php";
  List<dynamic> _posts = [];
  bool _isLoading = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          _posts = json.decode(response.body);
          _isLoading = false;
          _hasError = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
        print('Failed to load posts: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
      print('Error loading posts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ALL POSTS'),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : _hasError
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Failed to load posts.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: fetchPosts,
              child: Text('Retry'),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ListTile(
                title: Text(
                  _posts[index]['title'],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    _posts[index]['body'],
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
