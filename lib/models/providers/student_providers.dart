import 'package:crudproject2/models/student.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class StudentProviders  with ChangeNotifier{
  final Box<Student> _box= Hive.box<Student>('students');

  List<Student>get students => _box.values.toList();

  Box<Student> get box  => _box;

      void addStudent({required String name, required int age, required String grade}) {
    final student = Student(name: name, age: age, grade: grade);
    _box.add(student);
    notifyListeners();
  }

  void updateStudent(int index, {required String name, required int age, required String grade}) {
    final student = Student(name: name, age: age, grade: grade);
    _box.putAt(index, student);
    notifyListeners();
  }

  void deleteStudent(int index) {
    _box.deleteAt(index);
    notifyListeners();
  }

}