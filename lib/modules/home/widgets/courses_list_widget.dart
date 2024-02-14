import 'package:flutter/material.dart';
import 'courses_item_widget.dart';
import '../models/courses.dart';

class CoursesListWidget extends StatelessWidget {
  final List<DataCourses> dataCourses;

  const CoursesListWidget(this.dataCourses, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Container(
          margin: const EdgeInsets.all(20),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: dataCourses.length,
            itemBuilder: (context, index) {
              final data = dataCourses[index];
              return CoursesItemWidget(
                id: data.id,
                name: data.name,
                link: data.link,
                image: data.image,
              );
            },
          ),
        ),
      ),
    );
  }
}
