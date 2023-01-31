import 'package:hive/hive.dart';

part 'inventory.g.dart';

@HiveType(typeId: 0)
class Inventory{
  @HiveField(0)
  final String habit;
  @HiveField(1)
  final String date;

  Inventory(this.habit, this.date);

}

