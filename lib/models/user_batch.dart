class UserBatch{

  String _batch;

  String get batch => _batch;

  set batch(String value) {
    _batch = value;
  } // this map requird for SQLlite Db to save user

//  String _batchList;
//
//  String get batchList => _batchList;
//
//  set batchList(String value) {
//    _batchList = value;
//  }

  List<String> _batchList;

  List<String> get batchList => _batchList;

  set batchList(List<String> value) {
    _batchList = value;
  }

  String _batchId;

  Map<String, dynamic> batchListMap() {
    var map = new Map<String, dynamic>();
    map["BatchList"] = batchList.toString();
    return map;
  }

  Map<String, dynamic> userBatchMap() {
    var map = new Map<String, dynamic>();
       map["batch"] = batch;
    return map;
  }

  String get batchId => _batchId;

  set batchId(String value) {
    _batchId = value;
  }
}