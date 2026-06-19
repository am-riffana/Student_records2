import 'package:crudproject2/models/providers/student_providers.dart';
import 'package:crudproject2/models/student.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentScreen extends StatefulWidget {
   const  StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final gradeController = TextEditingController();

  void showEditDialog(BuildContext context, Student student, int index) {
    nameController.text = student.name;
    ageController.text = student.age.toString();
    gradeController.text = student.grade;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title:  Text("Edit Student"),
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
              context.read<StudentProviders>().updateStudent(
                    index,
                    name: nameController.text,
                    age: int.parse(ageController.text),
                    grade: gradeController.text,
                  );
              Navigator.pop(context);
            },
            child:  Text("Update"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 197, 222, 234),
      appBar: AppBar(title:  Text("Student Records",style: TextStyle(color: Colors.white),),
      backgroundColor: const Color.fromARGB(255, 22, 56, 71),),
      body: Column(
        children: [
          Padding(
            padding:  EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration:  InputDecoration(labelText: "Name"),
                ),
                TextField(
                  controller: ageController,
                  decoration:  InputDecoration(labelText: "Age"),
                ),
                TextField(
                  controller: gradeController,
                  decoration:  InputDecoration(labelText: "Grade"),
                ),
                 SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    context.read<StudentProviders>().addStudent(
                          name: nameController.text,
                          age: int.parse(ageController.text),
                          grade: gradeController.text,
                        );
                    nameController.clear();
                    ageController.clear();
                    gradeController.clear();
                  },
                  child: 
                   Text("Add Student"),
                  
                  
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<StudentProviders>(
              builder: (context, studentProvider, child) {
                final students = studentProvider.students;

                if (students.isEmpty) {
                  return  Center(child: Text("No Data"));
                }

                return ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    final student = students[index];

                    return Card(
                      child: ListTile(
                        title: Text(student.name),
                        subtitle: Text(
                            "Age: ${student.age} | Course: ${student.grade}"),
                        trailing: IconButton(
                          icon:  Icon(Icons.delete,
                              color: const Color.fromARGB(255, 136, 36, 29)),
                          onPressed: () {
                            context.read<StudentProviders>().deleteStudent(index);
                          },
                        ),
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