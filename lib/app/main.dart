import 'package:flutter/material.dart';
import 'package:dark_stories/ui/screens/home_screen.dart'; // Мы скоро создадим этот файл

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'До того как стало страшно',
      // Убираем отладочную ленту "DEBUG" в углу
      debugShowCheckedModeBanner: false,

      // Задаем базовую темную тему для всего приложения
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple, // Основной цвет, можно будет поменять
        scaffoldBackgroundColor: const Color(0xFF121212), // Очень темный фон
        fontFamily: 'Roboto', // Можно будет добавить кастомный шрифт
      ),

      // Указываем, какой экран будет домашним
      home: HomeScreen(),
    );
  }
}