import 'dart:math';
import 'package:flutter/material.dart';
import 'package:dark_stories/data/models/story.dart';

class GameScreen extends StatefulWidget {
  final List<Story> allStories;
  final Story initialStory;

  const GameScreen({
    super.key,
    required this.allStories,
    required this.initialStory,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // Текущая история, которую мы показываем.
  // `late` означает, что мы ее инициализируем чуть позже, в initState.
  late Story _currentStory;

  // Переменные состояния для UI
  bool _isSolutionVisible = false;
  int _currentHintIndex = 0;

  @override
  void initState() {
    super.initState();
    // Инициализируем самую первую историю при создании экрана
    _currentStory = widget.initialStory;
  }

  // Метод для выбора следующей случайной истории
  void _pickNextStory() {
    final random = Random();
    Story nextStory;

    // Убедимся, что новая история не совпадает со старой, если это возможно
    do {
      nextStory = widget.allStories[random.nextInt(widget.allStories.length)];
    } while (widget.allStories.length > 1 && nextStory.id == _currentStory.id);

    // Используем setState, чтобы обновить UI новой историей
    // и сбросить все состояния до начальных
    setState(() {
      _currentStory = nextStory;
      _isSolutionVisible = false;
      _currentHintIndex = 0;
    });
  }

  // Метод для показа подсказки
  void _showHint() {
    if (_currentStory.hints.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Для этой истории подсказок нет.')),
      );
      return;
    }

    if (_currentHintIndex < _currentStory.hints.length) {
      final hint = _currentStory.hints[_currentHintIndex];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Подсказка: $hint')),
      );
      // Увеличиваем счетчик, чтобы в следующий раз показать другую подсказку
      setState(() {
        _currentHintIndex++;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Больше подсказок нет!')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentStory.category),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ЗАГАДКА
            Text(
              '«${_currentStory.endingText}»',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontStyle: FontStyle.italic, height: 1.5),
            ),
            const SizedBox(height: 30),

            // РАЗГАДКА (появляется и исчезает)
            // Оборачиваем в Expanded, чтобы занимало доступное место
            Expanded(
              child: AnimatedOpacity(
                opacity: _isSolutionVisible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 400),
                child: _isSolutionVisible
                    ? SingleChildScrollView(
                  child: Card(
                    color: Colors.black.withOpacity(0.3),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        _currentStory.solutionText,
                        style: TextStyle(fontSize: 16, height: 1.6, color: Colors.white.withOpacity(0.8)),
                      ),
                    ),
                  ),
                )
                    : const SizedBox.shrink(),
              ),
            ),

            // КНОПКИ УПРАВЛЕНИЯ ВНИЗУ
            const SizedBox(height: 20),
            // Кнопка-спойлер
            OutlinedButton.icon(
              icon: Icon(_isSolutionVisible ? Icons.visibility_off : Icons.visibility),
              label: Text(_isSolutionVisible ? 'Скрыть разгадку' : 'Показать разгадку'),
              onPressed: () => setState(() => _isSolutionVisible = !_isSolutionVisible),
            ),
            const SizedBox(height: 10),

            // Новая кнопка для подсказок
            OutlinedButton.icon(
              icon: const Icon(Icons.lightbulb_outline),
              label: const Text('Показать подсказку'),
              onPressed: _showHint,
            ),
            const SizedBox(height: 20),

            // Кнопка "Следующая история"
            ElevatedButton(
              onPressed: _pickNextStory, // Вызываем наш новый метод
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