class Observable<T> {
  T _value;

  Observable(this._value);

  final List<void Function(T)> _listeners = [];

  T get value => _value;

  void subscribe(void Function(T) listener) {
    _listeners.add(listener);
  }

  void unsubscribe(void Function(T) listener) {
    _listeners.remove(listener);
  }

  void setValue(T newValue) {
    _value = newValue;

    for (final listener in _listeners) {
      listener(_value);
    }
  }
}