import 'package:flutter/material.dart';

class Frame2 extends StatefulWidget {
  @override
  _Frame2State createState() => _Frame2State();
}

class _Frame2State extends State<Frame2> {
  List<String> projects = ['Project_1', 'Project_2']; // รายการโปรเจกต์เริ่มต้น
  TextEditingController projectController =
      TextEditingController(); // สำหรับเพิ่ม/แก้ไขโปรเจกต์

  void _addProject(String projectName) {
    setState(() {
      projects.add(projectName);
    });
    Navigator.of(context).pop();
  }

  void _editProject(int index, String newName) {
    setState(() {
      projects[index] = newName;
    });
    Navigator.of(context).pop();
  }

  void _deleteProject(int index) {
    setState(() {
      projects.removeAt(index);
    });
  }

  void _showAddProjectDialog() {
    projectController.clear();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Project'),
          content: TextField(
            controller: projectController,
            decoration: InputDecoration(hintText: 'Enter project name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (projectController.text.isNotEmpty) {
                  _addProject(projectController.text);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditProjectDialog(int index) {
    projectController.text = projects[index];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Project'),
          content: TextField(
            controller: projectController,
            decoration: InputDecoration(hintText: 'Edit project name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (projectController.text.isNotEmpty) {
                  _editProject(index, projectController.text);
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
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
              // ฟังก์ชันการตั้งค่า
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
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: projects.length + 1, // +1 เพื่อรวมปุ่มเพิ่มโปรเจกต์
                itemBuilder: (context, index) {
                  if (index == projects.length) {
                    // แสดงปุ่มเพิ่มโปรเจกต์
                    return GestureDetector(
                      onTap: _showAddProjectDialog,
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
                  // แสดงโปรเจกต์
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/frame_3',
                          arguments: projects[index]);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.science, size: 50, color: Colors.black),
                          SizedBox(height: 10),
                          Text(
                            projects[index],
                            style: TextStyle(fontSize: 16),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () => _showEditProjectDialog(index),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => _deleteProject(index),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
