import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:studifyy/registration_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const ResponsiveLayout());
  }
}

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key});
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Courses App'),
          ),
          body: sizingInformation.deviceScreenType == DeviceScreenType.desktop
              ? const DesktopLayout()
              : const CourseList(),
        );
      },
    );
  }
}

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key});
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        // Left side - Course List
        SizedBox(
          width: 300.0, // Adjust the width as needed
          child: CourseList(),
        ),
        // Right side - Course Detail
        Expanded(
          child: CourseDetail(),
        )
      ],
    );
  }
}
class CourseList extends StatelessWidget {
  const CourseList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container( color: Colors.orange,);
  }
}
class CourseDetail extends StatelessWidget {
  const CourseDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container( color: Colors.indigo,);
  }
}



/*class CourseList extends StatelessWidget {
  const CourseList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Add your search bar here
        // ...

        // Fetch courses from Firestore
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Programs')
              .doc('M-Tech')
              .collection('Courses')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            var courses = snapshot.data!.docs;

            return Expanded(
              child: ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  var course = Course.fromSnapshot(courses[index]);
                  return ListTile(
                    title: Text(course.id),
                    onTap: () {
                      // Navigate to course detail screen
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CourseDetail(selectedCourse: course)));
                    },
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class CourseDetail extends StatelessWidget {
  final Course? selectedCourse;

  const CourseDetail({super.key, required this.selectedCourse});

  @override
  Widget build(BuildContext context) {
    if (selectedCourse == null) {
      return const Center(
        child: Text('Select a course on the left to view details.'),
      );
    }
      return Scaffold(
        appBar: AppBar(
          title: Text(selectedCourse!.id),
        ),
        body: ResponsiveBuilder(
          builder: (context, sizingInformation) {
            return sizingInformation.deviceScreenType == DeviceScreenType.desktop
                ? DesktopDetailContent(selectedCourse: selectedCourse!)
                : MobileDetailContent(selectedCourse: selectedCourse!);
          },
        ),
      );
  }
}

class DesktopDetailContent extends StatelessWidget {
  final Course selectedCourse;

  const DesktopDetailContent({super.key, required this.selectedCourse});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left side - NavigationRail
        NavigationRail(
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.book),
              label: Text('Books'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.article),
              label: Text('Papers'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.note),
              label: Text('Notes'),
            ),
          ],
          selectedIndex: 0,
          onDestinationSelected: (index) {
            // Handle navigation based on the selected index
          },
        ),
        // Right side - Content
        const Expanded(
          child: ContentBasedOnIndex(selectedIndex: 0),
        ),
      ],
    );
  }
}

class MobileDetailContent extends StatelessWidget {
  final Course selectedCourse;

  const MobileDetailContent({super.key, required this.selectedCourse});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Column(
        children: [
          // Add your search bar here
          // ...

          // Content
          Expanded(
            child: ContentBasedOnIndex(selectedIndex: 0),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Books',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Papers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Notes',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          // Handle navigation based on the selected index
        },
      ),
    );
  }
}

class ContentBasedOnIndex extends StatelessWidget {
  final int selectedIndex;

  const ContentBasedOnIndex({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    // Adjust the content based on the selected index
    switch (selectedIndex) {
      case 0:
        return const Center(child: Text('Books Content'));
      case 1:
        return const Center(child: Text('Papers Content'));
      case 2:
        return const Center(child: Text('Notes Content'));
      default:
        return Container();
    }
  }
}*/

class Course {
  final String id;
  Course({required this.id});
  factory Course.fromSnapshot(DocumentSnapshot snapshot) {
    return Course(id: snapshot.id);
  }
}
