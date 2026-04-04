import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'student.dart';

class StudentScreen extends StatelessWidget {
  final box = Hive.box<Student>('students');

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final gradeController = TextEditingController();

  void addStudent() {
    final student = Student(
      name: nameController.text,
      age: int.parse(ageController.text),
      grade: gradeController.text,
    );

    box.add(student);

    nameController.clear();
    ageController.clear();
    gradeController.clear();
  }

  void updateStudent(int index) {
    final student = Student(
      name: nameController.text,
      age: int.parse(ageController.text),
      grade: gradeController.text,
    );

    box.putAt(index, student);
  }

  void deleteStudent(int index) {
    box.deleteAt(index);
  }

  void showEditDialog(BuildContext context, Student student, int index) {
    nameController.text = student.name;
    ageController.text = student.age.toString();
    gradeController.text = student.grade;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Edit Student"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController),
            TextField(controller: ageController),
            TextField(controller: gradeController),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              updateStudent(index);
              Navigator.pop(context);
            },
            child: Text("Update"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Student Records")),

      body: Column(
        children: [
          // ADD SECTION
          Padding(
            padding:  EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Name"),
                ),
                TextField(
                  controller: ageController,
                  decoration: InputDecoration(labelText: "Age"),
                ),
                TextField(
                  controller: gradeController,
                  decoration: InputDecoration(labelText: "Grade"),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: addStudent,
                  child: Text("Add Student"),
                ),
              ],
            ),
          ),

          // LIST SECTION
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: box.listenable(),
              builder: (context, Box<Student> box, _) {
                if (box.isEmpty) {
                  return Center(child: Text("No Data"));
                }

                return ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    final student = box.getAt(index)!;

                    return Card(
                      child: ListTile(
                        title: Text(student.name),
                        subtitle: Text(
                            "Age: ${student.age} | Course: ${student.grade}"),

                        // DELETE BUTTON
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteStudent(index),
                        ),

                        // EDIT ON TAP
                        onTap: () {
                          showEditDialog(context, student, index);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}