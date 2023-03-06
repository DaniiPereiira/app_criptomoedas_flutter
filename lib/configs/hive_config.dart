import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:hive_flutter/hive_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';   

class HiveConfig {
  static start() async {
    Directory dir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(dir.path);
  }
}
