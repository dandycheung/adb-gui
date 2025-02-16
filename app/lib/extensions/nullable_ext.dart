extension NullableExt<T> on T? {
  S? let<S>(S? Function(T value) function) {
    final that = this;
    if (that == null) {
      return null;
    }
    return function(that);
  }
}
