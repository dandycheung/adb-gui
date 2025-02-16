extension IterableExt<E> on Iterable<E> {
  E? find(bool Function(E element) test) {
    for (E element in this) {
      if (test(element)) return element;
    }
    return null;
  }

  Iterable<T> mapIndexed<T>(T Function(int index, E element) convert) sync* {
    int index = 0;
    for (E element in this) {
      yield convert(index, element);
      index++;
    }
  }
}
