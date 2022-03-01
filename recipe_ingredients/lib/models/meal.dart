import 'package:flutter/foundation.dart';

class meal {
  final String id;
  final List <String> categories;
  final String title;
  final String imageUrl;
  final List <String> ingredients;
  final List <String> steps;
  final int duration;

 const meal ({
  @required this.id='',
   required this.categories,
  @required this.title='',
  @required this.imageUrl='',
  @required this.duration=0,
  required this.ingredients,
  required this.steps,
});
}