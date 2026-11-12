import 'package:flutter/material.dart';
import 'app/app.dart';
import 'app/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const ShoplyApp());
}