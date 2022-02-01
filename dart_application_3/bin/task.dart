import 'dart:collection';
import 'dart:io';

import 'node.dart';
import 'validation_util.dart';

class Task {
  /**
   * validate for given node
   * get parent list from given node 
   */
  static List<int> getImmediateParents(Map<int, Node> nodeMap, int nodeId) {
    print("Parents of ${nodeId} are:");
    return nodeMap[nodeId]!.parentList;
  }

  /**
   * validate for given node
   * get children list from given node
   */
  static List<int> getImmediateChildren(Map<int, Node> nodeMap, int nodeId) {
    print("children of ${nodeId} are:");
    return nodeMap[nodeId]!.childrenList;
  }

  /**
   * validate for given node
   * do bfs traversal on given node
   */
  static List<int> getAncestors(Map<int, Node> nodeMap, int nodeId) {
    print("ancestors of ${nodeId} are:");
    return _searchAncestors(nodeMap, nodeId);
  }

  /**
   * validate given node
   * do bfs traversal on given node
   */
  static List<int> getDescendents(Map<int, Node> nodeMap, int nodeId) {
    print("descendents of ${nodeId} are:");
    return _searchDescendents(nodeMap, nodeId);
  }

  /**
   * validate given nodes
   * check if dependency exist
   * delete child node from parent node's children list and delete parent node
   * from child node's parent list to remove dependency
   * 
   */
  static bool deleteDependency(
      Map<int, Node> nodeMap, int parentNode, int childNode) {
    if (!_dependency(parentNode, childNode, nodeMap)) {
      print("dependency do not exist");
      return false;
    }
    nodeMap[parentNode]!.childrenList.remove(childNode);
    nodeMap[childNode]!.parentList.remove(parentNode);

    print("dependency is deleted");
    return true;
  }

  /**
   * validate given node
   * delete all dependencies
   * delete node
   */
  static void deleteNode(Map<int, Node> nodeMap, int node) {
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
  static bool addDependency(
      Map<int, Node> nodeMap, int parentNode, int childNode) {
    /**
     *  check for cyclic dependency before adding
     *  check if child->parent exist then don't add the dependency else
     *  add parent->child
     * */
    if (_checkPath(childNode, parentNode, nodeMap)) {
      print("This dependency can't be added because of cycle");
      return false;
    }

    nodeMap[parentNode]!.childrenList.add(childNode);
    nodeMap[childNode]!.parentList.add(parentNode);
    print("dependnecy is added");
    return true;
  }

  /**
   * create node
   * validate node
   * add node
   */
  static void addNode(Map<int, Node> nodeMap, int nodeId, String nodeName) {
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
