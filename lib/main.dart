import 'package:crudproject2/student.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart'; 
import 'StudentScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(StudentAdapter());
  await Hive.openBox<Student>('students');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(backgroundColor: Colors.teal,),
        body: StudentScreen(),  // ← Change this line
      ),
    );
  }
}