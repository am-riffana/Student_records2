import 'package:crudproject2/models/providers/student_providers.dart';
import 'package:crudproject2/models/student.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart'; 
import 'models/screen/StudentScreen.dart';

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
    return  ChangeNotifierProvider(create: (context)=> StudentProviders(),
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: StudentScreen(), 
      ),
    ),
    );
  }
  }