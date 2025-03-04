class ApiResponse<T> {
  Status status;
  T? data;
  String? message;
  
  ApiResponse.loading() : status = Status.LOADING;
  ApiResponse.completed(this.data) : status = Status.COMPLETED;
  ApiResponse.error(this.message) : status = Status.ERROR;

  // Add initial state
  ApiResponse.initial() : status = Status.INITIAL;

  @override
  String toString() {
    return "Status: $status, Message: $message, Data: $data";
  }
}

enum Status { INITIAL, LOADING, COMPLETED, ERROR }
