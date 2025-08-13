import 'package:flutter/material.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar - это верхняя панель с заголовком и кнопкой "назад"
      appBar: AppBar(
        title: const Text('Правила игры'),
        backgroundColor: Colors.transparent, // Прозрачный, чтобы сливался с фоном
        elevation: 0, // Без тени
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          // Виджет для одного блока правил
          _RuleSection(
            title: '📜 Для Рассказчика (Ведущего)',
            content: '1. Прочтите вслух финал истории.\n\n'
                '2. Изучите полную разгадку, не показывая ее остальным.\n\n'
                '3. Отвечайте на вопросы игроков только "Да", "Нет" или "Не имеет значения".\n\n'
                '4. Используйте подсказки, если команда в тупике.\n\n'
                '5. Когда история разгадана, нажмите "История разгадана!" и передайте ход.',
          ),
          SizedBox(height: 24),
          _RuleSection(
            title: '🕵️ Для Детективов (Отгадывающих)',
            content: '1. Внимательно выслушайте финал истории.\n\n'
                '2. Задавайте вопросы, на которые можно ответить "Да/Нет".\n\n'
                '3. Думайте нестандартно! Собирайте факты из ответов "Да", чтобы сложить общую картину.',
          ),
        ],
      ),
    );
  }
}

// Приватный виджет для секции правил, чтобы не дублировать код
class _RuleSection extends StatelessWidget {
  final String title;
  final String content;

  const _RuleSection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurpleAccent,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          content,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withOpacity(0.8),
            height: 1.5, // Межстрочный интервал
          ),
        ),
      ],
    );
  }
}