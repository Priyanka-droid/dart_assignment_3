import 'package:test/test.dart';
import "../bin/node.dart";
import "../bin/task.dart";

void main() {
  /**
   * test for immediate parents
   */
  group("immediate parents", () {
    /**
   * test for nodes which have parents
   */
    test('nodes having parents', () {
      Map<int, Node> nodeMap = new Map();
      nodeMap[1] = new Node(
          nodeId: 1,
          nodeName: "node1",
          parentList: [],
          childrenList: [2],
          visited: false);
      nodeMap[2] = new Node(
          nodeId: 2,
          nodeName: "node2",
          parentList: [1],
          childrenList: [3],
          visited: false);
      nodeMap[3] = new Node(
          nodeId: 3,
          nodeName: "node3",
          parentList: [2, 4],
          childrenList: [5, 6],
          visited: false);
      nodeMap[4] = new Node(
          nodeId: 4,
          nodeName: "node4",
          parentList: [],
          childrenList: [3],
          visited: false);
      nodeMap[5] = new Node(
          nodeId: 5,
          nodeName: "node5",
          parentList: [3],
          childrenList: [],
          visited: false);
      nodeMap[6] = new Node(
          nodeId: 6,
          nodeName: "node6",
          parentList: [3],
          childrenList: [],
          visited: false);
      List<int> parentList = Task.getImmediateParents(nodeMap, 3);
      parentList.sort();
      expect(parentList, [2, 4]);
    });
    test('nodes having no parents', () {
      Map<int, Node> nodeMap = new Map();
      nodeMap[1] = new Node(
          nodeId: 1,
          nodeName: "node1",
          parentList: [],
          childrenList: [2],
          visited: false);
      nodeMap[2] = new Node(
          nodeId: 2,
          nodeName: "node2",
          parentList: [1],
          childrenList: [],
          visited: false);
      List<int> parentList = Task.getImmediateParents(nodeMap, 1);
      parentList.sort();
      expect(parentList, []);
    });
  });

  group("immediate children", () {
    test('nodes having children', () {
      Map<int, Node> nodeMap = new Map();
      nodeMap[1] = new Node(
          nodeId: 1,
          nodeName: "node1",
          parentList: [],
          childrenList: [2],
          visited: false);
      nodeMap[2] = new Node(
          nodeId: 2,
          nodeName: "node2",
          parentList: [1],
          childrenList: [3],
          visited: false);
      nodeMap[3] = new Node(
          nodeId: 3,
          nodeName: "node3",
          parentList: [2, 4],
          childrenList: [5, 6],
          visited: false);
      nodeMap[4] = new Node(
          nodeId: 4,
          nodeName: "node4",
          parentList: [],
          childrenList: [3],
          visited: false);
      nodeMap[5] = new Node(
          nodeId: 5,
          nodeName: "node5",
          parentList: [3],
          childrenList: [],
          visited: false);
      nodeMap[6] = new Node(
          nodeId: 6,
          nodeName: "node6",
          parentList: [3],
          childrenList: [],
          visited: false);
      List<int> childrenList = Task.getImmediateChildren(nodeMap, 3);
      childrenList.sort();
      expect(childrenList, [5, 6]);
    });
    test('nodes having no children', () {
      Map<int, Node> nodeMap = new Map();
      nodeMap[1] = new Node(
          nodeId: 1,
          nodeName: "node1",
          parentList: [],
          childrenList: [2],
          visited: false);
      nodeMap[2] = new Node(
          nodeId: 2,
          nodeName: "node2",
          parentList: [1],
          childrenList: [],
          visited: false);
      List<int> childrenList = Task.getImmediateChildren(nodeMap, 2);
      childrenList.sort();

      expect(childrenList, []);
    });
  });
  group("ancestors", () {
    test('nodes having ancestors', () {
      Map<int, Node> nodeMap = new Map();
      nodeMap[1] = new Node(
          nodeId: 1,
          nodeName: "node1",
          parentList: [],
          childrenList: [2],
          visited: false);
      nodeMap[2] = new Node(
          nodeId: 2,
          nodeName: "node2",
          parentList: [1],
          childrenList: [3],
          visited: false);
      nodeMap[3] = new Node(
          nodeId: 3,
          nodeName: "node3",
          parentList: [2, 4],
          childrenList: [5, 6],
          visited: false);
      nodeMap[4] = new Node(
          nodeId: 4,
          nodeName: "node4",
          parentList: [],
          childrenList: [3],
          visited: false);
      nodeMap[5] = new Node(
          nodeId: 5,
          nodeName: "node5",
          parentList: [3],
          childrenList: [],
          visited: false);
      nodeMap[6] = new Node(
          nodeId: 6,
          nodeName: "node6",
          parentList: [3],
          childrenList: [],
          visited: false);
      List<int> ancestorList = Task.getAncestors(nodeMap, 5);
      ancestorList.sort();
      expect(ancestorList, [1, 2, 3, 4]);
    });
  });
  group("descendents", () {
    test('nodes having descendents', () {
      Map<int, Node> nodeMap = new Map();
      nodeMap[1] = new Node(
          nodeId: 1,
          nodeName: "node1",
          parentList: [],
          childrenList: [2],
          visited: false);
      nodeMap[2] = new Node(
          nodeId: 2,
          nodeName: "node2",
          parentList: [1],
          childrenList: [3],
          visited: false);
      nodeMap[3] = new Node(
          nodeId: 3,
          nodeName: "node3",
          parentList: [2, 4],
          childrenList: [5, 6],
          visited: false);
      nodeMap[4] = new Node(
          nodeId: 4,
          nodeName: "node4",
          parentList: [],
          childrenList: [3],
          visited: false);
      nodeMap[5] = new Node(
          nodeId: 5,
          nodeName: "node5",
          parentList: [3],
          childrenList: [],
          visited: false);
      nodeMap[6] = new Node(
          nodeId: 6,
          nodeName: "node6",
          parentList: [3],
          childrenList: [],
          visited: false);
      List<int> descendentList = Task.getDescendents(nodeMap, 1);
      descendentList.sort();
      expect(descendentList, [2, 3, 5, 6]);
    });
  });
  group("delete dependency", () {
    test('nodes having dependency', () {
      Map<int, Node> nodeMap = new Map();
      nodeMap[1] = new Node(
          nodeId: 1,
          nodeName: "node1",
          parentList: [],
          childrenList: [2],
          visited: false);
      nodeMap[2] = new Node(
          nodeId: 2,
          nodeName: "node2",
          parentList: [1],
          childrenList: [3],
          visited: false);
      nodeMap[3] = new Node(
          nodeId: 3,
          nodeName: "node3",
          parentList: [2, 4],
          childrenList: [5, 6],
          visited: false);
      nodeMap[4] = new Node(
          nodeId: 4,
          nodeName: "node4",
          parentList: [],
          childrenList: [3],
          visited: false);
      nodeMap[5] = new Node(
          nodeId: 5,
          nodeName: "node5",
          parentList: [3],
          childrenList: [],
          visited: false);
      nodeMap[6] = new Node(
          nodeId: 6,
          nodeName: "node6",
          parentList: [3],
          childrenList: [],
          visited: false);
      bool deleted = Task.deleteDependency(nodeMap, 1, 2);

      expect(deleted, true);
    });
    test('nodes having no dependency', () {
      Map<int, Node> nodeMap = new Map();
      nodeMap[1] = new Node(
          nodeId: 1,
          nodeName: "node1",
          parentList: [],
          childrenList: [2],
          visited: false);
      nodeMap[2] = new Node(
          nodeId: 2,
          nodeName: "node2",
          parentList: [1],
          childrenList: [3],
          visited: false);
      nodeMap[3] = new Node(
          nodeId: 3,
          nodeName: "node3",
          parentList: [2, 4],
          childrenList: [5, 6],
          visited: false);
      nodeMap[4] = new Node(
          nodeId: 4,
          nodeName: "node4",
          parentList: [],
          childrenList: [3],
          visited: false);
      nodeMap[5] = new Node(
          nodeId: 5,
          nodeName: "node5",
          parentList: [3],
          childrenList: [],
          visited: false);
      nodeMap[6] = new Node(
          nodeId: 6,
          nodeName: "node6",
          parentList: [3],
          childrenList: [],
          visited: false);
      bool deleted = Task.deleteDependency(nodeMap, 1, 6);

      expect(deleted, false);
    });
  });
  group("add dependency", () {
    test('when no cycle', () {
      Map<int, Node> nodeMap = new Map();
      nodeMap[1] = new Node(
          nodeId: 1,
          nodeName: "node1",
          parentList: [],
          childrenList: [2],
          visited: false);
      nodeMap[2] = new Node(
          nodeId: 2,
          nodeName: "node2",
          parentList: [1],
          childrenList: [3],
          visited: false);
      nodeMap[3] = new Node(
          nodeId: 3,
          nodeName: "node3",
          parentList: [2, 4],
          childrenList: [5, 6],
          visited: false);
      nodeMap[4] = new Node(
          nodeId: 4,
          nodeName: "node4",
          parentList: [],
          childrenList: [3],
          visited: false);
      nodeMap[5] = new Node(
          nodeId: 5,
          nodeName: "node5",
          parentList: [3],
          childrenList: [],
          visited: false);
      nodeMap[6] = new Node(
          nodeId: 6,
          nodeName: "node6",
          parentList: [3],
          childrenList: [],
          visited: false);
      bool added = Task.addDependency(nodeMap, 1, 4);

      expect(added, true);
    });
    test('when cycle', () {
      Map<int, Node> nodeMap = new Map();
      nodeMap[1] = new Node(
          nodeId: 1,
          nodeName: "node1",
          parentList: [],
          childrenList: [2],
          visited: false);
      nodeMap[2] = new Node(
          nodeId: 2,
          nodeName: "node2",
          parentList: [1],
          childrenList: [3],
          visited: false);
      nodeMap[3] = new Node(
          nodeId: 3,
          nodeName: "node3",
          parentList: [2, 4],
          childrenList: [5, 6],
          visited: false);
      nodeMap[4] = new Node(
          nodeId: 4,
          nodeName: "node4",
          parentList: [],
          childrenList: [3],
          visited: false);
      nodeMap[5] = new Node(
          nodeId: 5,
          nodeName: "node5",
          parentList: [3],
          childrenList: [],
          visited: false);
      nodeMap[6] = new Node(
          nodeId: 6,
          nodeName: "node6",
          parentList: [3],
          childrenList: [],
          visited: false);
      bool added = Task.addDependency(nodeMap, 3, 1);

      expect(added, false);
    });
  });
}
