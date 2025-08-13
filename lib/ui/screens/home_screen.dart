import 'dart:math';
import 'package:dark_stories/data/models/story.dart';
import 'package:dark_stories/data/repositories/story_repository.dart';
import 'package:dark_stories/ui/screens/game_screen.dart';
import 'package:dark_stories/ui/screens/rules_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Создаем экземпляр нашего репозитория.
  // Он будет жить, пока существует HomeScreen.
  final StoryRepository _storyRepository = StoryRepository();

  // Создаем асинхронный метод для запуска игры.
  // Он принимает BuildContext для навигации и показа уведомлений.
  void _startGame(BuildContext context) async {
    try {
      // 1. Получаем список всех историй из репозитория.
      // await "ждет", пока асинхронная операция не завершится.
      final List<Story> allStories = await _storyRepository.getAllStories();

      // Проверяем, не пуст ли список.
      if (allStories.isEmpty) {
        // Если историй нет, показываем пользователю уведомление.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Не удалось загрузить истории! Убедитесь, что файл assets/data/stories.json не пуст.')),
        );
        return; // Прерываем выполнение функции
      }

      // 2. Выбираем случайную историю.
      final random = Random();
      final Story randomStory = allStories[random.nextInt(allStories.length)];

      // 3. Переходим на игровой экран.
      // `context.mounted` - это стандартная проверка, чтобы убедиться,
      // что виджет все еще существует на экране перед асинхронной операцией.
      if (!context.mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          // Передаем выбранную историю на игровой экран через конструктор.
          builder: (context) => GameScreen(story: randomStory),
        ),
      );
    } catch (e) {
      // Блок catch для отлова любых ошибок во время загрузки или парсинга.
      print('Ошибка при запуске игры: $e');
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Произошла ошибка при загрузке данных.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Основной контент экрана, центрированный
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Заголовок игры
                    const Text(
                      'До того как стало страшно',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 80),

                    // Кнопка "Начать игру"
                    ElevatedButton(
                      onPressed: () => _startGame(context),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        backgroundColor: Colors.deepPurple,
                        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      child: const Text('Начать игру'),
                    ),
                    const SizedBox(height: 20),

                    // Кнопка "Правила"
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RulesScreen()),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        foregroundColor: Colors.white70,
                        side: const BorderSide(color: Colors.white54),
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      child: const Text('Правила'),
                    ),
                  ],
                ),
              ),
            ),

            // Авторская подпись внизу экрана
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'by ArtTech',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.5),
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}