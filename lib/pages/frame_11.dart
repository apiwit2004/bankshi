import 'package:flutter/material.dart';

class Frame11 extends StatelessWidget {
  void showUploadCompleted(BuildContext context, String fileType) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$fileType Upload file completed'),
        duration: Duration(seconds: 2),
      ),
    );
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
        title: Text('Upload file', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.black),
            onPressed: () {
              // ฟังก์ชันโปรไฟล์
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showFileUploadDialog(context, 'Excel');
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: Colors.grey[300],
              ),
              child: Column(
                children: [
                  Icon(Icons.upload, size: 50, color: Colors.black),
                  Text('Excel'),
                ],
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                showFileUploadDialog(context, 'PDF');
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: Colors.grey[300],
              ),
              child: Column(
                children: [
                  Icon(Icons.upload, size: 50, color: Colors.black),
                  Text('PDF'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showFileUploadDialog(BuildContext context, String fileType) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('อัพโหลด'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'เลือกไฟล์',
                  hintText: 'ไม่มีไฟล์ที่เลือกไว้',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ปิด'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('บันทึก'),
              onPressed: () {
                Navigator.of(context).pop();
                showUploadCompleted(context, fileType);
              },
            ),
          ],
        );
      },
    );
  }
}
