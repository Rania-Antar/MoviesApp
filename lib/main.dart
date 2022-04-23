import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'app_module.dart';
import 'movie_app.dart';

void main() {
  //runApp(const ProviderScope(child: MovieApp()));
  runApp(ModularApp(module: AppModule(), child: MovieApp()));
}
