import 'package:flutter/material.dart';

class feedback_Page extends StatefulWidget {
  const feedback_Page({Key? key}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<feedback_Page> {
  bool _isSelected1 = false;
  bool _isSelected2 = false;
  bool _isSelected3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 8.0),
              child: Text(
                'Tell us the problem you encountered',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Too few features'),
                    onTap: () {
                      setState(() {
                        _isSelected1 = !_isSelected1;
                      });
                    },
                    leading: Checkbox(
                      value: _isSelected1,
                      onChanged: (value) {
                        setState(() {
                          _isSelected1 = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Bugs'),
                    onTap: () {
                      setState(() {
                        _isSelected2 = !_isSelected2;
                      });
                    },
                    leading: Checkbox(
                      value: _isSelected2,
                      onChanged: (value) {
                        setState(() {
                          _isSelected2 = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Others'),
                    onTap: () {
                      setState(() {
                        _isSelected3 = !_isSelected3;
                      });
                    },
                    leading: Checkbox(
                      value: _isSelected3,
                      onChanged: (value) {
                        setState(() {
                          _isSelected3 = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText:
                      'Please tell us more details so that we can locate\nand solve your problem faster (at least 6\ncharacters)',
                  hintStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 180.0, horizontal: 10.0),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextButton(
                onPressed: () {
                  // Xử lý logic gửi ở đây
                },
                child: Text(
                  'SUBMIT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: feedback_Page(),
  ));
}
