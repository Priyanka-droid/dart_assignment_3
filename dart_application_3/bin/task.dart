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
    print("Parents of ${nodeId} are:");
    return Graph.instance.nodeMap[nodeId]!.parentList;
  }

  /**
   * validate for given node
   * get children list from given node
   */
  @override
  Set<int> getImmediateChildren(int nodeId) {
    print("children of ${nodeId} are:");
    return Graph.instance.nodeMap[nodeId]!.childrenList;
  }

  /**
   * validate for given node
   * do bfs traversal on given node
   */
  @override
  Set<int> getAncestors(int nodeId) {
    print("ancestors of ${nodeId} are:");
    return _searchAncestors(nodeId);
  }

  /**
   * validate given node
   * do bfs traversal on given node
   */
  @override
  Set<int> getDescendents(int nodeId) {
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
    if (!_dependency(parentNode, childNode)) {
      print("dependency do not exist");
      return false;
    }
    Graph.instance.nodeMap[parentNode]!.childrenList.remove(childNode);
    Graph.instance.nodeMap[childNode]!.parentList.remove(parentNode);

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
    Graph.instance.nodeMap[node]!.parentList.forEach((parent) {
      Graph.instance.nodeMap[parent]!.childrenList.remove(node);
    });
    Graph.instance.nodeMap[node]!.childrenList.forEach((child) {
      Graph.instance.nodeMap[child]!.parentList.remove(node);
    });
    Graph.instance.nodeMap.remove(node);
    print("given node is deleted");
  }

  /**
   * validate nodes
   * check if cycle exist
   * add dependency
   */
  @override
  bool addDependency(int parentNode, int childNode) {
    /**
     *  check for cyclic dependency before adding
     *  check if child->parent exist then don't add the dependency else
     *  add parent->child
     * */
    if (_checkPath(childNode, parentNode)) {
      print("This dependency can't be added because of cycle");
      return false;
    }

    Graph.instance.nodeMap[parentNode]!.childrenList.add(childNode);
    Graph.instance.nodeMap[childNode]!.parentList.add(parentNode);
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
    Set<int> childrenList = {};
    Set<int> parentList = {};
    Node newNode = new Node(
        nodeId: nodeId,
        nodeName: nodeName,
        childrenList: childrenList,
        parentList: parentList);
    Graph.instance.nodeMap[nodeId] = newNode;
  }

  /**
   * check if dependency exist
   */
  bool _dependency(int parentNode, int childNode) {
    bool exist =
        Graph.instance.nodeMap[parentNode]!.childrenList.contains(childNode);
    return exist;
  }

  /**
   * bfs traversal for ancestors
   */
  Set<int> _searchAncestors(int node) {
    Queue<int> nodeQueue = new Queue();
    nodeQueue.add(node);
    Graph.instance.nodeMap[node]!.visited = true;
    Set<int> ancestorList = {};
    while (nodeQueue.isNotEmpty) {
      int nodeAncestor = nodeQueue.removeLast();
      if (nodeAncestor != node) ancestorList.add(nodeAncestor);
      for (int link in Graph.instance.nodeMap[nodeAncestor]!.parentList) {
        if (!Graph.instance.nodeMap[link]!.visited) {
          Graph.instance.nodeMap[link]!.visited = true;
          nodeQueue.add(link);
        }
      }
    }
    Graph.instance.nodeMap.forEach((node, value) {
      value.visited = false;
    });
    return ancestorList;
  }

  /**
   * bfs traversal for descendents
   */
  Set<int> _searchDescendents(int node) {
    Queue<int> nodeQueue = new Queue();
    nodeQueue.add(node);
    Graph.instance.nodeMap[node]!.visited = true;
    Set<int> descendentList = {};
    while (nodeQueue.isNotEmpty) {
      int nodeAncestor = nodeQueue.removeLast();
      if (nodeAncestor != node) descendentList.add(nodeAncestor);
      for (int link in Graph.instance.nodeMap[nodeAncestor]!.childrenList) {
        if (!Graph.instance.nodeMap[link]!.visited) {
          Graph.instance.nodeMap[link]!.visited = true;
          nodeQueue.add(link);
        }
      }
    }
    Graph.instance.nodeMap.forEach((node, value) {
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
