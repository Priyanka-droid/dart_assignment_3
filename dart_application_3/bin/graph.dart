import 'dart:collection';
import 'dart:io';

import 'node.dart';

class Graph {
  Graph._();
  static final Graph _instance = Graph._();
  Map<int, Node> nodeMap = {};

  factory Graph() {
    return _instance;
  }
}
