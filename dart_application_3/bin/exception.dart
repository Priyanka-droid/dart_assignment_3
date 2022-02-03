abstract class FamilyTreeException implements Exception {
  final String errorMessage;

  FamilyTreeException(this.errorMessage);

  @override
  String toString() {
    return errorMessage;
  }
}

class EmptyStringException extends FamilyTreeException {
  EmptyStringException() : super("Empty string exception");
}

class NonNumericException extends FamilyTreeException {
  NonNumericException() : super("Non numeric value exception");
}

class NonNaturalException extends FamilyTreeException {
  NonNaturalException() : super("Non natural value exception");
}

class NotInRangeException extends FamilyTreeException {
  NotInRangeException() : super("Value not in range Exception");
}

class NodeNotExistException extends FamilyTreeException {
  NodeNotExistException() : super("Node does not exist exception");
}

class NodeAlreadyExistException extends FamilyTreeException {
  NodeAlreadyExistException() : super("Node already exist exception");
}
