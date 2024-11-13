extension GenericExtension<T> on T {
  /// Returns true if the object is null
  bool get isNull => this == null;

  /// Returns true if the object is not null
  bool get isNotNull => this != null;

  /// Returns true if not empty
  bool get isNotEmpty => this != null && this != '';
}

extension FirstWhereOrNull<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E) test) {
    for (E element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
