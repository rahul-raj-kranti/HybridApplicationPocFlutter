class UserBatch {

  List<String> parsjsonToBatchlist = new List<String>();
  Map batchIdAgainstBatchName = new Map();
  List<String> _batchList;
   Map  _batchId;

  List<String> get batchList => _batchList;

  UserBatch(this._batchList, this._batchId);

  UserBatch.map(dynamic obj) {
          for (var x = 0; x < obj.length; x++) {
        var courseName = obj[x]["courseName"];
        if (obj[x]["batchs"].length > 0) {
          for (var i = x; i < obj[x]["batchs"].length; i++) {
            var _batchName = courseName + " " +
                obj[x]["batchs"][i]["batchName"];
            var _batchId = obj[x]["batchs"][i]["id"];
            parsjsonToBatchlist.add(_batchName);
            batchIdAgainstBatchName[_batchName] =_batchId;

          }
        }
      }
    this._batchList = parsjsonToBatchlist;
    this._batchId = batchIdAgainstBatchName;
  }

  Map get batchId => _batchId;

  Map<String, dynamic> batchListMap() {
    var map = new Map<String, dynamic>();
    map["BatchList"] = batchList.toString();
    map["batch"] = batchId.toString();
    return map;
  }

}
