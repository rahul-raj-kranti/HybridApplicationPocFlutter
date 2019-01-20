class LeaveEntity{

  String _userId;
  String _startDate;
  String _id;


  String get id => _id;

  LeaveEntity(this._id, this._userId, this._startDate, this._endDate,
      this._reasonForLeave);

  LeaveEntity.map(dynamic obj)  {


      this._startDate = obj["startDate"];
      this._endDate = obj["endDate"];
      this._reasonForLeave = obj["reason"];
      this._id = obj["id"].toString();
      this._userId = obj["userId"].toString();
  }

  String _endDate;

  String _reasonForLeave;

  String get userId => _userId;

  String get startDate => _startDate;

  String get endDate => _endDate;

  String get reasonForLeave => _reasonForLeave;


}