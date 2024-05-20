import 'package:flutter/material.dart';
import 'package:app_notein/Screens/calendar/meeting.dart';

class MeetingProvider extends ChangeNotifier {
  List<Meeting> meetings = [];

  void addMeeting(DateTime? selectedDate, String eventName) {
    if (selectedDate != null) {
      meetings.add(
        Meeting(
          eventName,
          selectedDate,
          selectedDate.add(Duration(hours: 1)),
          Colors.blue, // Màu sắc của sự kiện
          false,
        ),
      );
      notifyListeners();
    } else {
      // Xử lý trường hợp selectedDate là null
    }
  }

  void editMeeting(int index) {
    meetings[index].eventName = 'Con $index $index';
    notifyListeners();
  }
}
