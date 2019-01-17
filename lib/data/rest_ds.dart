import 'dart:async';

import 'package:edumarshal/utils/network_util.dart';
import 'package:edumarshal/models/user.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "http://52.187.65.59:88";
  static final grant_type = "password";

  //loginHeaders
  Map<String, String> loginHeaders() {
    var headers = new Map<String, String>();
    headers["Content-Type"] = "application/x-www-form-urlencoded";
    return headers;
  }

  // for login
  Future<User> login(String username, String password) {
    return _netUtil
        .post(BASE_URL + "/Token",
        body: {
          "grant_type": grant_type,
          "username": "admin@lancersconvent.net",
          "password": password
        },
        headers: loginHeaders(),
        encoding: null)
        .then((dynamic res) {
      print("Api response:" + res.toString());
      //if (res["access_token"] == null) throw new Exception(res["error"]);
      return new User.map(res, username, password);
    });
  }

//  //batchHeaders
//  Map<String, String> batchHeaders(User user) {
//    var headers = new Map<String, String>();
//    headers["Content-Type"] = "application/x-www-form-urlencoded";
//    headers["Authorization"] = user.access_token;
//    return headers;
//  }
//
//  // for batch
//  Future<Batch> getBatch(user ) {
//    var path = "/api/Batch/" + user.xContextId + "?y=0";
//    return _netUtil.get(BASE_URL + path, headers: batchHeaders(user)).then((
//        dynamic res) {
//      print("Api response:" + res.toString());
//      //if (res["access_token"] == null) throw new Exception(res["error"]);
//      return new Batch.map(res);
//    });
//  }
}