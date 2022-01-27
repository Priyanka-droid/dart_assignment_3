class Node {
  late int nodeId;

  late String nodeName;
  bool visited = false;

  List<int> childrenList = [];
  List<int> parentList = [];
  Node(
      {required nodeId,
      required nodeName,
      required childrenList,
      required parentList,
      visited});
}
