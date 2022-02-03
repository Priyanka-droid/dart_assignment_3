abstract class InterfaceTask {
  Set<int> getImmediateParents(int nodeId);
  Set<int> getImmediateChildren(int nodeId);
  Set<int> getAncestors(int nodeId);
  Set<int> getDescendents(int nodeId);
  bool deleteDependency(int parentNode, int childNode);
  void deleteNode(int node);
  bool addDependency(int parentNode, int childNode);
  void addNode(int nodeId, String nodeName);
}
