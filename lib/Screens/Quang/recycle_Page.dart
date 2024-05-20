import 'package:flutter/material.dart';

class recycle_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recycle bin'),
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
          SizedBox(height: 160.0), // Khoảng cách giữa ô tìm kiếm và dòng text

          // Đối tượng mới chứa hình ảnh và dòng text
          Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/recycle.png', // Thay đổi đường dẫn tới tệp hình ảnh của bạn
                  width: 100.0, // Độ rộng của hình ảnh
                  height: 100.0, // Chiều cao của hình ảnh
                ),
                SizedBox(height: 8.0), // Khoảng cách giữa hình ảnh và dòng text
                Text(
                  'Your deleted notes will appear here',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
