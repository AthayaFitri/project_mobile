import 'package:flutter/material.dart';
import '../../widgets/courses_list_widget.dart';
import '../../../../utils/services/rest_api_services.dart';
import '../../models/courses.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  late Future<List<DataCourses>> _coursesData;

  @override
  void initState() {
    _coursesData = RestApiService.coursesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Courses',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(
          top: 12,
        ),
        child: fetchCoursesData(),
      ),
    );
  }

  FutureBuilder<List<DataCourses>> fetchCoursesData() =>
      FutureBuilder<List<DataCourses>>(
        future: _coursesData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CoursesListWidget(snapshot.data as List<DataCourses>);
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
}
