import 'dart:io';

import 'constants.dart';
import 'node.dart';
import 'task.dart';
import 'validation_util.dart';

class FamilyTree {
  static void startApp() {
    // enter a choice to perform task
    Map<int, Node> nodeMap = new Map();
    String choiceString;
    int choice;
    do {
      do {
        print("Enter an integer choice to perform actions\n" +
            "1: get immediate parents\n" +
            "2: get immediate children\n" +
            "3. get ancestors\n" +
            "4. get descendents\n" +
            "5. delete dependency\n" +
            "6. delete node\n" +
            "7. add dependency\n" +
            "8. add node\n" +
            "9. exit app\n");
        choiceString = stdin.readLineSync()!;
      } while (ValidationUtil.validateOption(
          choiceString, Constants.RANGE_BEGIN, Constants.RANGE_END));
      choice = int.parse(choiceString);
      List<int> nodeList;
      switch (choice) {
        case 1:
          if (nodeMap.isNotEmpty) {
            nodeList = Task.getImmediateParents(nodeMap);
            Task.displayList(nodeList);
          } else
            print("add node to perform this operation");
          break;
        case 2:
          if (nodeMap.isNotEmpty) {
            nodeList = Task.getImmediateChildren(nodeMap);
            Task.displayList(nodeList);
          } else
            print("add node to perform this operation");
          break;
        case 3:
          if (nodeMap.isNotEmpty) {
            nodeList = Task.getAncestors(nodeMap);
            Task.displayList(nodeList);
          } else
            print("add node to perform this operation");
          break;
        case 4:
          if (nodeMap.isNotEmpty) {
            nodeList = Task.getDescendents(nodeMap);
            Task.displayList(nodeList);
          } else
            print("add node to perform this operation");
          break;
        case 5:
          if (nodeMap.isNotEmpty)
            Task.deleteDependency(nodeMap);
          else
            print("add node to perform this operation");
          break;
        case 6:
          if (nodeMap.isNotEmpty)
            Task.deleteNode(nodeMap);
          else
            print("add node to perform this operation");
          break;
        case 7:
          if (nodeMap.isNotEmpty)
            Task.addDependency(nodeMap);
          else
            print("add node to perform this operation");
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
    } while (choice != Constants.END);
  }
}
