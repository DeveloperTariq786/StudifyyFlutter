import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Courses extends StatefulWidget {
  const Courses({super.key});
  @override
  State<Courses> createState() => _CoursesState();
}
class _CoursesState extends State<Courses> {
  final Stream<QuerySnapshot> _coursesStream = FirebaseFirestore.instance
      .collection('Programs')
      .doc('M-Tech')
      .collection('Courses')
      .snapshots();
  late String program;
  @override
  void initState() {
    super.initState();
    loadProgram();
  }
  Future<void> loadProgram() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      program = (prefs.getString('Program'))!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Courses')),
      body: Row(
        children: [
          // Courses list on the left side
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _coursesStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final courses = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    final course = courses[index];
                    final courseName= course.id;
                    return ListTile(
                      title: Text(courseName),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailCourse(courseName: courseName),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          // Course details on the right side, initially empty
          const Expanded(
            child: DetailCourse(),
          ),
        ],
      ),
    );
  }
}
class DetailCourse extends StatelessWidget {
  final String courseName;

  const DetailCourse({super.key, this.courseName = ''});

  @override
  Widget build(BuildContext context) {
    if (courseName.isEmpty) {
      // Show placeholder text when no course is selected
      return const Center(child: Text('Select a course to view details'));
    } else {
      // Show detailed description of selected course
      return Text('Detailed description of the course: $courseName');
    }
  }
}
