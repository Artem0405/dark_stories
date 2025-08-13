import 'package:flutter/material.dart';
import 'package:dark_stories/data/models/story.dart';

class GameScreen extends StatefulWidget {
  final Story story;

  const GameScreen({
    super.key,
    required this.story,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // Переменная состояния, которая отвечает за показ разгадки
  bool _isSolutionVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.story.category), // Показываем категорию в заголовке
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ЗАГАДКА (для всех)
            Text(
              '«${widget.story.endingText}»',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 30),

            // КНОПКА-СПОЙЛЕР
            OutlinedButton.icon(
              icon: Icon(
                _isSolutionVisible ? Icons.visibility_off : Icons.visibility,
              ),
              label: Text(
                _isSolutionVisible ? 'Скрыть разгадку' : 'Показать разгадку',
              ),
              onPressed: () {
                // При нажатии меняем состояние и перерисовываем экран
                setState(() {
                  _isSolutionVisible = !_isSolutionVisible;
                });
              },
            ),
            const SizedBox(height: 20),

            // РАЗГАДКА (появляется и исчезает)
            // Используем анимированный виджет для плавности
            AnimatedOpacity(
              opacity: _isSolutionVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 400),
              child: _isSolutionVisible
                  ? Card(
                color: Colors.black.withOpacity(0.3),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.story.solutionText,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ),
              )
                  : const SizedBox.shrink(), // Если скрыто, не занимает места
            ),

            // Оставляем место для кнопок внизу
            const Spacer(),

            // КНОПКИ УПРАВЛЕНИЯ
            ElevatedButton(
              onPressed: () {
                // TODO: Реализовать переход к следующей истории
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
              ),
              child: const Text('Следующая история'),
            ),
          ],
        ),
      ),
    );
  }
}