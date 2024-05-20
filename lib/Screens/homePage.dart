import 'package:app_notein/models/note.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notes_provider.dart';
import 'HomeScreen/UpdateNotePage.dart';
import 'HomeScreen/createNote.dart';

class HomePageN extends StatefulWidget {
  @override
  _HomePageNState createState() => _HomePageNState();
}

class _HomePageNState extends State<HomePageN> {
  String searchQuery = '';
  String selectedType = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notein'),
        actions: <Widget>[
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _getIconColor(
                  Provider.of<NotesProvider>(context).selectedType),
            ),
            child: IconButton(
              onPressed: () {
                _showFilterDialog(context);
              },
              icon: Icon(Icons.ads_click_sharp, color: Colors.white),
            ),
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // TODO: Implement notifications
            },
          ),
          PopupMenuButton<String>(
            onSelected: (String value) {
              // TODO: Implement menu actions
            },
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
      body: Consumer<NotesProvider>(
        builder: (context, notesProvider, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Search section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (value) {
                    // Update the search keyword
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
              ),
              // Notes list
              Expanded(
                  child: (notesProvider.notes.length > 0)
                      ? (notesProvider.getFilteredNotes(searchQuery).length > 0)
                          ? ListView.builder(
                              itemCount: notesProvider
                                  .getFilteredNotes(searchQuery)
                                  .length,
                              itemBuilder: (BuildContext context, int index) {
                                if (notesProvider.notes.isNotEmpty) {
                                  final currentNote = notesProvider
                                      .getFilteredNotes(searchQuery)[index];
                                  return InkWell(
                                    onTap: () {
                                      _goToUpdateNotePage(context, currentNote);
                                    },
                                    onLongPress: () {
                                      _showDeleteConfirmationDialog(
                                          context, notesProvider, currentNote);
                                      // notesProvider.deleteNote(currentNote);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(8.0),
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: _getNoteBackgroundColor(
                                            currentNote.type),
                                        border: Border(
                                          left: BorderSide(
                                            color: _getBorderColor(
                                                currentNote.type),
                                            width: 12.0,
                                          ),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            currentNote.title ?? '',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0,
                                            ),
                                          ),
                                          const SizedBox(height: 4.0),
                                          Row(
                                            children: [
                                              const Icon(Icons.access_time),
                                              const SizedBox(width: 4.0),
                                              Text(currentNote.dateadded
                                                  .toString()),
                                              Expanded(child: Container()),
                                              const Icon(
                                                  Icons.free_cancellation),
                                            ],
                                          ),
                                          const Divider(),
                                          Text(
                                            currentNote.content ?? '',
                                            style:
                                                const TextStyle(fontSize: 16.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              })
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(0),
                                  child: Image.asset(
                                    'assets/no-found.webp',
                                    width: 400,
                                    height: 400,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(0),
                                  child: Text(
                                    "No Note Found",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 28,
                                    ),
                                  ),
                                ),
                              ],
                            )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(0),
                              child: Image.asset(
                                'assets/no-notes.png',
                                width: 300,
                                height: 300,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(0),
                              child: Text(
                                "No Notes",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ],
                        )),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _goToCreateNotePage(context);
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.edit),
        shape: const CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  Color _getBorderColor(String? type) {
    if (type != null) {
      switch (type) {
        case 'Work':
          return Color.fromARGB(255, 46, 250, 56);
        case 'Personal':
          return Colors.orange[800]!;
        case 'Others':
          return Colors.blue[800]!;
      }
    }
    return Colors.transparent;
  }

  Color _getNoteBackgroundColor(String? type) {
    if (type != null) {
      switch (type) {
        case 'Work':
          return Color.fromARGB(255, 197, 255, 199)!;
        case 'Personal':
          return Color.fromARGB(255, 255, 233, 200)!;
        case 'Others':
          return Color.fromRGBO(206, 239, 255, 1)!;
      }
    }
    return Colors.white;
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, NotesProvider notesProvider, Note note) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this note?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Delete the note
                notesProvider.deleteNote(note);
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void _showFilterDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;
        return Consumer<NotesProvider>(
          builder: (context, notesProvider, _) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Filter",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  _buildFilterOption(
                    context,
                    notesProvider,
                    'All',
                    Colors.white,
                    Colors.black,
                  ),
                  SizedBox(height: 10.0),
                  _buildFilterOption(
                    context,
                    notesProvider,
                    'Work',
                    Colors.green,
                    Colors.white,
                  ),
                  SizedBox(height: 10.0),
                  _buildFilterOption(
                    context,
                    notesProvider,
                    'Personal',
                    Colors.orange,
                    Colors.white,
                  ),
                  SizedBox(height: 10.0),
                  _buildFilterOption(
                    context,
                    notesProvider,
                    'Others',
                    Colors.blue,
                    Colors.white,
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFilterOption(
    BuildContext context,
    NotesProvider notesProvider,
    String filterType,
    Color backgroundColor,
    Color textColor,
  ) {
    return GestureDetector(
      onTap: () {
        notesProvider.setFilter(filterType);
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: _getIconColor(filterType),
                  radius: 8.0,
                ),
                SizedBox(width: 8.0),
                Text(
                  filterType,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            if (notesProvider.selectedType == filterType)
              Icon(Icons.check, color: Colors.blue),
          ],
        ),
      ),
    );
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
        return Color.fromARGB(255, 202, 202, 202);
    }
  }

  void _goToCreateNotePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateNotePage()),
    );
  }

  void _goToUpdateNotePage(BuildContext context, Note note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateNotePage(
          note: note,
          onNoteUpdated: (updatedNote) {},
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ChangeNotifierProvider(
      create: (context) => NotesProvider(),
      child: HomePageN(),
    ),
  ));
}
