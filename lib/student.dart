import 'package:hive/hive.dart';

part 'student.g.dart';

@HiveType(typeId: 1)

class Student  extends HiveObject{
  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  @HiveField(2)
  String grade;

  Student ({required this.name, required this.age, required this.grade});
}