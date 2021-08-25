class ResponseProvider<T> {
  Status status;
  T? data;
  String? message;

  ResponseProvider.initial(this.message) : status = Status.INITIAL;

  ResponseProvider.loading(this.message) : status = Status.LOADING;

  ResponseProvider.completed(this.data) : status = Status.COMPLETED;

  ResponseProvider.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { INITIAL, LOADING, COMPLETED, ERROR }