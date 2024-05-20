import 'package:flutter/material.dart';

class widget_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200], // Màu nền xám
                borderRadius: BorderRadius.circular(10.0), // Bo góc khung
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.search), // Biểu tượng tìm kiếm bên trái
                    SizedBox(
                        width:
                            8.0), // Khoảng cách giữa biểu tượng và text field
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border:
                              InputBorder.none, // Loại bỏ viền của TextField
                          labelText: 'Search...',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text('Select a widget and add it to the home screen'),
            ),
          ),
        ],
      ),
    );
  }
}
