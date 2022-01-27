import 'dart:io';

import 'node.dart';
import 'task.dart';
import 'validation_util.dart';

class FamilyTree {
  static void startApp() {
    Map<int, Node> nodeMap = new Map();
    String choiceString;
    int choice;
    do {
      do {
        print("Enter an integer choice to perform actions" +
            "1: get immediate parents\n" +
            "2: get immediate children\n" +
            "3. get ancestors\n" +
            "4. get descendents\n" +
            "5. delete dependency\n" +
            "6. delete node\n" +
            "7. add dependency\n" +
            "8. add node\n");
        choiceString = stdin.readLineSync()!;
      } while (ValidationUtil.validateOption(choiceString, 1, 8));
      choice = int.parse(choiceString);
      switch (choice) {
        case 1:
          if (nodeMap.isNotEmpty) Task.getImmediateParents(nodeMap);
          break;
        case 2:
          if (nodeMap.isNotEmpty) Task.getImmediateChildren(nodeMap);
          break;
        case 3:
          if (nodeMap.isNotEmpty) Task.getAncestors(nodeMap);
          break;
        case 4:
          if (nodeMap.isNotEmpty) Task.getDescendents(nodeMap);
          break;
        case 5:
          if (nodeMap.isNotEmpty) Task.deleteDependency(nodeMap);
          break;
        case 6:
          if (nodeMap.isNotEmpty) Task.deleteNode(nodeMap);
          break;
        case 7:
          if (nodeMap.isNotEmpty) Task.addDependency(nodeMap);
          break;
        case 8:
          Task.addNode(nodeMap);
          break;
        case 9:
          print("exiting the app");
          break;
        default:
          print("enter valid option");
      }
    } while (choice != 9);
  }
}
