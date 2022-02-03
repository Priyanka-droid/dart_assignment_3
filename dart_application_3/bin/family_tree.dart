import 'dart:io';

import 'constants.dart';
import 'graph.dart';
import 'task.dart';
import 'utilities.dart';
import 'validation_util.dart';

class FamilyTree {
  static void startApp() {
    Graph graph = Graph.instance;
    Task task = Task();
    // enter a choice to perform graph
    // Map<int, Node> graph.nodeMap = new Map();
    String choice;
    do {
      do {
        print('''
Enter a choice to perform actions
1: get immediate parents
2: get immediate children
3. get ancestors
4. get descendents
5. delete dependency
6. delete node
7. add dependency
8. add node
9. exit app''');
        choice = stdin.readLineSync()!;
      } while (ValidationUtil.validateOption(
          choice, Constants.RANGE_BEGIN, Constants.RANGE_END));

      Set<int> nodeList;
      switch (int.parse(choice)) {
        /**
         * Returns immediate parents list
         */
        case 1:
          if (graph.nodeMap.isNotEmpty) {
            int nodeId = Utility.inputNodes(1)[0];
            // TESTING
            if (nodeExist(nodeId)) {
              nodeList = task.getImmediateParents(nodeId);
              Utility.displayList(nodeList);
            } else {
              print("node not exist");
            }
          } else {
            print("add node to perform this operation");
          }
          break;
        /**
         * Returns immediate children list
         */
        case 2:
          if (graph.nodeMap.isNotEmpty) {
            int nodeId = Utility.inputNodes(1)[0];
            // TESTING
            if (nodeExist(nodeId)) {
              nodeList = task.getImmediateChildren(nodeId);
              Utility.displayList(nodeList);
            } else {
              print("node not exist");
            }
          } else {
            print("add node to perform this operation");
          }
          break;
        /**
         * Returns ancestors list
         */
        case 3:
          if (graph.nodeMap.isNotEmpty) {
            int nodeId = Utility.inputNodes(1)[0];
            // TESTING
            if (nodeExist(nodeId)) {
              nodeList = task.getAncestors(nodeId);
              Utility.displayList(nodeList);
            } else {
              print("node not exist");
            }
          } else {
            print("add node to perform this operation");
          }
          break;
        /**
         * Returns descendentslist
         */
        case 4:
          if (graph.nodeMap.isNotEmpty) {
            int nodeId = Utility.inputNodes(1)[0];
            // TESTING
            if (nodeExist(nodeId)) {
              nodeList = task.getDescendents(nodeId);
              Utility.displayList(nodeList);
            } else {
              print("node not exist");
            }
          } else {
            print("add node to perform this operation");
          }
          break;
        /**
         * deletes dependency and returns true if dependency existed
         *  and is deleted else returns false
         */
        case 5:
          if (graph.nodeMap.isNotEmpty) {
            List<int> nodes = Utility.inputNodes(2);
            if (nodeExist(nodes[0]) && nodeExist(nodes[1])) {
              bool deleted = task.deleteDependency(nodes[0], nodes[1]);
            } else {
              print("node not exist");
            }
          } else {
            print("add node to perform this operation");
          }
          break;
        /**
         * deletes node 
         *  
         */
        case 6:
          if (graph.nodeMap.isNotEmpty) {
            int nodeId = Utility.inputNodes(1)[0];
            if (nodeExist(nodeId)) {
              task.deleteNode(nodeId);
            } else {
              print("node not exist");
            }
          } else {
            print("add node to perform this operation");
          }
          break;
        /**
         * adds dependency and returns true if cycle not exist
         *  and is added else returns false
         */
        case 7:
          if (graph.nodeMap.isNotEmpty) {
            List<int> nodes = Utility.inputNodes(2);
            if (nodeExist(nodes[0]) && nodeExist(nodes[1])) {
              bool added = task.addDependency(nodes[0], nodes[1]);
            } else {
              print("node not exist");
            }
          } else {
            print("add node to perform this operation");
          }
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
            } while (ValidationUtil.validateNode(nodeIdString));

            nodeId = int.parse(nodeIdString);
            if (!nodeExist(nodeId)) {
              do {
                print("Enter the node name");
                nodeName = stdin.readLineSync()!;
              } while (ValidationUtil.validateName(nodeName));
              task.addNode(nodeId, nodeName);
            } else {
              print("node already exist");
            }
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
    } while (choice != Constants.RANGE_END.toString());
  }

  static bool nodeExist(int nodeId) {
    if (Graph.instance.nodeMap.containsKey(nodeId)) {
      return true;
    }

    return false;
  }
}
