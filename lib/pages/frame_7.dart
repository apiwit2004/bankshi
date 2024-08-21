import 'package:flutter/material.dart';

class Frame7 extends StatefulWidget {
  @override
  _Frame7State createState() => _Frame7State();
}

class _Frame7State extends State<Frame7> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isButtonEnabled = false;

  void _checkInput() {
    setState(() {
      // ตรวจสอบว่า Username, Password และ Confirm Password ถูกกรอกแล้วหรือไม่
      isButtonEnabled = usernameController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty;
    });
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
        title: Text('Sign Up', style: TextStyle(color: Colors.black)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
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
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _checkInput(); // ตรวจสอบข้อมูลเมื่อมีการเปลี่ยนแปลง
                  },
                ),
                SizedBox(height: 20),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _checkInput(); // ตรวจสอบข้อมูลเมื่อมีการเปลี่ยนแปลง
                  },
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: isButtonEnabled
                      ? () {
                          // ฟังก์ชันสำหรับการสมัครสมาชิก
                          // เมื่อกดปุ่ม Register ให้ไปยังหน้า success frame_8.dart
                          Navigator.pushNamed(context, '/frame_8');
                        }
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
                    'Register',
                    style: TextStyle(fontSize: 16),
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
