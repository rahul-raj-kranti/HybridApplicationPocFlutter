class User {
  String _username;
  String _password;

//  User(this._username, this._password);

  String access_token = null;
  String token_type = null;
  String X_ContextId = null;
  String X_RX = null;
  String error = null;
  String error_description = null;

  User.map(dynamic obj, _username, _password) {
    this.access_token = obj["access_token"];
    this.token_type = obj["token_type"];
    this.X_ContextId = obj["X-ContextId"];
    this.X_RX = obj["X-RX"];
    this._username = _username;
    this._password = _password;
    this.error = obj["error"];
    this.error_description = obj["error_description"];
  }

//
//  String get username => _username;
//  String get password => _password;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = _username;
    map["password"] = _password;
    map["accessToken"] = access_token;
    map["tokenType"] = token_type;
    map["xContextId"] = X_ContextId;
    map["xRX"] = X_RX;

    return map;
  }
}
