import 'exception.dart';

import 'node.dart';

class ValidationUtil {
  /**
   * check if given value is natural number
   */
  static bool _nonNatural(String data) {
    bool exceptionFlag = false;
    try {
      int value = int.parse(data);
      if (value <= 0) throw NonNaturalException();
    } catch (e) {
      exceptionFlag = true;
    }
    return exceptionFlag;
  }

  /**
   * check if given value is within range
   */
  static bool _inRange(int option, int rangeStart, int rangeEnd) {
    if (option >= rangeStart && option <= rangeEnd)
      return true;
    else
      return false;
  }

  /**
   * check if given node exist
   */

  /**
   * validate option
   * criteria:
   * 1. Data should not be empty
   * 2. Data should be a natural number
   * 3. Data should be in range
   */
  static bool validateOption(String data, int rangeStart, int rangeEnd) {
    bool exceptionFlag = false;
    try {
      if (data.isEmpty) {
        throw new EmptyStringException();
      }

      if (_nonNatural(data)) {
        throw new NonNaturalException();
      }
      if (!_inRange(int.parse(data), rangeStart, rangeEnd)) {
        throw new NotInRangeException();
      }
    } on FamilyTreeException catch (exception, stackTrace) {
      exceptionFlag = true;
      print(exception.toString());
      print(stackTrace);
    }
    return exceptionFlag;
  }

  /**
   * validate node
   * criteria:
   * 1. Data should not be empty
   * 2. Data should be a natural number
   * 3. Node should already exist
   */
  static bool validateNode(String node) {
    bool exceptionFlag = false;
    try {
      if (node.isEmpty) {
        throw new EmptyStringException();
      }

      if (_nonNatural(node)) {
        throw new NonNaturalException();
      }
    } on FamilyTreeException catch (exception, stackTrace) {
      exceptionFlag = true;
      print(exception.toString());
      print(stackTrace);
    }
    return exceptionFlag;
  }

  /**
   * validate name
   * criteria:
   * 1. Data should not be empty
   */
  static bool validateName(String name) {
    bool exceptionFlag = false;
    try {
      if (name.isEmpty) throw new EmptyStringException();
    } on FamilyTreeException catch (exception, stackTrace) {
      exceptionFlag = true;
      print(exception.toString());
      print(stackTrace);
    }
    return exceptionFlag;
  }
}
