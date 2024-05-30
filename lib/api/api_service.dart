import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = 'https://fiwis.fiw.fhws.de/fiwis2/api/events/today';

  Future<List<Course>> fetchCourses() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      print('Data fetched successfully: $jsonResponse'); // Добавьте это сообщение для отладки
      return jsonResponse.map((course) => Course.fromJson(course)).toList();
    } else {
      print('Failed to load courses. Status code: ${response.statusCode}');
      throw Exception('Failed to load courses');
    }
  }
}

class Course {
  final String name;
  final String details;
  final String startTime;
  final String endTime;
  final String lecturersToShow;
  final String roomsToShow;
  final String studyGroupsToShow;
  final String type;

  Course({
    required this.name,
    required this.details,
    required this.startTime,
    required this.endTime,
    required this.lecturersToShow,
    required this.roomsToShow,
    required this.studyGroupsToShow,
    required this.type,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      name: json['name'] ?? 'No Name',
      details: json['details'] ?? 'No Details',
      startTime: json['startTime'] ?? 'No Start Time',
      endTime: json['endTime'] ?? 'No End Time',
      lecturersToShow: json['lecturersToShow'] ?? 'No Lecturers',
      roomsToShow: json['roomsToShow'] ?? 'No Rooms',
      studyGroupsToShow: json['studyGroupsToShow'] ?? 'No Study Groups',
      type: json['type'] ?? 'No Type',
    );
  }
}
