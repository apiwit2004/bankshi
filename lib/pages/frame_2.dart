import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // ใช้สำหรับการจัดการวันที่
import '../services/api_service.dart'; // นำเข้า ApiService

class Frame2 extends StatefulWidget {
  final String username; // เพิ่มตัวแปร username สำหรับแสดงผล

  Frame2({required this.username}); // รับค่า username จากการนำทาง

  @override
  _Frame2State createState() => _Frame2State();
}

class _Frame2State extends State<Frame2> {
  List<String> projects = ['Project_1', 'Project_2'];

  // ดึงวันที่ปัจจุบันจากเครื่องในรูปแบบ dd/MM/yyyy
  String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

  void _addProject() {
    setState(() {
      projects.add('New Project');
    });
  }

  void _confirmDeleteProject(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Delete'),
        content: Text('Are you sure you want to delete this project?'),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(); // ปิด dialog
            },
          ),
          TextButton(
            child: Text('Delete'),
            onPressed: () {
              setState(() {
                projects.removeAt(index); // ลบโปรเจกต์
              });
              Navigator.of(context).pop(); // ปิด dialog
            },
          ),
        ],
      ),
    );
  }

  void _confirmEditProject(int index) {
    TextEditingController controller =
        TextEditingController(text: projects[index]);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Edit'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Are you sure you want to edit this project?'),
            TextField(
              controller: controller,
              decoration: InputDecoration(hintText: "Project Name"),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(); // ปิด dialog
            },
          ),
          TextButton(
            child: Text('Save'),
            onPressed: () {
              setState(() {
                projects[index] = controller.text; // แก้ไขโปรเจกต์
              });
              Navigator.of(context).pop(); // ปิด dialog
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              // นำทางไปยัง Frame14 เมื่อกดปุ่ม settings
              Navigator.pushNamed(context, '/frame_14',
                  arguments: widget.username);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.purple[100],
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.purple,
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.username, // แสดง username ที่รับมาจากฐานข้อมูล
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    Text(
                      currentDate, // แสดงวันที่ในรูปแบบ dd/MM/yyyy
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  ...projects.asMap().entries.map((entry) {
                    int index = entry.key;
                    String projectName = entry.value;
                    return ProjectTile(
                      icon: Icons.science,
                      label: projectName,
                      onEdit: () => _confirmEditProject(index),
                      onDelete: () => _confirmDeleteProject(index),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/frame_3',
                          arguments: projectName,
                        );
                      },
                    );
                  }).toList(),
                  AddProjectTile(onTap: _addProject),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: Icon(Icons.exit_to_app, size: 30),
                onPressed: () {
                  Navigator.pop(context); // ออกจากระบบ
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  ProjectTile({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.black),
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(fontSize: 16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddProjectTile extends StatelessWidget {
  final VoidCallback onTap;

  AddProjectTile({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Icon(Icons.add, size: 50, color: Colors.black),
        ),
      ),
    );
  }
}
