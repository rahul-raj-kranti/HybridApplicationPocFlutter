class LogedInUser {
  String _username;
  String _password;

  String _accessToken;
  String _tokenType ;
  String _XContextId;

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  String _XRX;
  String _error;
  String _error_description ;

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get accessToken => _accessToken;

  set accessToken(String value) {
    _accessToken = value;
  }

  String get tokenType => _tokenType;

  set tokenType(String value) {
    _tokenType = value;
  }

  String get XContextId => _XContextId;

  set XContextId(String value) {
    _XContextId = value;
  }

  String get XRX => _XRX;

  set XRX(String value) {
    _XRX = value;
  }

  String get error => _error;

  set error(String value) {
    _error = value;
  }

  String get error_description => _error_description;
  /**
   * @params value.
   *
   * which is geten from api.
   */
  set error_description(String value) {
    _error_description = value;
  }

  // this map requird for SQLlite Db to save user
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = username;
    map["password"] = password;
    map["accessToken"] = accessToken;
    map["tokenType"] = tokenType;
    map["xContextId"] = XContextId;
    map["xRX"] = XRX;

    return map;
  }
}