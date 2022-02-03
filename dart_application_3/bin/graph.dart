import 'dart:collection';
import 'dart:io';

import 'node.dart';

class Graph {
  Map<int, Node> nodeMap = {};

  static Graph? _instance;

  static Graph get instance => _instance ??= Graph._();

  Graph._();
}
