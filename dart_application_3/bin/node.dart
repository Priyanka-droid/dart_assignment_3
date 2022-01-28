/**
 * Every node has a nodeId(unique), nodeName, childList and parentList
 * and a visited status
 */

class Node {
  late int nodeId;

  late String nodeName;
  bool visited;

  List<int> childrenList;
  List<int> parentList;
  Node(
      {required this.nodeId,
      required this.nodeName,
      required this.childrenList,
      required this.parentList,
      this.visited = false});
}
