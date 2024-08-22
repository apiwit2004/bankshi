import 'package:flutter/material.dart';

class Frame9 extends StatefulWidget {
  @override
  _Frame9State createState() => _Frame9State();
}

class _Frame9State extends State<Frame9> {
  List<Map<String, String>> dataRows = [
    {'Date': '2 July 2024', 'Value': 'xx.xx', 'Description': 'xxxxxxxxxx'},
    {'Date': '3 July 2024', 'Value': 'xx.xx', 'Description': 'xxxxxxxxxx'},
  ];

  void _deleteRow(int index) async {
    bool? confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this row?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      setState(() {
        dataRows.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text('Graph', style: TextStyle(color: Colors.black)),
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
            Text(
              projectName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Center(
              child: Container(
                height: 200,
                color: Colors.grey[300],
                child: Center(child: Text('Graph Placeholder')),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Value',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Description',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(''),
                ),
              ],
              rows: List<DataRow>.generate(
                dataRows.length,
                (index) => DataRow(
                  cells: [
                    DataCell(Text(dataRows[index]['Date']!)),
                    DataCell(Text(dataRows[index]['Value']!)),
                    DataCell(Text(dataRows[index]['Description']!)),
                    DataCell(
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteRow(index),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
