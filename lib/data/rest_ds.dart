import 'dart:async';
import 'dart:convert';
import 'package:edumarshal/utils/network_util.dart';
import 'package:edumarshal/models/user.dart';
import 'package:edumarshal/models/user_batch.dart';
import 'package:edumarshal/models/GetStudentByBatch.dart';
import 'package:edumarshal/models/LeaveEntity.dart';

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

  //batchHeaders
  Map<String, String> batchHeaders(LogedInUser user) {
    var headers = new Map<String, String>();
    headers["Content-Type"] = "application/x-www-form-urlencoded";
    headers["Authorization"] = "Bearer "+user.accessToken;
    headers["X-ContextId"] = user.XContextId;
    headers["X-RX"] = user.XRX;
    return headers;
  }
  // for batch
  Future<UserBatch> getBatch(LogedInUser user) {
    var path = "/api/Batch/" + user.XContextId + "?y=0";
    return _netUtil.get(BASE_URL + path, headers: batchHeaders(user)).then((
        dynamic res) {
      //print("Api Get response:" + res.toString());
      return new UserBatch.map(res);
    });
  }

  // students Details

  Map<String, String> studentsHeaders(LogedInUser user) {
    var headers = new Map<String, String>();
    headers["Content-Type"] = "application/x-www-form-urlencoded";
    headers["Authorization"] = "Bearer "+user.accessToken;
    headers["X-ContextId"] = user.XContextId;
    headers["X-RX"] = user.XRX;
    return headers;
  }
  Future<GetStudentByBatch> getStudentsDetails(LogedInUser user ,var _batchId) {
    var path = "/api/User/GetStudentByBatch/" + _batchId + "?studentByBatch=0";
    return _netUtil.get(BASE_URL + path, headers: studentsHeaders(user)).then((
        dynamic res) {
      print("Api getStudentsDetails response:" + res.toString());
      return new GetStudentByBatch.map(res);
    });
  }


  //post leave
  Future<LeaveEntity> postLeaveRequest(LogedInUser user, Map postDetails) {
    String startDate = postDetails["startDate"];

    return _netUtil
        .post(BASE_URL + "/api/Leave",
        body: {
          "userId": postDetails["userId"],
          "reason": postDetails["reason"],
          "startDate": postDetails["startDate"],
          "endDate": postDetails["endDate"],
        },
        headers: studentsHeaders(user),
        encoding: null)
        .then((dynamic res) {
      print("Api Leave response:" + res.toString());
      return LeaveEntity.map(res);
    });
  }
}