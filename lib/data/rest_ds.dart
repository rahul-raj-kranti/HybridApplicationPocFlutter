import 'dart:async';

import 'package:edumarshal/utils/network_util.dart';
import 'package:edumarshal/models/user.dart';
import 'package:edumarshal/models/user_batch.dart';

class RestDatasource  {
  NetworkUtil _netUtil = new NetworkUtil();
  LogedInUser logedInUser = new LogedInUser();
  UserBatch userbatch = new UserBatch();
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

  //batchHeaders
  Map<String, String> batchHeaders(LogedInUser user) {
    var headers = new Map<String, String>();
    headers["Content-Type"] = "application/x-www-form-urlencoded";
    headers["Authorization"] = "Bearer "+user.accessToken;
    headers["X-ContextId"] = user.XContextId;
    headers["X-RX"] = user.XRX;
    return headers;
  }
  List<String> parsjsonToBatchlist = new List<String>();
  var mapAgainstBatchNameIdPairs = new Map<String, String>();
  // for batch
  Future<UserBatch> getBatch(LogedInUser user) {
    var path = "/api/Batch/" + user.XContextId + "?y=0";
    return _netUtil.get(BASE_URL + path, headers: batchHeaders(user)).then((
        dynamic res) {
      //print("Api Get response:" + res.toString());
      userbatch.batch = res.toString();
      for (var x = 0; x < res.length; x++) {
        var courseName = res[x]["courseName"];
        if (res[x]["batchs"].length > 0) {
          for (var i = x; i < res[x]["batchs"].length; i++) {
            var _batchname = courseName + " " +
                res[x]["batchs"][i]["batchName"];
            var _batchId = res[x]["batchs"][i]["id"];
            parsjsonToBatchlist.add(_batchname);
           // Userbatch.batchList.add(_batchname);
            //mapAgainstBatchNameIdPairs[_batchname] = _batchId;
          }
        }
      }
      userbatch.batchList = parsjsonToBatchlist;
      //print(Userbatch.batchList);
      userbatch.batchId = mapAgainstBatchNameIdPairs.toString();
      return userbatch;
    });
  }
}