import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Frame13 extends StatelessWidget {
  final Uri _url = Uri.parse('https://chatgpt.com/');

  void _launchURL() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Chat GPT', style: TextStyle(color: Colors.black)),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _launchURL,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: Colors.purple[900],
          ),
          child: Text(
            'Go to Chat GPT',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
