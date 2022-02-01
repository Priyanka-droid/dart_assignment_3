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
        print("Enter a choice to perform actions\n" +
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
        /**
         * Returns immediate parents list
         */
        case 1:
          if (nodeMap.isNotEmpty) {
            int nodeId = _inputNodes(nodeMap, 1)[0];
            // TESTING
            nodeList = Task.getImmediateParents(nodeMap, nodeId);
            Task.displayList(nodeList);
          } else
            print("add node to perform this operation");
          break;
        /**
         * Returns immediate children list
         */
        case 2:
          if (nodeMap.isNotEmpty) {
            int nodeId = _inputNodes(nodeMap, 1)[0];
            // TESTING
            nodeList = Task.getImmediateChildren(nodeMap, nodeId);
            Task.displayList(nodeList);
          } else
            print("add node to perform this operation");
          break;
        /**
         * Returns ancestors list
         */
        case 3:
          if (nodeMap.isNotEmpty) {
            int nodeId = _inputNodes(nodeMap, 1)[0];
            // TESTING
            nodeList = Task.getAncestors(nodeMap, nodeId);
            Task.displayList(nodeList);
          } else
            print("add node to perform this operation");
          break;
        /**
         * Returns descendentslist
         */
        case 4:
          if (nodeMap.isNotEmpty) {
            int nodeId = _inputNodes(nodeMap, 1)[0];
            // TESTING
            nodeList = Task.getDescendents(nodeMap, nodeId);
            Task.displayList(nodeList);
          } else
            print("add node to perform this operation");
          break;
        /**
         * deletes dependency and returns true if dependency existed
         *  and is deleted else returns false
         */
        case 5:
          if (nodeMap.isNotEmpty) {
            int parentNode = _inputNodes(nodeMap, 1)[0];
            int childNode = _inputNodes(nodeMap, 1)[1];
            bool deleted =
                Task.deleteDependency(nodeMap, parentNode, childNode);
          } else
            print("add node to perform this operation");
          break;
        /**
         * deletes node 
         *  
         */
        case 6:
          if (nodeMap.isNotEmpty) {
            int nodeId = _inputNodes(nodeMap, 1)[0];
            Task.deleteNode(nodeMap, nodeId);
          } else
            print("add node to perform this operation");
          break;
        /**
         * adds dependency and returns true if cycle not exist
         *  and is added else returns false
         */
        case 7:
          if (nodeMap.isNotEmpty) {
            int parentNode = _inputNodes(nodeMap, 1)[0];
            int childNode = _inputNodes(nodeMap, 1)[1];
            bool added = Task.addDependency(nodeMap, parentNode, childNode);
          } else
            print("add node to perform this operation");
          break;
        /**
          * adds node 
          */
        case 8:
          {
            String nodeIdString, nodeName;
            int nodeId;
            do {
              print("Enter the node Id");
              nodeIdString = stdin.readLineSync()!;
            } while (ValidationUtil.validateNodeAdd(nodeIdString, nodeMap));

            nodeId = int.parse(nodeIdString);
            do {
              print("Enter the node name");
              nodeName = stdin.readLineSync()!;
            } while (ValidationUtil.validateName(nodeName));
            Task.addNode(nodeMap, nodeId, nodeName);
          }

          break;
        /**
         * exits app
         */
        case 9:
          print("exiting the app");
          break;
        default:
          print("enter valid option");
      }
    } while (choice != Constants.END);
  }

  /**
         * takes input of 1 node or 2 nodes based on parameter
         */
  static List<int> _inputNodes(Map<int, Node> nodeMap, int nodes) {
    if (nodes == 1) {
      String nodeIdString;
      List<int> childrenList;
      int nodeId;
      do {
        print("Enter node id to get immediate children");
        nodeIdString = stdin.readLineSync()!;
      } while (ValidationUtil.validateNode(nodeIdString, nodeMap));
      nodeId = int.parse(nodeIdString);
      return [nodeId];
    } else if (nodes == 2) {
      String parentNodeString, childNodeString;
      int parentNode, childNode;
      do {
        print("Enter parent and child node to create dependency");
        parentNodeString = stdin.readLineSync()!;
        childNodeString = stdin.readLineSync()!;
      } while (ValidationUtil.validateNode(parentNodeString, nodeMap) &&
          ValidationUtil.validateNode(childNodeString, nodeMap));

      parentNode = int.parse(parentNodeString);
      childNode = int.parse(childNodeString);
      return [parentNode, childNode];
    } else
      return [];
  }
}
