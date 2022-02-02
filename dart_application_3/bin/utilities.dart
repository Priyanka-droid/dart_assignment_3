import 'dart:io';

import 'validation_util.dart';

class Utility {
  static List<int> inputNodes(int nodes) {
    if (nodes == 1) {
      String nodeId;
      do {
        print("Enter node id ");
        nodeId = stdin.readLineSync()!;
      } while (ValidationUtil.validateNode(nodeId));
      return [int.parse(nodeId)];
    } else if (nodes == 2) {
      String parentNode, childNode;
      do {
        print("Enter parent and child node");
        parentNode = stdin.readLineSync()!;
        childNode = stdin.readLineSync()!;
      } while (ValidationUtil.validateNode(parentNode) ||
          ValidationUtil.validateNode(childNode));
      return [int.parse(parentNode), int.parse(childNode)];
    } else {
      return [];
    }
  }

  // display list of nodes required
  static void displayList(Set<int> nodeList) {
    if (nodeList.isEmpty) {
      print("no elements in this list");
      return;
    }
    for (int node in nodeList) {
      stdout.write(" ${node} ,");
    }
    print("\n");
  }
}
