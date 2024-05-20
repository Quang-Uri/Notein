import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:app_notein/Screens/calendar/meeting.dart';
import 'package:app_notein/Screens/calendar/meeting_data_source.dart';
import 'package:app_notein/Screens/calendar/meeting_provider.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  CalendarView calendarView = CalendarView.month;
  late CalendarController calendarController;

  @override
  void initState() {
    super.initState();
    calendarController = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SfCalendar(
              view: calendarView,
              initialDisplayDate: DateTime.now(),
              headerStyle: CalendarHeaderStyle(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold, // Đặt fontWeight là bold
                ),
              ),
              controller: calendarController,
              monthViewSettings: MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                appointmentDisplayCount:
                    2, // Chỉ hiển thị 2 sự kiện trước khi chuyển sang kiểu '...'
              ),
              dataSource: MeetingDataSource(provider.meetings),
              cellBorderColor: Colors.transparent,
              appointmentBuilder:
                  (BuildContext context, CalendarAppointmentDetails details) {
                final Meeting meeting = details.appointments.first;
                return Container(
                  color: meeting.background,
                  child: Center(
                    child: Text(meeting.eventName),
                  ),
                );
              },
              onTap: (details) {
                if (calendarView == CalendarView.month) {
                  setState(() {
                    calendarView = CalendarView.week;
                    calendarController.view = calendarView;
                    calendarController.displayDate = details.date!;
                  });
                }
              },
              onLongPress: (details) {
                _showAddMeetingDialog(context);
              },
            ),
          ),
          Positioned(
            top: -20,
            right: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: DropdownButton<CalendarView>(
                value: calendarView,
                underline: Container(),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.blue,
                ),
                onChanged: (value) {
                  setState(() {
                    calendarView = value!;
                    calendarController.view = calendarView;
                  });
                },
                items: [
                  DropdownMenuItem(
                    value: CalendarView.month,
                    child: Text(
                      "Month",
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Đặt fontWeight là bold
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: CalendarView.week,
                    child: Text(
                      "Week",
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Đặt fontWeight là bold
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddMeetingDialog(context);
        },
        child: Icon(Icons.add),
        shape: CircleBorder(),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  void _showAddMeetingDialog(BuildContext context) {
    String meetingName = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Meeting'),
          content: TextField(
            onChanged: (value) {
              meetingName = value;
            },
            decoration: InputDecoration(hintText: 'Enter meeting name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (meetingName.isNotEmpty) {
                  final selectedDate = calendarController.selectedDate;
                  if (selectedDate != null) {
                    Provider.of<MeetingProvider>(context, listen: false)
                        .addMeeting(selectedDate, meetingName);
                  }
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
