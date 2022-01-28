import 'dart:collection';
import 'dart:io';

import 'node.dart';
import 'validation_util.dart';

class Task {
  /**
   * validate for given node
   * get parent list from given node 
   */
  static List<int> getImmediateParents(Map<int, Node> nodeMap) {
    String nodeIdString;
    List<int> parentList;
    int nodeId;
    do {
      print("Enter node id to get immediate parents");
      nodeIdString = stdin.readLineSync()!;
    } while (ValidationUtil.validateNode(nodeIdString, nodeMap));
    nodeId = int.parse(nodeIdString);
    parentList = nodeMap[nodeId]!.parentList;
    print("Parents of ${nodeId} are:");
    return parentList;
  }

  /**
   * validate for given node
   * get children list from given node
   */
  static List<int> getImmediateChildren(Map<int, Node> nodeMap) {
    String nodeIdString;
    List<int> childrenList;
    int nodeId;
    do {
      print("Enter node id to get immediate children");
      nodeIdString = stdin.readLineSync()!;
    } while (ValidationUtil.validateNode(nodeIdString, nodeMap));
    nodeId = int.parse(nodeIdString);
    childrenList = nodeMap[nodeId]!.childrenList;
    print("children of ${nodeId} are:");
    return childrenList;
  }

  /**
   * validate for given node
   * do bfs traversal on given node
   */
  static List<int> getAncestors(Map<int, Node> nodeMap) {
    String nodeIdString;
    List<int> ancestorList;
    int nodeId;
    do {
      print("Enter node id to get it's ancestors");
      nodeIdString = stdin.readLineSync()!;
    } while (ValidationUtil.validateNode(nodeIdString, nodeMap));
    nodeId = int.parse(nodeIdString);
    ancestorList = _searchAncestors(nodeMap, nodeId);
    print("ancestors of ${nodeId} are:");
    return ancestorList;
  }

  /**
   * validate given node
   * do bfs traversal on given node
   */
  static List<int> getDescendents(Map<int, Node> nodeMap) {
    String nodeIdString;
    List<int> descendentList;
    int nodeId;
    do {
      print("Enter node id to get it's descendents");
      nodeIdString = stdin.readLineSync()!;
    } while (ValidationUtil.validateNode(nodeIdString, nodeMap));
    nodeId = int.parse(nodeIdString);
    descendentList = _searchDescendents(nodeMap, nodeId);
    print("descendents of ${nodeId} are:");
    return descendentList;
  }

  /**
   * validate given nodes
   * check if dependency exist
   * delete child node from parent node's children list and delete parent node
   * from child node's parent list to remove dependency
   * 
   */
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
      return;
    }
    nodeMap[parentNode]!.childrenList.remove(childNode);
    nodeMap[childNode]!.parentList.remove(parentNode);
    print("dependency is deleted");
  }

  /**
   * validate given node
   * delete all dependencies
   * delete node
   */
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

  /**
   * validate nodes
   * check if cycle exist
   * add dependency
   */
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
    if (_checkPath(childNode, parentNode, nodeMap)) {
      print("This dependency can't be added because of cycle");
      return;
    }

    nodeMap[parentNode]!.childrenList.add(childNode);
    nodeMap[childNode]!.parentList.add(parentNode);
    print("dependnecy is added");
  }

  /**
   * create node
   * validate node
   * add node
   */
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

  /**
   * check if dependency exist
   */
  static bool _dependency(
      int parentNode, int childNode, Map<int, Node> nodeMap) {
    bool exist = nodeMap[parentNode]!.childrenList.contains(childNode);
    return exist;
  }

  /**
   * bfs traversal for ancestors
   */
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

  /**
   * bfs traversal for descendents
   */
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

  /**
   * bfs traversal to check path from child->parent
   */
  static bool _checkPath(
      int childNode, int parentNode, Map<int, Node> nodeMap) {
    Queue<int> nodeQueue = new Queue();
    nodeQueue.add(childNode);
    nodeMap[childNode]!.visited = true;
    while (nodeQueue.isNotEmpty) {
      int nodeAncestor = nodeQueue.removeLast();
      for (int link in nodeMap[nodeAncestor]!.childrenList) {
        if (link == parentNode) return true;
        if (!nodeMap[link]!.visited) {
          nodeMap[link]!.visited = true;
          nodeQueue.add(link);
        }
      }
    }
    nodeMap.forEach((node, value) {
      value.visited = false;
    });
    return false;
  }

  // display list of nodes required
  static void displayList(List<int> nodeList) {
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
