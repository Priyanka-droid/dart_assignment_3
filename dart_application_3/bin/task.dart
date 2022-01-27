import 'dart:collection';
import 'dart:io';

import 'node.dart';
import 'validation_util.dart';

class Task {
  static void getImmediateParents(Map<int, Node> nodeMap) {
    String nodeIdString;
    int nodeId;
    do {
      print("Enter node id to get immediate parents");
      nodeIdString = stdin.readLineSync()!;
    } while (ValidationUtil.validateNode(nodeIdString, nodeMap));
    nodeId = int.parse(nodeIdString);
    List<int> parentList = nodeMap[nodeId]!.parentList;
    parentList.forEach((parent) {
      print("parents are ${parent} \n");
    });
  }

  static void getImmediateChildren(Map<int, Node> nodeMap) {
    String nodeIdString;
    int nodeId;
    do {
      print("Enter node id to get immediate children");
      nodeIdString = stdin.readLineSync()!;
    } while (ValidationUtil.validateNode(nodeIdString, nodeMap));
    nodeId = int.parse(nodeIdString);
    List<int> childrenList = nodeMap[nodeId]!.childrenList;
    childrenList.forEach((children) {
      print("children are ${children}\n");
    });
  }

  static void getAncestors(Map<int, Node> nodeMap) {
    String nodeIdString;
    int nodeId;
    do {
      print("Enter node id to get it's ancestors");
      nodeIdString = stdin.readLineSync()!;
    } while (ValidationUtil.validateNode(nodeIdString, nodeMap));
    nodeId = int.parse(nodeIdString);
    List<int> ancestorList = _searchAncestors(nodeMap, nodeId);
    ancestorList.forEach((ancestor) {
      print("ancestors are ${ancestor}\n");
    });
  }

  static void getDescendents(Map<int, Node> nodeMap) {
    String nodeIdString;
    int nodeId;
    do {
      print("Enter node id to get it's ancestors");
      nodeIdString = stdin.readLineSync()!;
    } while (ValidationUtil.validateNode(nodeIdString, nodeMap));
    nodeId = int.parse(nodeIdString);
    List<int> descendentList = _searchDescendents(nodeMap, nodeId);
    descendentList.forEach((ancestor) {
      print("ancestors are ${ancestor}\n");
    });
  }

  static void deleteDependency(Map<int, Node> nodeMap) {
    String parentNodeString, childNodeString;
    int parentNode, childNode;
    do {
      print("Enter parent node and child node to delete dependency");
      parentNodeString = stdin.readLineSync()!;
      childNodeString = stdin.readLineSync()!;
    } while (ValidationUtil.validateNode(parentNodeString, nodeMap) &&
        ValidationUtil.validateNode(childNodeString, nodeMap));
    parentNode = int.parse(parentNodeString);
    childNode = int.parse(childNodeString);
    if (!_dependency(parentNode, childNode, nodeMap)) {
      print("dependency do not exist");
    }
    nodeMap[parentNode]!.childrenList.remove(childNode);
    nodeMap[childNode]!.parentList.remove(parentNode);
    print("dependency is deleted");
  }

  static void deleteNode(Map<int, Node> nodeMap) {
    String nodeIdString;
    int node;
    do {
      print("Enter Node to be deleted");
      nodeIdString = stdin.readLineSync()!;
    } while (ValidationUtil.validateNode(nodeIdString, nodeMap));
    node = int.parse(nodeIdString);
    nodeMap[node]!.parentList.forEach((parent) {
      nodeMap[parent]!.childrenList.remove(node);
    });
    nodeMap[node]!.childrenList.forEach((child) {
      nodeMap[child]!.parentList.remove(node);
    });
    nodeMap.remove(node);
    print("given node is deleted");
  }

  static void addDependency(Map<int, Node> nodeMap) {
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
    /**
     *  TODO: check for cyclic dependency before adding
     *  check if child->parent exist then don't add the dependency else
     *  add parent->child
     * */

    nodeMap[parentNode]!.childrenList.add(childNode);
    nodeMap[childNode]!.parentList.add(parentNode);
  }

  static void addNode(Map<int, Node> nodeMap) {
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
    List<int> childrenList = [];
    List<int> parentList = [];
    Node newNode = new Node(
        nodeId: nodeId,
        nodeName: nodeName,
        childrenList: childrenList,
        parentList: parentList);
    nodeMap[nodeId] = newNode;
  }

  static bool _dependency(
      int parentNode, int childNode, Map<int, Node> nodeMap) {
    bool exist = nodeMap[parentNode]!.childrenList.contains(childNode);
    return exist;
  }

  static List<int> _searchAncestors(Map<int, Node> nodeMap, int node) {
    Queue<int> nodeQueue = new Queue();
    nodeQueue.add(node);
    nodeMap[node]!.visited = true;
    List<int> ancestorList = [];
    while (nodeQueue.isNotEmpty) {
      int nodeAncestor = nodeQueue.removeLast();
      if (nodeAncestor != node) ancestorList.add(nodeAncestor);
      for (int link in nodeMap[nodeAncestor]!.parentList) {
        if (!nodeMap[link]!.visited) {
          nodeMap[link]!.visited = true;
          nodeQueue.add(link);
        }
      }
    }
    nodeMap.forEach((node, value) {
      value.visited = false;
    });
    return ancestorList;
  }

  static List<int> _searchDescendents(Map<int, Node> nodeMap, int node) {
    Queue<int> nodeQueue = new Queue();
    nodeQueue.add(node);
    nodeMap[node]!.visited = true;
    List<int> descendentList = [];
    while (nodeQueue.isNotEmpty) {
      int nodeAncestor = nodeQueue.removeLast();
      if (nodeAncestor != node) descendentList.add(nodeAncestor);
      for (int link in nodeMap[nodeAncestor]!.childrenList) {
        if (!nodeMap[link]!.visited) {
          nodeMap[link]!.visited = true;
          nodeQueue.add(link);
        }
      }
    }
    nodeMap.forEach((node, value) {
      value.visited = false;
    });
    return descendentList;
  }
}
