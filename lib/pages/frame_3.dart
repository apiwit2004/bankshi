import 'package:flutter/material.dart';

class Frame3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ตรวจสอบว่าค่า arguments ไม่เป็น null
    final String projectName =
        ModalRoute.of(context)?.settings.arguments as String? ??
            'Default Project Name';

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
        title: Text(projectName, style: TextStyle(color: Colors.black)),
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
                      'Username',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    Text(
                      'dd/mm/yyyy',
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
                  ProjectActionTile(
                    icon: Icons.save,
                    label: 'Save data',
                    onTap: () {
                      Navigator.pushNamed(context, '/frame_4',
                          arguments: projectName);
                    },
                  ),
                  ProjectActionTile(
                    icon: Icons.show_chart,
                    label: 'Graph',
                    onTap: () {
                      // นำทางไปยัง frame_9.dart พร้อมกับส่งชื่อโปรเจคไปด้วย
                      Navigator.pushNamed(context, '/frame_9',
                          arguments: projectName);
                    },
                  ),
                  ProjectActionTile(
                    icon: Icons.download,
                    label: 'Download',
                    onTap: () {
                      // นำทางไปยัง frame_10.dart
                      Navigator.pushNamed(context, '/frame_10');
                    },
                  ),
                  ProjectActionTile(
                    icon: Icons.upload,
                    label: 'Upload file',
                    onTap: () {
                      // นำทางไปยัง frame_11.dart
                      Navigator.pushNamed(context, '/frame_11');
                    },
                  ),
                  ProjectActionTile(
                    icon: Icons.access_time,
                    label: 'Clock',
                    onTap: () {
                      // นำทางไปยัง frame_12.dart
                      Navigator.pushNamed(context, '/frame_12');
                    },
                  ),
                  ProjectActionTile(
                    icon: Icons.chat,
                    label: 'Chat GPT',
                    onTap: () {
                      // นำทางไปยัง frame_13.dart
                      Navigator.pushNamed(context, '/frame_13');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  ProjectActionTile({required this.icon, required this.label, this.onTap});

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
          ],
        ),
      ),
    );
  }
}
