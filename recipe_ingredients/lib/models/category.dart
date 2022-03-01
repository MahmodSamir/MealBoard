import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class category {
  final String id;
  final String title;
  final Color color;

  const category({
    @required this.id="",
    @required this.title = "x",
    this.color = Colors.teal,
  });
}