import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:dark_stories/data/models/story.dart';

class StoryRepository {
  // Приватный список для кэширования историй, чтобы не читать файл каждый раз
  List<Story>? _cachedStories;

  // Метод для получения всех историй
  Future<List<Story>> getAllStories() async {
    // Если истории уже были загружены, возвращаем их из кэша
    if (_cachedStories != null) {
      return _cachedStories!;
    }

    // 1. Загружаем строковое содержимое нашего JSON-файла из ассетов
    final String jsonString = await rootBundle.loadString('assets/data/stories.json');

    // 2. Декодируем строку JSON в список динамических объектов
    final List<dynamic> jsonList = json.decode(jsonString);

    // 3. Преобразуем (мапим) каждый JSON-объект в объект класса Story
    //    используя наш фабричный конструктор Story.fromJson
    final List<Story> stories = jsonList.map((jsonItem) => Story.fromJson(jsonItem)).toList();

    // Сохраняем истории в кэш и возвращаем их
    _cachedStories = stories;
    return stories;
  }
}