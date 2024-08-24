import 'package:flutter/material.dart';
import '../services/api_service.dart';

class Frame1 extends StatefulWidget {
  @override
  _Frame1State createState() => _Frame1State();
}

class _Frame1State extends State<Frame1> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isButtonEnabled = false;

  void _checkInput() {
    setState(() {
      // ตรวจสอบว่าทั้ง Username และ Password ถูกกรอกแล้วหรือไม่
      isButtonEnabled = usernameController.text.isNotEmpty &&
          passwordController.text.isNotEmpty;
    });
  }

  Future<void> _loginUser() async {
    final username = usernameController.text;
    final password = passwordController.text;

    final isValid = await ApiService().loginUser(username, password, context);

    if (isValid) {
      Navigator.pushNamed(context, '/frame_2', arguments: username);
    } else {
      // แสดง AlertDialog ว่า username หรือ password ผิด
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content: Text('Username or Password is incorrect.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.purple[100],
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.purple,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'LOGIN',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                filled: true,
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                _checkInput(); // ตรวจสอบข้อมูลเมื่อมีการเปลี่ยนแปลง
              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                _checkInput(); // ตรวจสอบข้อมูลเมื่อมีการเปลี่ยนแปลง
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isButtonEnabled
                  ? _loginUser
                  : null, // ปิดใช้งานปุ่มหากไม่มีข้อมูล
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: isButtonEnabled
                    ? Colors.purple[900]
                    : Colors.grey, // เปลี่ยนสีปุ่มตามสถานะ
              ),
              child: Text(
                'Log in',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),
            Divider(thickness: 1),
            SizedBox(height: 10),
            Text('Create an account'),
            SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                // นำทางไปยัง frame_7.dart เมื่อกดปุ่ม "Sign up"
                Navigator.pushNamed(context, '/frame_7');
              },
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Sign up', // แก้ไขข้อความเป็น Sign up
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
