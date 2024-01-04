class ResponseModel{
  String _message;
  bool _isSuccess;

  ResponseModel(this._message, this._isSuccess);

  String get message=> _message;
  bool get isSuccess=> _isSuccess;

}