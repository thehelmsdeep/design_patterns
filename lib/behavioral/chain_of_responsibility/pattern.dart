abstract class ChainHandler<T> {
  ChainHandler<T>? next;

  ChainHandler([this.next]);

  Future<bool> handle(T value);

  Future<bool> nextHandle(T value) async {
    return await next?.handle(value) ?? true;
  }
}