sealed class Result<T> {}

final class Success<T> extends Result<T> {
  final T data;

  Success(this.data);
}

final class Failure extends Result {
  final Exception exception;

  Failure(this.exception);
}

final class Loading extends Result {}