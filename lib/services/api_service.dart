import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class ApiService {
  get context => null;

  Future<void> registerUser(
      String username, String password, BuildContext context) async {
    final url = Uri.parse(
        'http://192.168.56.1/flutter_api/register.php'); // เปลี่ยน URL ให้ตรงกับที่อยู่ของ API ของคุณ

    try {
      final response = await http.post(
        url,
        body: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['error'] == null) {
          if (data['message'] == 'Username already exists') {
            // Username ซ้ำ ให้แสดง AlertDialog
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Error'),
                  content: Text('Username already exists.'),
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
          } else if (data['message'] == 'New record created successfully') {
            // สมัครสำเร็จ นำไปยัง frame_8
            Navigator.pushNamed(context, '/frame_8');
          }
        } else {
          // ข้อผิดพลาดอื่น ๆ
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text(data['error']),
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
      } else {
        // ข้อผิดพลาดในการติดต่อเซิร์ฟเวอร์
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Server error: ${response.statusCode}'),
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
    } catch (e) {
      // ข้อผิดพลาดอื่น ๆ
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred: $e'),
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

  // ฟังก์ชัน loginUser เพื่อตรวจสอบการเข้าสู่ระบบ
  Future<bool> loginUser(
      String username, String password, BuildContext context) async {
    final url = Uri.parse(
        'http://192.168.56.1/flutter_api/login.php'); // เปลี่ยน URL ให้ตรงกับที่อยู่ของ API ของคุณ

    try {
      final response = await http.post(
        url,
        body: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'success') {
          return true; // ส่งกลับค่า true เมื่อเข้าสู่ระบบสำเร็จ
        } else {
          return false; // ส่งกลับค่า false เมื่อเข้าสู่ระบบล้มเหลว
        }
      } else {
        return false; // ส่งกลับค่า false เมื่อเกิดข้อผิดพลาดในการติดต่อเซิร์ฟเวอร์
      }
    } catch (e) {
      // แสดงข้อผิดพลาด
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred: $e'),
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
      return false; // ส่งกลับค่า false เมื่อเกิดข้อผิดพลาดอื่นๆ
    }
  }

  deleteUser(String username) {}

  updateUser(String username, String text, String text2) {}

  getUserData(String username) {}
}
