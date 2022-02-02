import 'dart:collection';
import 'dart:io';

import 'graph.dart';
import 'interface_task.dart';
import 'node.dart';

class Task implements InterfaceTask {
  /**
   * validate for given node
   * get parent list from given node 
   */
  @override
  Set<int> getImmediateParents(int nodeId) {
    Graph graph = new Graph();
    print("Parents of ${nodeId} are:");
    return graph.nodeMap[nodeId]!.parentList;
  }

  /**
   * validate for given node
   * get children list from given node
   */
  @override
  Set<int> getImmediateChildren(int nodeId) {
    Graph graph = new Graph();
    print("children of ${nodeId} are:");
    return graph.nodeMap[nodeId]!.childrenList;
  }

  /**
   * validate for given node
   * do bfs traversal on given node
   */
  @override
  Set<int> getAncestors(int nodeId) {
    Graph graph = new Graph();
    print("ancestors of ${nodeId} are:");
    return _searchAncestors(nodeId);
  }

  /**
   * validate given node
   * do bfs traversal on given node
   */
  @override
  Set<int> getDescendents(int nodeId) {
    Graph graph = new Graph();
    print("descendents of ${nodeId} are:");
    return _searchDescendents(nodeId);
  }

  /**
   * validate given nodes
   * check if dependency exist
   * delete child node from parent node's children list and delete parent node
   * from child node's parent list to remove dependency
   * 
   */
  @override
  bool deleteDependency(int parentNode, int childNode) {
    Graph graph = new Graph();
    if (!_dependency(parentNode, childNode)) {
      print("dependency do not exist");
      return false;
    }
    graph.nodeMap[parentNode]!.childrenList.remove(childNode);
    graph.nodeMap[childNode]!.parentList.remove(parentNode);

    print("dependency is deleted");
    return true;
  }

  /**
   * validate given node
   * delete all dependencies
   * delete node
   */
  @override
  void deleteNode(int node) {
    Graph graph = new Graph();
    graph.nodeMap[node]!.parentList.forEach((parent) {
      graph.nodeMap[parent]!.childrenList.remove(node);
    });
    graph.nodeMap[node]!.childrenList.forEach((child) {
      graph.nodeMap[child]!.parentList.remove(node);
    });
    graph.nodeMap.remove(node);
    print("given node is deleted");
  }

  /**
   * validate nodes
   * check if cycle exist
   * add dependency
   */
  @override
  bool addDependency(int parentNode, int childNode) {
    Graph graph = new Graph();
    /**
     *  check for cyclic dependency before adding
     *  check if child->parent exist then don't add the dependency else
     *  add parent->child
     * */
    if (_checkPath(childNode, parentNode)) {
      print("This dependency can't be added because of cycle");
      return false;
    }

    graph.nodeMap[parentNode]!.childrenList.add(childNode);
    graph.nodeMap[childNode]!.parentList.add(parentNode);
    print("dependnecy is added");
    return true;
  }

  /**
   * create node
   * validate node
   * add node
   */
  @override
  void addNode(int nodeId, String nodeName) {
    Graph graph = new Graph();
    Set<int> childrenList = {};
    Set<int> parentList = {};
    Node newNode = new Node(
        nodeId: nodeId,
        nodeName: nodeName,
        childrenList: childrenList,
        parentList: parentList);
    graph.nodeMap[nodeId] = newNode;
  }

  /**
   * check if dependency exist
   */
  bool _dependency(int parentNode, int childNode) {
    Graph graph = new Graph();
    bool exist = graph.nodeMap[parentNode]!.childrenList.contains(childNode);
    return exist;
  }

  /**
   * bfs traversal for ancestors
   */
  Set<int> _searchAncestors(int node) {
    Graph graph = new Graph();
    Queue<int> nodeQueue = new Queue();
    nodeQueue.add(node);
    graph.nodeMap[node]!.visited = true;
    Set<int> ancestorList = {};
    while (nodeQueue.isNotEmpty) {
      int nodeAncestor = nodeQueue.removeLast();
      if (nodeAncestor != node) ancestorList.add(nodeAncestor);
      for (int link in graph.nodeMap[nodeAncestor]!.parentList) {
        if (!graph.nodeMap[link]!.visited) {
          graph.nodeMap[link]!.visited = true;
          nodeQueue.add(link);
        }
      }
    }
    graph.nodeMap.forEach((node, value) {
      value.visited = false;
    });
    return ancestorList;
  }

  /**
   * bfs traversal for descendents
   */
  Set<int> _searchDescendents(int node) {
    Graph graph = new Graph();
    Queue<int> nodeQueue = new Queue();
    nodeQueue.add(node);
    graph.nodeMap[node]!.visited = true;
    Set<int> descendentList = {};
    while (nodeQueue.isNotEmpty) {
      int nodeAncestor = nodeQueue.removeLast();
      if (nodeAncestor != node) descendentList.add(nodeAncestor);
      for (int link in graph.nodeMap[nodeAncestor]!.childrenList) {
        if (!graph.nodeMap[link]!.visited) {
          graph.nodeMap[link]!.visited = true;
          nodeQueue.add(link);
        }
      }
    }
    graph.nodeMap.forEach((node, value) {
      value.visited = false;
    });
    return descendentList;
  }

  /**
   * check path from child->parent
   * get ancestor list of parent if it contains child then there is path from 
   * child->parent
   */
  bool _checkPath(int childNode, int parentNode) {
    Set<int> parentAncestors = _searchAncestors(parentNode);
    if (parentAncestors.contains(childNode)) return true;
    return false;
  }
}
