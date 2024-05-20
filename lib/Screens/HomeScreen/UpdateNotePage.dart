import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/note.dart';
import '../../providers/notes_provider.dart';

class UpdateNotePage extends StatefulWidget {
  final Note note;
  final Function(Note) onNoteUpdated;

  UpdateNotePage({required this.note, required this.onNoteUpdated});

  @override
  _UpdateNotePageState createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late DateTime _selectedDateTime;
  late String _selectedType;
  bool _isTitleEmpty = true;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
    _selectedDateTime = widget.note.dateadded ?? DateTime.now();
    _selectedType = widget.note.type ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _getNoteBackgroundColor(_selectedType),
      appBar: AppBar(
        backgroundColor: _getNoteBackgroundColor(_selectedType),
        actions: <Widget>[
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
            icon: Icon(Icons.push_pin_rounded),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            onSelected: (String value) {},
            itemBuilder: (BuildContext context) {
              return {'Settings', 'Share', 'Delete'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
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
              onChanged: (value) {
                setState(() {
                  _isTitleEmpty = value.isEmpty;
                });
              },
              style: TextStyle(fontSize: _isTitleEmpty ? 35.0 : 35.0),
              decoration: InputDecoration(
                labelText: _isTitleEmpty ? 'Heading' : '',
                labelStyle: TextStyle(
                  fontSize: _isTitleEmpty
                      ? 35.0
                      : 0.0, // Ẩn nhãn khi trường không trống
                  color: _isTitleEmpty
                      ? Colors.grey
                      : null, // Màu xám nhạt chỉ khi trống
                ),
                border: InputBorder.none,
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
                const SizedBox(width: 8.0),
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
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelStyle: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Spacer(),
            Container(
              color: Colors.white,
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
                      updateNote();
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

  void updateNote() {
    Note updatedNote = Note(
      id: widget.note.id,
      userid: widget.note.userid,
      title: _titleController.text,
      content: _contentController.text,
      dateadded: _selectedDateTime,
      type: _selectedType,
    );

    Provider.of<NotesProvider>(context, listen: false).updateNote(updatedNote);

    Navigator.pop(context);
  }

  Color _getNoteBackgroundColor(String type) {
    switch (type) {
      case 'Work':
        return Color.fromARGB(255, 197, 255, 199)!;
      case 'Personal':
        return Color.fromARGB(255, 255, 233, 200)!;
      case 'Others':
        return Color.fromRGBO(206, 239, 255, 1)!;
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
}
