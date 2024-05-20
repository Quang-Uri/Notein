import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:app_notein/models/note.dart';
import 'package:app_notein/services/api_service.dart';

class NotesProvider with ChangeNotifier {
  bool isLoading = true;
  List<Note> notes = [];
  String selectedType = 'All'; // Trường loại bộ lọc đã chọn

  NotesProvider() {
    fetchNotes();
  }

  List<Note> getFilteredNotes(String searchQuery) {
    return notes
        .where((element) =>
            (selectedType == 'All' ||
                element.type == selectedType) && // Áp dụng bộ lọc theo loại
            (element.title!.toLowerCase().contains(searchQuery.toLowerCase()) ||
                element.content!
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase())))
        .toList();
  }

  void sortNotes() {
    notes.sort((a, b) => b.dateadded!.compareTo(a.dateadded!));
  }

  void addNote(Note note) {
    notes.add(note);
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }

  void updateNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note;
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }

  void deleteNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote);
    sortNotes();
    notifyListeners();
    ApiService.deleteNote(note);
  }

  void fetchNotes() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;

    notes = await ApiService.fetchNotes(uid!);
    sortNotes();
    isLoading = false;
    notifyListeners();
  }

  void setFilter(String type) {
    selectedType = type;
    notifyListeners();
  }
}
