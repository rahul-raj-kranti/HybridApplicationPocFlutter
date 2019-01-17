import 'dart:async';

import 'package:edumarshal/utils/network_util.dart';
import 'package:edumarshal/models/user.dart';

class RestDatasource  {
  NetworkUtil _netUtil = new NetworkUtil();
  LogedInUser logedInUser = new LogedInUser();
  static final BASE_URL = "http://52.187.65.59:88";
  static final grant_type = "password";

  //loginHeaders
  Map<String, String> loginHeaders() {
    var headers = new Map<String, String>();
    headers["Content-Type"] = "application/x-www-form-urlencoded";
    return headers;
  }

  /**
   * This method call the login api and performe login task
   *
   * @params username, password.
   *
   * @return logedInUser
   *
   */
  Future<LogedInUser> login(String username, String password) {
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
//making user object using api response
        logedInUser.username = username;
        logedInUser.password = password;
        logedInUser.accessToken = res["access_token"];
        logedInUser.tokenType = res["token_type"];
        logedInUser.XContextId = res["X-ContextId"];
        logedInUser.XRX = res["X-RX"];
        logedInUser.error_description = res["error_description"];
        logedInUser.error = res["error"];

      return logedInUser;
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