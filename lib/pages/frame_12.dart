import 'package:flutter/material.dart';

class Frame12 extends StatefulWidget {
  @override
  _Frame12State createState() => _Frame12State();
}

class _Frame12State extends State<Frame12> {
  List<Map<String, dynamic>> alarms = [
    {'label': 'Collect substances', 'time': '08:00', 'enabled': true},
    {'label': 'xxxxxxxxxxxxxxxxxxx', 'time': 'XX:XX', 'enabled': true},
  ];

  void _addAlarm() {
    setState(() {
      alarms.add({'label': 'New Alarm', 'time': 'XX:XX', 'enabled': true});
    });
  }

  Future<void> _selectTime(BuildContext context, int index) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        alarms[index]['time'] = picked.format(context);
      });
    }
  }

  void _editLabel(BuildContext context, int index) {
    TextEditingController labelController = TextEditingController(
      text: alarms[index]['label'],
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Alarm Label'),
          content: TextField(
            controller: labelController,
            decoration: InputDecoration(
              labelText: 'Alarm Label',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  alarms[index]['label'] = labelController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteAlarm(int index) {
    setState(() {
      alarms.removeAt(index);
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
        title: Text('Clock', style: TextStyle(color: Colors.black)),
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
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: alarms.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(alarms[index]['label']),
                      subtitle: Text(alarms[index]['time']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Switch(
                            value: alarms[index]['enabled'],
                            onChanged: (bool value) {
                              setState(() {
                                alarms[index]['enabled'] = value;
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _editLabel(context, index);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deleteAlarm(index);
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        _selectTime(context, index);
                      },
                    ),
                  );
                },
              ),
            ),
            FloatingActionButton(
              onPressed: _addAlarm,
              child: Icon(Icons.add),
              backgroundColor: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}
