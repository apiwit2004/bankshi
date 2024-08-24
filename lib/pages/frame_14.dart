import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Frame14 extends StatefulWidget {
  final String username;

  Frame14({required this.username});

  @override
  _Frame14State createState() => _Frame14State();
}

class _Frame14State extends State<Frame14> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // เรียกฟังก์ชันดึงข้อมูลเมื่อเริ่มต้น
  }

  // ฟังก์ชันดึงข้อมูลผู้ใช้จากฐานข้อมูล
  Future<void> _fetchUserData() async {
    final url = Uri.parse('http://192.168.56.1/flutter_api/get_user.php');
    try {
      final response = await http.post(
        url,
        body: {
          'username': widget.username,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            _usernameController.text = data['user']['username'];
            _passwordController.text = data['user']['password'];
          });
        } else {
          _showErrorDialog('Failed to load user data');
        }
      } else {
        _showErrorDialog('Server error: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorDialog('An error occurred: $e');
    }
  }

  // ฟังก์ชันแก้ไขข้อมูลผู้ใช้ในฐานข้อมูล
  Future<void> _saveUser() async {
    final url = Uri.parse('http://192.168.56.1/flutter_api/update_user.php');
    try {
      final response = await http.post(
        url,
        body: {
          'old_username': widget.username, // ชื่อผู้ใช้เดิมที่นำมา
          'new_username': _usernameController.text,
          'password': _passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          _showSuccessDialog('User data updated successfully');
        } else {
          _showErrorDialog('Failed to update user data');
        }
      } else {
        _showErrorDialog('Server error: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorDialog('An error occurred: $e');
    }
  }

  // ฟังก์ชันลบผู้ใช้จากฐานข้อมูล
  Future<void> _deleteUser() async {
    final url = Uri.parse('http://192.168.56.1/flutter_api/delete_user.php');
    try {
      final response = await http.post(
        url,
        body: {
          'username': widget.username,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          Navigator.pushNamedAndRemoveUntil(
              context, '/frame_1', (route) => false);
        } else {
          _showErrorDialog('Failed to delete user');
        }
      } else {
        _showErrorDialog('Server error: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorDialog('An error occurred: $e');
    }
  }

  // ฟังก์ชันแสดงข้อความแสดงความสำเร็จ
  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Success'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  // ฟังก์ชันแสดงข้อความแสดงข้อผิดพลาด
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  // ฟังก์ชันแสดง AlertDialog เพื่อยืนยันการลบ
  void _confirmDeleteUser() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Delete'),
        content: Text('Are you sure you want to delete this user?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // ปิด dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // ปิด dialog
              _deleteUser(); // ลบผู้ใช้หลังจากยืนยัน
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.grey[300],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                filled: true,
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _saveUser,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: Colors.purple[900],
              ),
              child: Text('Save', style: TextStyle(fontSize: 16)),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomLeft,
              child: TextButton.icon(
                onPressed:
                    _confirmDeleteUser, // แก้ไขให้เรียกฟังก์ชันยืนยันการลบ
                icon: Icon(Icons.delete, color: Colors.red),
                label: Text('Delete this user',
                    style: TextStyle(color: Colors.red)),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  Navigator.pop(context); // กลับไปยังหน้าก่อนหน้า
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
