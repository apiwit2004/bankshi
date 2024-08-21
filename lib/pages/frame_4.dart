import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // นำเข้าห้องสมุด intl

class Frame4 extends StatelessWidget {
  final String projectName = 'Project_2'; // ตัวอย่างชื่อโปรเจค
  final String currentDate =
      DateFormat('dd/MM/yyyy').format(DateTime.now()); // วันที่ปัจจุบัน
  final String currentTime =
      DateFormat.Hm().format(DateTime.now()); // เวลาปัจจุบัน

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
        title: Text('Save data', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.black),
            onPressed: () {
              // ฟังก์ชันโปรไฟล์
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                      currentDate), // แสดงวันที่ปัจจุบันในรูปแบบ dd/MM/yyyy
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(currentTime), // แสดงเวลาปัจจุบัน
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              projectName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                filled: true,
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Value',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // เมื่อกดปุ่ม Save จะไปยังหน้า Confirm Data (frame_5.dart)
                  Navigator.pushNamed(context, '/frame_5', arguments: {
                    'projectName': projectName,
                    'date': currentDate, // ส่งวันที่ปัจจุบัน
                    'time': currentTime, // ส่งเวลาปัจจุบันไปที่ frame_5.dart
                    'name': 'name', // ข้อมูลตัวอย่าง
                    'value': 'Value',
                    'description': 'Description',
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.purple[900],
                ),
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[300],
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.show_chart),
              Icon(Icons.download),
              Icon(Icons.upload),
              Icon(Icons.access_time),
              Icon(Icons.chat),
            ],
          ),
        ),
      ),
    );
  }
}
