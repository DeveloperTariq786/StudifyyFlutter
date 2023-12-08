import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class DropdownFirestore extends StatefulWidget {
  const DropdownFirestore({super.key});
  @override
  _DropdownFirestoreState createState() => _DropdownFirestoreState();
}
class _DropdownFirestoreState extends State<DropdownFirestore> {
  String _selectedProgram = ''; // To store the selected program
  final CollectionReference programsCollection =
      FirebaseFirestore.instance.collection('Programs');
  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<QuerySnapshot>(
        stream: programsCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          List<DropdownMenuItem<String>> dropdownItems = [];
          for (var program in snapshot.data!.docs) {
            String programName =
                program.id; // Assuming document ID is the program name
            dropdownItems.add(
              DropdownMenuItem(
                value: programName,
                child: Text(programName),
              ),
            );
          }
          return Column(
            children: [
              DropdownButton<String>(
                value: _selectedProgram.isNotEmpty ? _selectedProgram : null,
                hint: const Text('Select Program'),
                isExpanded: true,
              //style: const TextStyle(fontFamily: "Analogist"),
                items: dropdownItems,
                onChanged: (value) {
                  setState(() {
                    _selectedProgram = value!;
                  });
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

/*
 const SizedBox(height: 20),
              _selectedProgram.isNotEmpty
                  ? Text('Selected Program: $_selectedProgram')
                  : const SizedBox(),
body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: programsCollection.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            List<DropdownMenuItem<String>> dropdownItems = [];
            for (var program in snapshot.data!.docs) {
              String programName = program.id; // Assuming document ID is the program name
              dropdownItems.add(
                DropdownMenuItem(
                  child: Text(programName),
                  value: programName,
                ),
              );
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  value: _selectedProgram.isNotEmpty ? _selectedProgram : null,
                  hint: Text('Select Program'),
                  items: dropdownItems,
                  onChanged: (value) {
                    setState(() {
                      _selectedProgram = value!;
                    });
                  },
                ),
                SizedBox(height: 20),
                _selectedProgram.isNotEmpty
                    ? Text('Selected Program: $_selectedProgram')
                    : SizedBox(),
              ],
            );
          },
        ),
      ),
 */
