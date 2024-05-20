import 'package:app_notein/providers/notes_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../models/note.dart';

class CreateNotePage extends StatefulWidget {
  @override
  _CreateNotePageState createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late DateTime _selectedDateTime;
  late String _selectedType;
  bool _isTitleEmpty = true;

  late final Note? note;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
    _selectedDateTime = DateTime.now();
    _selectedType = 'Work';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  String selectedType = 'All';

  Color _getNoteBackgroundColor(String type) {
    switch (type) {
      case 'Work':
        return Color.fromARGB(255, 208, 255, 210)!;
      case 'Personal':
        return Color.fromARGB(255, 255, 237, 211)!;
      case 'Others':
        return Color.fromRGBO(217, 242, 255, 1)!;
      default:
        return Colors.white;
    }
  }

  Color _getIconColor(String type) {
    switch (type) {
      case 'Work':
        return Colors.green;
      case 'Personal':
        return Colors.orange;
      case 'Others':
        return Colors.blue;
      default:
        return const Color.fromARGB(255, 255, 255, 255);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _getNoteBackgroundColor(_selectedType),
      appBar: AppBar(
        backgroundColor: _getNoteBackgroundColor(_selectedType),
        actions: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _getIconColor(_selectedType),
            ),
            child: IconButton(
              onPressed: () {
                _showFilterDialog(context);
              },
              icon: Icon(Icons.ads_click_sharp, color: Colors.white),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.push_pin_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              onSubmitted: (value) {
                setState(() {
                  _isTitleEmpty = value.isEmpty;
                });
              },
              style: TextStyle(
                fontSize: _isTitleEmpty ? 35.0 : 35.0,
              ),
              decoration: InputDecoration(
                labelText: _isTitleEmpty ? 'Heading' : '',
                border: InputBorder.none,
                labelStyle: TextStyle(
                  fontSize: 35.0,
                ),
              ),
            ),

            Row(
              children: [
                TextButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  child: Text('Select Date'),
                ),

                const SizedBox(width: 8.0), // Khoảng cách giữa Divider và Text
                Text('${_selectedDateTime.toLocal()}'),
              ],
            ),
            const SizedBox(height: 18.0),

            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey[400]!,
                    width: 1.0,
                  ),
                ),
              ),
              child: TextField(
                controller: _contentController,
                // focusNode: primaryFocus,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelStyle: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),

            SizedBox(height: 16.0),
            // Nút Submit nằm ở cuối cùng và to hơn
            Spacer(),
            Container(
              color: Colors.white,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.text_fields),
                    color: Colors.black,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.check),
                    color: Colors.black,
                    onPressed: () {
                      addNewNote();
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDateTime)
      setState(() {
        _selectedDateTime = picked;
      });
  }

  void _showFilterDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;
        return AlertDialog(
          title: const Text("Change Color"),
          content: Container(
            width: screenWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTypeOption(context, 'Work', Colors.green),
                _buildTypeOption(context, 'Personal', Colors.orange),
                _buildTypeOption(context, 'Others', Colors.blue),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTypeOption(BuildContext context, String type, Color color) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedType = type;
        });
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[200]!,
              width: 20,
            ),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CircleAvatar(
                backgroundColor: color.withOpacity(0.3),
                radius: 10.0,
              ),
            ),
            Text(
              type,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 18.0, // Chữ to hơn
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addNewNote() {
    final title = _titleController.text;
    final content = _contentController.text;
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (title.isEmpty || content.isEmpty) {
      // Hiển thị thông báo hoặc thực hiện xử lý khi dữ liệu không hợp lệ
      return;
    }

    final newNote = Note(
      id: const Uuid().v1(),
      userid: uid,
      title: _titleController.text,
      content: _contentController.text,
      dateadded: DateTime.now(),
      type: _selectedType,
    );

    Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
    Navigator.pop(context, newNote);
  }
}
