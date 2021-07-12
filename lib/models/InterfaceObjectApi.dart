class InterfaceObjectApi{
  int statusCode;
  bool error;
  String errorMessage;
  dynamic data;
  Map<String, dynamic> json;

  InterfaceObjectApi({ this.statusCode, this.error, this.errorMessage, this.data, this.json });

  @override
  String toString() => this.error == true ? "status: ${this.statusCode} / message: ${this.errorMessage}" : "status: ${this.statusCode} / message: ${this.json}";
}