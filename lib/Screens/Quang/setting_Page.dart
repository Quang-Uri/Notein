import 'package:app_notein/main.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'privacy_policy.dart';

class setting_Page extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<setting_Page> {
  bool isDarkMode = false;
  bool isPasswordProtected = false;
  bool showColorPicker = false;
  String selectedLanguage = 'English';
  Color selectedColor = Colors.red;
  bool isNotificationEnabled = false;

  void _handleShare() {
    final String text = 'Chia sẻ nội dung của bạn ở đây';
    Share.share(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.lightbulb),
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode;
              });
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[200],
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            _buildSection(
              'General', // Nội dung dòng văn bản
              Colors.blue, // Màu chữ
              [
                ListTile(
                  title: Text('Dark Mode'),
                  leading: Icon(Icons.dark_mode),
                  trailing: Switch(
                    value: isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        isDarkMode = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text('Color Theme'),
                  leading: Icon(Icons.palette),
                  trailing: GestureDetector(
                    onTap: () {
                      setState(() {
                        showColorPicker = !showColorPicker;
                      });
                    },
                    child: Container(
                      width: 24.0,
                      height: 24.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selectedColor,
                      ),
                    ),
                  ),
                ),
                if (showColorPicker)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: [
                        for (Color color in [
                          Colors.red,
                          Colors.orange,
                          Colors.yellow,
                          Colors.green,
                          Colors.blue,
                          Colors.indigo,
                          Colors.purple,
                        ])
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedColor = color;
                                showColorPicker = false;
                              });
                            },
                            child: Container(
                              width: 24.0,
                              height: 24.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: color,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ListTile(
                  title: Text('Language'),
                  leading: Icon(Icons.language),
                  trailing: DropdownButton<String>(
                    value: selectedLanguage,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedLanguage = newValue!;
                      });
                    },
                    items: <String>['English', 'Vietnamese']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                ListTile(
                  title: Text('Notification'),
                  leading: Icon(Icons.mark_chat_unread),
                  trailing: Switch(
                    value: isNotificationEnabled,
                    onChanged: (value) {
                      setState(() {
                        isNotificationEnabled = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            _buildSection(
              'Security', // Nội dung dòng văn bản
              Colors.blue, // Màu chữ
              [
                ListTile(
                  title: Text('Set Password'),
                  leading: Icon(Icons.lock),
                  trailing: Switch(
                    value: isPasswordProtected,
                    onChanged: (value) {
                      setState(() {
                        isPasswordProtected = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text('Change Password'),
                  leading: Icon(Icons.sync_alt),
                  onTap: () {
                    // Handle change password action
                  },
                ),
              ],
            ),
            _buildSection(
              'Others', // Nội dung dòng văn bản
              Colors.blue, // Màu chữ
              [
                ListTile(
                  title: Text('Share'),
                  leading: Icon(Icons.share),
                  onTap: _handleShare,
                ),
                ListTile(
                  title: Text('Privacy Policy'),
                  leading: Icon(Icons.visibility),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => privacy_policy()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String text, Color color, List<Widget> children) {
    return Container(
      margin: EdgeInsets.only(top: 24.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 16.0, top: 16.0),
            child: Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            children: children,
          ),
        ],
      ),
    );
  }
}
